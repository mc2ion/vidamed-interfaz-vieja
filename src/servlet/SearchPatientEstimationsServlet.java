package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.Estimation;
import domain.PermissionsList;
import domain.User;



/**
 * Servlet implementation class SearchPatientServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/SearchPatientEstimationsServlet" })
public class SearchPatientEstimationsServlet extends HttpServlet {
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
    public SearchPatientEstimationsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//RequestDispatcher rd;
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.admission);
		if(userE != null && perm ){
	
			String patientid 	= request.getParameter("patientID");
			String ced 			= request.getParameter("txtCedNumber");
			String name 		= request.getParameter("txtName");
			String lastname 	= request.getParameter("txtLastName");	
			String txtPatientType 	= request.getParameter("txtPatientType");
			
			
					
			
				
			System.out.println("patientid " + patientid);
			//String cedNum 		= request.getParameter("txtCedIdNum"); 
			//String identityCard = cedType + cedNum;
			try {
				@SuppressWarnings("unchecked")
				ArrayList<Estimation> p = (ArrayList<Estimation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientEstimations(Long.valueOf(patientid)));
				
				request.setAttribute("estimations", p);
				request.setAttribute("patientID", patientid);
				request.setAttribute("txtCedNumber", ced);
				request.setAttribute("txtName", name);
				request.setAttribute("txtLastName", lastname);
				request.setAttribute("txtPatientType", txtPatientType);
						
				RequestDispatcher rd;			
				rd = getServletContext().getRequestDispatcher("/selectPatientEstimation.jsp");
				rd.forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
