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
import domain.BilledSupply;
import domain.PermissionsList;
import domain.User;

/**
 * Servlet implementation class PatientSuppliesReportServlet
 */
@WebServlet(description = "servlet to patient supplies report", urlPatterns = { "/PatientSuppliesReportServlet" })
public class PatientSuppliesReportServlet extends HttpServlet {	
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
    public PatientSuppliesReportServlet() {
        super();
    }
    
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		boolean perm1 = PermissionsList.hasPermission(request, PermissionsList.pharmacyReport);
		
		if(userE != null && (perm || perm1)){
			try {		
				Long section = request.getParameter("sec") != null ? Long.parseLong(request.getParameter("sec")) : null;
				request.setAttribute("sec", section);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_patientsupplies.jsp");
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
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		boolean perm1 = PermissionsList.hasPermission(request, PermissionsList.pharmacyReport);
		
		if(userE != null && (perm || perm1)){	
			String from 	= request.getParameter("from");
			String to	 	= request.getParameter("to");
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<BilledSupply> pp = (ArrayList<BilledSupply>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientSuppliesReport(from, to));
				request.setAttribute("pp", pp);
				
				request.setAttribute("from", from);
				request.setAttribute("to", to);

				Long section = request.getParameter("sec").equals("null") ? null : Long.parseLong(request.getParameter("sec"));
				request.setAttribute("sec", section);
								
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_patientsupplies.jsp");
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
