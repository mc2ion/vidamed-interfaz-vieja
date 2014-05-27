package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
				String servId = request.getParameter("servId");
				String name   = request.getParameter("name");
				
				request.setAttribute("servId", servId);
				request.setAttribute("adminId", id);
				request.setAttribute("name", name);
				
				@SuppressWarnings("unchecked")
				ArrayList<Service> services = (ArrayList<Service>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetServicesByType(Long.valueOf(servId)));
			
				request.setAttribute("services", services);
				
				rd = getServletContext().getRequestDispatcher("/addPatientService.jsp");			
				rd.forward(request, response);
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
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
				Long servAddId 	= Long.valueOf(multipart.getParameter("service"));
				Long admisId 	= Long.valueOf(multipart.getParameter("admissionId"));
				 String name 	= multipart.getParameter("name");
				
				
				String 	sId		= multipart.getParameter("servId");
				String album	= "";
				String fileName = null;
				if (file != null){
					fileName = file.getName();
					
					if (sId.equals("1"))
						album ="Banco";
					else if (sId.equals("2"))
						album ="Eco";
					else if (sId.equals("3"))
						album ="Lab";
					else if (sId.equals("4"))
						album ="Ray";
				
					String dir = propertiesFile.getProperty("filesDirectory" + album) + propertiesFile.getProperty("fileSeparator");
	
					Date d = Calendar.getInstance().getTime(); // Current time
					SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy"); // Set your date format
					String currentData = sdf.format(d);
					
					fileName = currentData + "_" + admisId  + "_" + fileName.toLowerCase().replace(" ", "_");
					File destination = new File(dir + fileName);
					file.renameTo(destination);
				}	
				Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientService(admisId, servAddId, fileName));
				String text = "El servicio fue agregado exitosamente";
				if (result == 0)
					text =	"Hubo un problema al agregar al servicio. Por favor, intente nuevamente.";
				
				session.setAttribute("text", text);
				System.out.println("/ListPatientServicesServlet?id=" + admisId + "&servId=" + sId + "&name=" + name);
				response.sendRedirect(request.getContextPath() + "/ListPatientServicesServlet?id=" + admisId + "&servId=" + sId + "&name=" + name);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
	}
}
