package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;

import command.CommandExecutor;
import domain.PermissionsList;
import domain.Service;
import domain.User;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;










import java.util.Properties;
/**
 * Servlet implementation class AddPatientServiceServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AddPatientServiceServlet" })
public class AddPatientServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public void init() throws ServletException {
		super.init();
		try {
			CommandExecutor.getInstance();
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPatientServiceServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.bloodBank);
		boolean perm2  = PermissionsList.hasPermission(request, PermissionsList.eco);
		boolean perm3  = PermissionsList.hasPermission(request, PermissionsList.lab);
		boolean perm4  = PermissionsList.hasPermission(request, PermissionsList.rayX);
		
		if(userE != null && (perm || perm2 || perm3 || perm4) ){
			RequestDispatcher rd;
		
			try {
				String id = request.getParameter("id");
				String sec = request.getParameter("sec");
				String servId = request.getParameter("servId");
				String name   = request.getParameter("name");
				Long scaleId = Long.valueOf(request.getParameter("scaleId"));
				
				request.setAttribute("servId", servId);
				request.setAttribute("adminId", id);
				request.setAttribute("name", name);
				request.setAttribute("sec", sec);
				request.setAttribute("scaleId", scaleId);
				
				if(sec != null && sec.equalsIgnoreCase("add")){
					Long serviceId = Long.valueOf(request.getParameter("spId"));
					String serviceName = request.getParameter("spName");
					Service service = new Service();
					
					service.setServiceID(serviceId);
					service.setName(serviceName);
					
					request.setAttribute("service", service);
				} else {
					@SuppressWarnings("unchecked")
					ArrayList<Service> services = (ArrayList<Service>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetServicesByType(Long.valueOf(servId)));
				
					request.setAttribute("services", services);
				}
				
				rd = getServletContext().getRequestDispatcher("/addPatientService.jsp");			
				rd.forward(request, response);
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Properties propertiesFile = new Properties();
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
		
			try{			
				propertiesFile.load( new FileInputStream( getServletContext().getInitParameter("properties") ) );
				MultipartRequest multipart = new MultipartRequest(request, propertiesFile.getProperty("filesDirectory"), 4*1024*1024, new DefaultFileRenamePolicy());
				File file = multipart.getFile("file");
				File report = multipart.getFile("report");
				Long servAddId 	= Long.valueOf(multipart.getParameter("service"));
				Long admisId 	= Long.valueOf(multipart.getParameter("admissionId"));
				String name 	= multipart.getParameter("name");				
				String 	sId		= multipart.getParameter("servId");
				String album	= "";
				Long scaleId	= Long.valueOf(multipart.getParameter("scaleId"));
				String sec = multipart.getParameter("sec");

				if (sId.equals("1"))
						album ="Banco";
					else if (sId.equals("2"))
						album ="Eco";
					else if (sId.equals("3"))
						album ="Lab";
					else if (sId.equals("4"))
						album ="Ray";
				
				String dir = propertiesFile.getProperty("filesDirectory" + album) + propertiesFile.getProperty("fileSeparator");
				String fileName = null;				
				String reportName = null;

				if(sec!=null && sec.equalsIgnoreCase("add")){
					CommandExecutor.getInstance().executeDatabaseCommand(new command.ApplyPatientEstimationService(admisId, scaleId, servAddId));
				}
				
				Long result = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientService(admisId, servAddId, scaleId));
				String text = "El servicio fue agregado exitosamente";

				if (result == -1) {
					text =	"Hubo un problema al agregar al servicio. Por favor, intente nuevamente.";
				} else {
					
					if (file != null){					
						fileName = file.getName();	
						fileName = result + "_file." + FilenameUtils.getExtension(fileName);
						File destination = new File(dir + fileName);
						file.renameTo(destination);
					}	
					
					if(report != null){
						reportName = report.getName();
						reportName = result + "_report." + FilenameUtils.getExtension(reportName);
						File destination = new File(dir + reportName);
						report.renameTo(destination);
					}
					
					result = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPatientService(result, fileName, reportName));
					if (result == -1)
						text =	"Hubo un problema agregando las imágenes. Por favor, intente nuevamente.";
					
					String command = "cmd /C start /I /MIN /WAIT " + propertiesFile.getProperty("syncBatchFile");
					Runtime.getRuntime().exec(command);
				}				
				
				session.setAttribute("text", text);
				if(sec != null && (sec.equalsIgnoreCase("add"))) {
					response.sendRedirect(request.getContextPath() + "/ListPatientEstimationServicesServlet?id=" + admisId + "&servId=" + sId + "&name=" + name);
				}else{
					response.sendRedirect(request.getContextPath() + "/ListPatientServicesServlet?id=" + admisId + "&servId=" + sId + "&name=" + name);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
	}
}
