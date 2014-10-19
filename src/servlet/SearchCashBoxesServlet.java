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
import domain.CashBoxReport;
import domain.PermissionsList;
import domain.User;



/**
 * Servlet implementation class SearchCashBoxesServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/SearchCashBoxesServlet" })
public class SearchCashBoxesServlet extends HttpServlet {
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
    public SearchCashBoxesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpSeSearchCashBoxServletrvletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.cashBoxes);
		if(userE != null && perm ){
			String cash 			= request.getParameter("txtCashBox");
			String cashier 			= request.getParameter("txtCashier");
			String txtOpenDate 		= request.getParameter("txtOpenDate");
			String txtCloseDate 	= request.getParameter("txtCloseDate");
			
			try {
				@SuppressWarnings("unchecked")
				ArrayList<CashBoxReport> cashBox = (ArrayList<CashBoxReport>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetCashBoxPaymentReport(cash, cashier, txtOpenDate, txtCloseDate));
				request.setAttribute("cashBox", cashBox);
				RequestDispatcher rd;
				rd = getServletContext().getRequestDispatcher("/searchCashBox.jsp");			
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

	
}
