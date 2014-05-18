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
import domain.PendingPromptPayment;
import domain.User;


/**
 * Servlet implementation class ListBillingsPPServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListBillingsPPServlet" })
public class ListBillingsPPServlet extends HttpServlet {
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
    public ListBillingsPPServlet() {
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
    	try {
			
			ArrayList<PendingPromptPayment> pp = (ArrayList<PendingPromptPayment>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPendingPromptPayments());
			request.setAttribute("pp", pp);
			RequestDispatcher rd;			
			rd = getServletContext().getRequestDispatcher("/billingPP.jsp");
			rd.forward(request, response);
		} 
		catch (Exception e) {
			throw new ServletException(e);
		}
		} else {
			request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
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
