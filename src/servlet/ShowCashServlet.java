package servlet;

import java.io.IOException;

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
 * Servlet implementation class ShowCashServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ShowCashServlet" })
public class ShowCashServlet extends HttpServlet {
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
    public ShowCashServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.pendingPayments);
		String  id 	  = request.getParameter("billID");
		if(userE != null && perm ){
			try {
				PendingAccounts cb = (PendingAccounts) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPendingAccount(Long.valueOf(id)));
				request.setAttribute("pendingAccount", cb);
				RequestDispatcher rd;
				rd = getServletContext().getRequestDispatcher("/showPendingAccount.jsp");			
				rd.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
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
		
		doGet(request, response);
	}
}
