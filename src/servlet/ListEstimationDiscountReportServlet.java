
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
import domain.PendingEstimationDiscount;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListEstimationDiscountReportServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListEstimationDiscountReportServlet" })
public class ListEstimationDiscountReportServlet extends HttpServlet {
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
    public ListEstimationDiscountReportServlet() {
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
				ArrayList<PendingEstimationDiscount> pp = (ArrayList<PendingEstimationDiscount>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationDiscountReport());
				
				request.setAttribute("pp", pp);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_estimationDiscount.jsp");
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
    		String estimationId = request.getParameter("estimationId");
    		String identityCard = request.getParameter("identityCard");
    		String g 	  	  	= request.getParameter("gender");
			String gender = null;
			if (!g.equals("-"))
				gender = g;
			
			String a 	  	  	= request.getParameter("isAdult");
			String isAdult = null;
			if (!a.equals("-"))
				isAdult = a;
			
			String t 	  	  	= request.getParameter("type");
			String type = null;
			if (!t.equals("-"))
				type = t;
			
			
			
    		String requestFrom 	  	= request.getParameter("requestFrom");
			String requestTo  	= request.getParameter("requestTo");
			String reviewfrom    = request.getParameter("reviewfrom");
			String reviewto = request.getParameter("reviewto");
			String i   		= request.getParameter("isApproved");
			String isApproved = null;
			if (!i.equals("-"))
				isApproved = i;
			
			
			
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<PendingEstimationDiscount> pp = (ArrayList<PendingEstimationDiscount>) CommandExecutor.getInstance().executeDatabaseCommand(
										new command.GetEstimationDiscountReport(estimationId, identityCard, gender, isAdult, type, requestFrom, requestTo, isApproved, reviewfrom, reviewto));
				request.setAttribute("pp", pp);
				RequestDispatcher rd;		
				
				request.setAttribute("estimationId", estimationId);
				request.setAttribute("identityCard", identityCard);
				request.setAttribute("gender", gender);
				request.setAttribute("isAdult", isAdult);
				request.setAttribute("type", type);
				request.setAttribute("requestFrom", requestFrom);
				request.setAttribute("requestTo", requestTo);
				request.setAttribute("isApproved", isApproved);
				request.setAttribute("reviewfrom", reviewfrom);
				request.setAttribute("reviewto", reviewto);
				
				
				rd = getServletContext().getRequestDispatcher("/reports_estimationDiscount.jsp");
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
