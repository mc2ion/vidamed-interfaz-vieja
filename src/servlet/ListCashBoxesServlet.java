package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.CashBox;


/**
 * Servlet implementation class ListBanksServlet
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
		
		try {
			ArrayList<CashBox> cashBoxes = (ArrayList<CashBox>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetCashBoxes());
			request.setAttribute("cashBoxes", cashBoxes);
			
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/cashBoxes.jsp");			
			rd.forward(request, response);
		} 
		catch (Exception e) {
			throw new ServletException(e);
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}