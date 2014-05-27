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
import domain.PendingAccounts;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListAccountsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListAccountsServlet" })
public class ListAccountsServlet extends HttpServlet {
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
    public ListAccountsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.pendingAccounts);
		if(userE != null && perm){
			try {
				@SuppressWarnings("unchecked")
				ArrayList<PendingAccounts> p = (ArrayList<PendingAccounts>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPendingAccounts());
				request.setAttribute("pAccounts", p);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/accounts.jsp");
				rd.forward(request, response);
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else if (userE == null) {
			request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
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
		doGet(request, response);
	}
}
