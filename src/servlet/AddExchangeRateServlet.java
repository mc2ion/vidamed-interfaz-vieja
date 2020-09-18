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
import domain.PermissionsList;
import domain.ExchangeRate;
import domain.User;



/**
 * Servlet implementation class AddExchangeRateServlet
 */
@WebServlet(description = "servlet to add exchange rate", urlPatterns = { "/AddExchangeRateServlet" })
public class AddExchangeRateServlet extends HttpServlet {
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
    public AddExchangeRateServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.exchangeRate);
		
		if(userE != null && perm){
			RequestDispatcher rd;
			
			try {
				ExchangeRate er = (ExchangeRate) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetExchangeRate());
				request.setAttribute("er", er);
				
				rd = getServletContext().getRequestDispatcher("/addExchangeRate.jsp");			
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
		
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.exchangeRate);
		
		if(userE != null && perm){
			try {
				RequestDispatcher rd;
				Double value = Double.parseDouble(request.getParameter("value"));
				Long userID = userE.getUserID();
				String text_good = "La tasa de cambio fue agregada exitosamente.";
				String text_bad = "Se ha presentado un error al agregar la tasa de cambio. Por favor, intente nuevamente.";
				
				ExchangeRate er = (ExchangeRate) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddExchangeRate(userID, value));
				request.setAttribute("er", er);
				
				if(er.getExchangeRateID() != null){
					session.setAttribute("info",text_good);
				}
				else {
					session.setAttribute("info",text_bad);
				}
				
				rd = getServletContext().getRequestDispatcher("/addExchangeRate.jsp");		
				rd.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
		
	}
}

