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

import command.CommandExecutor;
import domain.PatientService;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;







import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Properties propertiesFile = new Properties();
		HttpSession session = request.getSession(false);
		try{			
			propertiesFile.load( new FileInputStream( getServletContext().getInitParameter("properties") ) );
			MultipartRequest multipart = new MultipartRequest(request, propertiesFile.getProperty("filesDirectory"), 4*1024*1024, new DefaultFileRenamePolicy());

			File file 				= multipart.getFile("file");
			Long admisId 			= Long.valueOf(multipart.getParameter("admissionId"));
			String name 		 	= multipart.getParameter("name");
			Long servicePatientId 	= Long.valueOf(multipart.getParameter("spId"));
			String oldFile 			= multipart.getParameter("oldFile");
			String 	sId				= multipart.getParameter("servId");
			String album			= "";
			String fileName 		= null;
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
				
				//Eliminar archivo anterior
				if (!oldFile.equals("null")){
					File dFile = new File(dir + oldFile);
					 
		    		if(dFile.delete()){
		    			System.out.println(dFile.getName() + " is deleted!");
		    		}else{
		    			System.out.println("Delete operation is failed.");
		    		}
				}
			}	
			Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPatientService(servicePatientId, fileName));
			String text = "El servicio fue editado exitosamente";
			if (result == 0)
				text =	"Hubo un problema al editar al servicio. Por favor, intente nuevamente.";
			
			session.setAttribute("text", text);
			System.out.println("/ListPatientServicesServlet?id=" + admisId + "&servId=" + sId + "&name=" + name);
			response.sendRedirect(request.getContextPath() + "/ListPatientServicesServlet?id=" + admisId + "&servId=" + sId + "&name=" + name);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
