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
import domain.Emergency;
import domain.PermissionsList;
import domain.Protocol;
import domain.User;



/**
 * Servlet implementation class ShowEmergencyServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ShowEmergencyServlet" })
public class ShowEmergencyServlet extends HttpServlet {
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
    public ShowEmergencyServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.emergency);
		if(userE != null && perm ){
			Long id = Long.valueOf(request.getParameter("id"));
			RequestDispatcher rd;
			try {
				Emergency emergency = (Emergency) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEmergency(id));
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> protocols = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(String.valueOf(emergency.getEstimationId())));
				request.setAttribute("emergency", emergency);
				request.setAttribute("protocols", protocols);
				rd = getServletContext().getRequestDispatcher("/showEmergency.jsp");			
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
