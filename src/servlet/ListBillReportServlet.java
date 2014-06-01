
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
import domain.PendingBills;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListBillReportServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListBillReportServlet" })
public class ListBillReportServlet extends HttpServlet {
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
    public ListBillReportServlet() {
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
		if(userE != null && perm ){
			try {
				ArrayList<PendingBills> pp = (ArrayList<PendingBills>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBillReport());
				request.setAttribute("pp", pp);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_bills.jsp");
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
			String billId		  	 		= request.getParameter("billId");
			String estimationId 	 		= request.getParameter("estimationId");
			String paymentresponsiblename   = request.getParameter("paymentresponsiblename");
			String g 	  	  		 		= request.getParameter("wasGenerated");
			String wasGenerated = null;
			if (!g.equals("-"))
				wasGenerated = g;
			
			String p 	  	  = request.getParameter("wasPaid");
			String waspaid = null;
			if (!p.equals("-"))
				waspaid = p;
			
			String generationfrom 	= request.getParameter("generationfrom");
			String generationto	 	= request.getParameter("generationto");
			String paymentfrom 		= request.getParameter("paymentfrom");
			String paymentto	  	= request.getParameter("paymentto");
			
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<PendingBills> pp = (ArrayList<PendingBills>) CommandExecutor.getInstance().executeDatabaseCommand(
											new command.GetBillReport(billId, estimationId, paymentresponsiblename, wasGenerated, generationfrom, generationto, waspaid, paymentfrom, paymentto));
				
				request.setAttribute("pp", pp);
				
				request.setAttribute("billid", billId);
				request.setAttribute("estimationid", estimationId);
				request.setAttribute("paymentresponsiblename", paymentresponsiblename);
				request.setAttribute("wasgenerated", wasGenerated);
				request.setAttribute("waspaid", waspaid);
				request.setAttribute("generationfrom", generationfrom);
				request.setAttribute("generationto", generationto);
				request.setAttribute("paymentfrom", paymentfrom);
				request.setAttribute("paymentto", paymentto);
				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_bills.jsp");
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
