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

import domain.Patient;
import domain.PermissionsList;
import domain.User;

/**
 * Servlet implementation class ListPatientsServlet
 */
@WebServlet(description = "servlet to get the list of patients", urlPatterns = { "/ListPatientsServlet" })
public class ListPatientsServlet extends HttpServlet {

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
    public ListPatientsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.patient);
		if(userE != null && perm ){
			RequestDispatcher rd;
			
			//ArrayList<Patient> patients;
			try {
				//patients = (ArrayList<Patient>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatients());
				request.setAttribute("patients",  new ArrayList<Patient>());

				rd = getServletContext().getRequestDispatcher("/patients.jsp");
				rd.forward(request, response);
			
			} catch (Exception e) {
				request.setAttribute("patients", new ArrayList<Patient>());
				rd = getServletContext().getRequestDispatcher("/patients.jsp");
				rd.forward(request, response);
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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.patient);
		
		if(userE != null && perm ){
			String patientname		= request.getParameter("patientname");
			String num				= request.getParameter("txtCedIdNum");
			String identityCard 	= "";
			if (num != null && num != "")
				identityCard = request.getParameter("txtCedId") + num;
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<Patient> pp = (ArrayList<Patient>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatients(patientname, identityCard));
				
				request.setAttribute("patients", pp);
				
				request.setAttribute("patientname", patientname);
				request.setAttribute("identitycard", identityCard);				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/patients.jsp");
				rd.forward(request, response);
			} 
			catch (Exception e) {
				throw new ServletException(e);
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
