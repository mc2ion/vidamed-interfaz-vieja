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
import domain.DischargeType;
import domain.Emergency;
import domain.User;


/**
 * Servlet implementation class ListEmergenciesServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListEmergenciesServlet" })
public class ListEmergenciesServlet extends HttpServlet {
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
    public ListEmergenciesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			try{
				@SuppressWarnings("unchecked")
				ArrayList<Emergency> emergencies = (ArrayList<Emergency>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEmergencies());
				request.setAttribute("emergencies", emergencies);
				@SuppressWarnings("unchecked")
				ArrayList<DischargeType> disc = (ArrayList<DischargeType>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetDischargeTypes());
				request.setAttribute("discharges", disc);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/emergencies.jsp");
				rd.forward(request, response);
			}catch(Exception e){
				
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
