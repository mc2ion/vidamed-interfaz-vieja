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
import domain.User;



/**
 * Servlet implementation class SearchCashBoxFormServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/SearchCashBoxFormServlet" })
public class SearchCashBoxFormServlet extends HttpServlet {
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
    public SearchCashBoxFormServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			RequestDispatcher rd;
			ArrayList<CashBox> cashBoxes;
			try {
				cashBoxes = (ArrayList<CashBox>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetCashBoxes());
				request.setAttribute("cashBoxes", cashBoxes);
				ArrayList<User> cashier = (ArrayList<User>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetCashiers());
				request.setAttribute("cashiers", cashier);
				
				rd = getServletContext().getRequestDispatcher("/searchCashBoxForm.jsp");			
				rd.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
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
