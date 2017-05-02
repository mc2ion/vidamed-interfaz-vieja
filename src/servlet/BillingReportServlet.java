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
import domain.Invoice;
import domain.PermissionsList;
import domain.User;

/**
 * Servlet implementation class BillingReportServlet
 */
@WebServlet(description = "servlet to monthly billing reports", urlPatterns = { "/BillingReportServlet" })
public class BillingReportServlet extends HttpServlet {	
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
    public BillingReportServlet() {
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
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_billing.jsp");
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
			Integer monthid = Integer.parseInt(request.getParameter("monthid"));
			Integer yearid = Integer.parseInt(request.getParameter("yearid"));
			
			try {				
				@SuppressWarnings("unchecked")
				ArrayList<Invoice> pp = (ArrayList<Invoice>) CommandExecutor.getInstance().executeDatabaseCommand(
											new command.GetBillingReport(monthid, yearid));
				@SuppressWarnings("unchecked")
				ArrayList<Invoice> subtotals = (ArrayList<Invoice>) CommandExecutor.getInstance().executeDatabaseCommand(
											new command.GetBillingReportSubtotals(monthid, yearid));
				@SuppressWarnings("unchecked")
				ArrayList<Invoice> totals = (ArrayList<Invoice>) CommandExecutor.getInstance().executeDatabaseCommand(
											new command.GetBillingReportTotals(monthid, yearid));
				@SuppressWarnings("unchecked")
				ArrayList<Invoice> total = (ArrayList<Invoice>) CommandExecutor.getInstance().executeDatabaseCommand(
											new command.GetBillingReportTotal(monthid, yearid));		
				@SuppressWarnings("unchecked")
				ArrayList<Invoice> footer = (ArrayList<Invoice>) CommandExecutor.getInstance().executeDatabaseCommand(
											new command.GetBillingReportFooter(monthid, yearid));
				
				request.setAttribute("pp", pp);
				request.setAttribute("subtotals", subtotals);
				request.setAttribute("totals", totals);
				request.setAttribute("total", total);
				request.setAttribute("footer", footer);
				
				request.setAttribute("monthid", monthid);
				request.setAttribute("yearid", yearid);
				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_billing.jsp");
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
