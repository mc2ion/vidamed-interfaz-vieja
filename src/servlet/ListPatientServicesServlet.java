package servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.PatientService;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListPatientServicesServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListPatientServicesServlet" })
public class ListPatientServicesServlet extends HttpServlet {
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
    public ListPatientServicesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.bloodBank);
		boolean perm2  = PermissionsList.hasPermission(request, PermissionsList.eco);
		boolean perm3  = PermissionsList.hasPermission(request, PermissionsList.lab);
		boolean perm4  = PermissionsList.hasPermission(request, PermissionsList.rayX);
		
		if(userE != null && (perm || perm2 || perm3 || perm4) ){
			try {
				Long id = Long.parseLong(request.getParameter("id"));
				Long servId = Long.parseLong(request.getParameter("servId"));
				Properties propertiesFile = new Properties();
				propertiesFile.load( new FileInputStream( getServletContext().getInitParameter("properties") ) );
				String function = "", scaleId = "";
				if (servId == 1) {
					function = "ListBloodBankServlet";
					scaleId = propertiesFile.getProperty("bloodBank");
				} else if (servId == 2) {
					function = "ListEcoServlet";
					scaleId = propertiesFile.getProperty("eco");
				} else if (servId == 3) {
					function = "ListLabServlet";
					scaleId = propertiesFile.getProperty("lab");
				} else if (servId == 4) {
					function = "ListXRayReportsServlet";
					scaleId = propertiesFile.getProperty("xRay");
				}
				
				String name = request.getParameter("name");
				ArrayList<PatientService> services = (ArrayList<PatientService>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientServicesByAdmission(id, servId));
				request.setAttribute("patName", name);
				request.setAttribute("function", function);
				request.setAttribute("services", services);
				request.setAttribute("servId", String.valueOf(servId));
				request.setAttribute("adminId", String.valueOf(id));
				request.setAttribute("scaleId", scaleId);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/patientServices.jsp");
				rd.forward(request, response);
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
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
		doGet(request, response);
	}
}
