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
import domain.CashBox;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListCashBoxesServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListCashBoxesServlet" })
public class ListCashBoxesServlet extends HttpServlet {
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
    public ListCashBoxesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.cashBoxes);
		boolean perm1 = PermissionsList.hasPermission(request, PermissionsList.admissionCashBoxes);
		
		if(userE != null && (perm || perm1)){
			try {
				ArrayList<CashBox> cashBoxes;
				
				if(perm && perm1){
					cashBoxes = (ArrayList<CashBox>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAllCashBoxes());
				}else if(perm){
					cashBoxes = (ArrayList<CashBox>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetCashBoxes());
				}else{
					cashBoxes = (ArrayList<CashBox>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmissionCashBoxes());
				}
				
				request.setAttribute("cashBoxes", cashBoxes);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/cashBoxes.jsp");			
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
		doGet(request, response);
	}
}
