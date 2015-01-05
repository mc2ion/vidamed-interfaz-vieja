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
import domain.PermissionsList;
import domain.Protocol;
import domain.User;



/**
 * Servlet implementation class EditFinalEstimationProtocolServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditFinalEstimationProtocolServlet" })
public class EditFinalEstimationProtocolServlet extends HttpServlet {
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
    public EditFinalEstimationProtocolServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm){
			try {
				String estimationid = request.getParameter("estimationid");
				
				//Setear valores 
				CommandExecutor.getInstance().executeDatabaseCommand(new command.GenerateEstimationRates(estimationid));
				
				
				//Leer todos los protocolos
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> pt = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocols());
				request.setAttribute("pt", pt);
				request.setAttribute("spID", String.valueOf(estimationid));
				
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> lp = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(String.valueOf(estimationid)));
				request.setAttribute("lp", lp);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/editEstimationProtocol.jsp");			
				rd.forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm){
			String estimationid = request.getParameter("estimationid");
			
			//Obtener valores establecidos
			try {
				CommandExecutor.getInstance().executeDatabaseCommand(new command.GenerateEstimationRates(estimationid));
				response.sendRedirect(request.getContextPath() + "/ListEstimationsServlet");
				
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
