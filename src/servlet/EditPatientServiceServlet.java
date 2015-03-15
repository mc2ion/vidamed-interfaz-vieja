package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;

import command.CommandExecutor;
import domain.PatientService;
import domain.PermissionsList;
import domain.User;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import java.util.Properties;

/**
 * Servlet implementation class EditPatientServiceServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditPatientServiceServlet" })
public class EditPatientServiceServlet extends HttpServlet {
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
    public EditPatientServiceServlet() {
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
				String id				= request.getParameter("id");
				String servId 			= request.getParameter("servId");
				String name   			= request.getParameter("name");
				String servicePatientId = request.getParameter("spId");
				
				request.setAttribute("servId", servId);
				request.setAttribute("adminId", id);
				request.setAttribute("name", name);
				
				PatientService pSupply = (PatientService) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientService(Long.valueOf(servicePatientId)));
			
				request.setAttribute("pSupply", pSupply);
				rd = getServletContext().getRequestDispatcher("/editPatientService.jsp");			
				rd.forward(request, response);
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
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
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.bloodBank);
		boolean perm2  = PermissionsList.hasPermission(request, PermissionsList.eco);
		boolean perm3  = PermissionsList.hasPermission(request, PermissionsList.lab);
		boolean perm4  = PermissionsList.hasPermission(request, PermissionsList.rayX);
		
		if(userE != null && (perm || perm2 || perm3 || perm4) ){
		
			try{			
				propertiesFile.load( new FileInputStream( getServletContext().getInitParameter("properties") ) );
				MultipartRequest multipart = new MultipartRequest(request, propertiesFile.getProperty("filesDirectory"), 4*1024*1024, new DefaultFileRenamePolicy());
	
				File file 				= multipart.getFile("file");
				File report 			= multipart.getFile("report");
				Long admisId 			= Long.valueOf(multipart.getParameter("admissionId"));
				String name 		 	= multipart.getParameter("name");
				Long servicePatientId 	= Long.valueOf(multipart.getParameter("spId"));
				String oldFile 			= multipart.getParameter("oldFile");
				String oldReport		= multipart.getParameter("oldReport");
				String 	sId				= multipart.getParameter("servId");
				String album			= "";
				
				if (sId.equals("1"))
					album ="Banco";
				else if (sId.equals("2"))
					album ="Eco";
				else if (sId.equals("3"))
					album ="Lab";
				else if (sId.equals("4"))
					album ="Ray";
				
				String dir = propertiesFile.getProperty("filesDirectory" + album) + propertiesFile.getProperty("fileSeparator");
				String fileName 		= oldFile;

				if (file != null){					
					//Eliminar archivo anterior
					if (!oldFile.equals("null")){
						File dFile = new File(dir + oldFile);
						 
			    		if(dFile.delete()){
			    			System.out.println(dFile.getName() + " is deleted!");
			    		}else{
			    			System.out.println("Delete operation is failed.");
			    		}
					}
					
					fileName = file.getName();						
					fileName = servicePatientId + "_file." + FilenameUtils.getExtension(fileName);					
					File destination = new File(dir + fileName);
					file.renameTo(destination);
				}
				
				String reportName = oldReport;
				
				if(report != null){					
					//Eliminar reporte anterior
					if(!oldReport.equals("null")){
						File dFile = new File(dir + oldReport);
						
						if(dFile.delete()){
			    			System.out.println(dFile.getName() + " is deleted!");
			    		}else{
			    			System.out.println("Delete operation is failed.");
			    		}
					}
					
					reportName = report.getName();
					reportName = servicePatientId + "_report." + FilenameUtils.getExtension(reportName);
					File destination = new File(dir + reportName);
					report.renameTo(destination);
				}
				
				Long result = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPatientService(servicePatientId, fileName, reportName));
				String text = "El servicio fue editado exitosamente";
				if (result == -1)
					text =	"Hubo un problema al editar al servicio. Por favor, intente nuevamente.";
				
				String command = "cmd /C start /I /MIN /WAIT " + propertiesFile.getProperty("syncBatchFile");
				Runtime.getRuntime().exec(command);
				
				session.setAttribute("text", text);
				System.out.println("/ListPatientServicesServlet?id=" + admisId + "&servId=" + sId + "&name=" + name);
				response.sendRedirect(request.getContextPath() + "/ListPatientServicesServlet?id=" + admisId + "&servId=" + sId + "&name=" + name);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}	
	}
}
