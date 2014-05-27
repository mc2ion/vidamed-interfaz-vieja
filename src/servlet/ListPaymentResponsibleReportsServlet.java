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
import domain.BussinessRules;
import domain.PermissionsList;
import domain.User;
import domain.UserReport;


/**
 * Servlet implementation class ListInterServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListPaymentResponsibleReportsServlet" })
public class ListPaymentResponsibleReportsServlet extends HttpServlet {
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
    public ListPaymentResponsibleReportsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		if(userE != null && perm ){
			try {
				@SuppressWarnings("unchecked")
				ArrayList<UserReport> pp = (ArrayList<UserReport>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibleReport());
				
				@SuppressWarnings("unchecked")
				ArrayList<BussinessRules> br = (ArrayList<BussinessRules>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessRules());
				
				request.setAttribute("pp", pp);
				request.setAttribute("br", br);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_paymentR.jsp");
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
		
		if(userE != null && perm ){
    		String name 	  = request.getParameter("name");
			String g 	  	  = request.getParameter("br");
			String bRule = null;
			if (!g.equals("-"))
				bRule = g;
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<UserReport> pp = (ArrayList<UserReport>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibleReport(name, bRule));
				@SuppressWarnings("unchecked")
				ArrayList<BussinessRules> br = (ArrayList<BussinessRules>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessRules());
				
				request.setAttribute("pp", pp);
				request.setAttribute("br", br);
				request.setAttribute("name", name);
				request.setAttribute("bRule", bRule);

				RequestDispatcher rd;			
				rd = getServletContext().getRequestDispatcher("/reports_paymentR.jsp");
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
