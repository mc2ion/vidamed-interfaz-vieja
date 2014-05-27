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
import domain.PatientServiceReport;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListLabReportsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListLabReportsServlet" })
public class ListLabReportsServlet extends HttpServlet {
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
    public ListLabReportsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		
		if(userE != null && perm){
			try {
				ArrayList<PatientServiceReport> pp = (ArrayList<PatientServiceReport>) CommandExecutor.getInstance().executeDatabaseCommand(
														new command.GetPatientServiceReport("3"));
				request.setAttribute("pp", pp);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_lab.jsp");
				rd.forward(request, response);
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		}else if (userE == null){
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}else{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
			rd.forward(request, response);
			
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		
		if(userE != null && perm ){
    		String dateIni 	  	= request.getParameter("txtDateIni");
			String dateEnd 	  	= request.getParameter("txtDateEnd");
			String adminId  	= request.getParameter("admin");
			String serviceId    = request.getParameter("service");
			String estimationId = request.getParameter("estimation");
			String identityCard = request.getParameter("identityCard");
			String typ   		= request.getParameter("type");
			String type = null;
			if (!typ.equals("-"))
				type = typ;
			String g 	  	  	= request.getParameter("gender");
			String gender = null;
			if (!g.equals("-"))
				gender = g;
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<PatientServiceReport> pp = (ArrayList<PatientServiceReport>) CommandExecutor.getInstance().executeDatabaseCommand(
										new command.GetPatientServiceReport("3", adminId, estimationId, identityCard, gender, type, serviceId, dateIni, dateEnd));
				request.setAttribute("pp", pp);
				RequestDispatcher rd;			
				request.setAttribute("dateIni", dateIni);
				request.setAttribute("dateEnd", dateEnd);
				request.setAttribute("adminId", adminId);
				request.setAttribute("serviceId", serviceId);
				request.setAttribute("estimationId", estimationId);
				request.setAttribute("identityCard", identityCard);
				request.setAttribute("type", type);
				request.setAttribute("gender", gender);
				
				rd = getServletContext().getRequestDispatcher("/reports_lab.jsp");
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
