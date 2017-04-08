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
import domain.PaymentResponsible;
import domain.PendingAccounts;
import domain.PermissionsList;
import domain.User;

/**
 * Servlet implementation class DetailedInvoicingReportServlet
 */
@WebServlet(description = "servlet to pending accounts reports", urlPatterns = { "/PendingAccountsReportServlet" })
public class PendingAccountsReportServlet extends HttpServlet {	
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
    public PendingAccountsReportServlet() {
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
				// Lista de responsable de pagos
				@SuppressWarnings("unchecked")
				ArrayList<PaymentResponsible> pr = (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(
						new command.GetPaymentResponsibles());
				
				request.setAttribute("pr", pr);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_pendingaccounts.jsp");
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
			Long paymentresponsibleid = Long.parseLong(request.getParameter("paymentresponsibleid"));
			try {
				// Lista de responsable de pagos
				@SuppressWarnings("unchecked")
				ArrayList<PaymentResponsible> pr = (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(
						new command.GetPaymentResponsibles());
				
				request.setAttribute("pr", pr);
				
				@SuppressWarnings("unchecked")
				ArrayList<PendingAccounts> pp = (ArrayList<PendingAccounts>) CommandExecutor.getInstance().executeDatabaseCommand(
											new command.GetPendingAccountsReport(paymentresponsibleid));
				
				request.setAttribute("pp", pp);
				
				request.setAttribute("paymentresponsibleid", paymentresponsibleid);
				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_pendingaccounts.jsp");
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
