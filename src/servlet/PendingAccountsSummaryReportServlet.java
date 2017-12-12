package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.PendingAccounts;
import domain.PermissionsList;
import domain.User;

/**
 * Servlet implementation class PendingAccountsSummaryReportServlet
 */
@WebServlet(description = "servlet to pending accounts summarized report", urlPatterns = { "/PendingAccountsSummaryReportServlet" })
public class PendingAccountsSummaryReportServlet extends HttpServlet {	
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
    public PendingAccountsSummaryReportServlet() {
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
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_pendingaccountssummary.jsp");
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
    		String dateIni 	  = request.getParameter("txtDateIni");
			String dateEnd 	  = request.getParameter("txtDateEnd");
			
			try {				
				@SuppressWarnings("unchecked")
				ArrayList<PendingAccounts> pp = (ArrayList<PendingAccounts>) CommandExecutor.getInstance().executeDatabaseCommand(
											new command.GetPendingAccountsSummaryReport(dateIni, dateEnd));
				
				request.setAttribute("pp", pp);
				
				@SuppressWarnings("unchecked")
				ArrayList<String> ht = (ArrayList<String>) CommandExecutor.getInstance().executeDatabaseCommand(
						new command.GetPendingAccountsSummaryHeader(dateIni, dateEnd));
				
				request.setAttribute("ht", ht);
				
				HashMap<String, Integer> header = new HashMap<String, Integer>();
				
				for(int i = 0; i < ht.size(); i++) {
					header.put(ht.get(i), i);
				}
				
				request.setAttribute("header", header);
								
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_pendingaccountssummary.jsp");
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
