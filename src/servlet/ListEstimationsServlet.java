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
import domain.Estimation;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListEstimationsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListEstimationsServlet" })
public class ListEstimationsServlet extends HttpServlet {
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
    public ListEstimationsServlet() {
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
				//ArrayList<Estimation> est = (ArrayList<Estimation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimations());
				request.setAttribute("est", new ArrayList<Estimation>());
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/estimations.jsp");
				rd.forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} else if (userE == null) {
			request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
		else{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
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
		
		if(userE != null && perm ){
			String estimationId 	 		= request.getParameter("estimationId");
			String num				= request.getParameter("txtCedIdNum");
			String identityCard 	= "";
			if (num != null && num != "")
				identityCard = request.getParameter("txtCedId") + num;
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<Estimation> est = (ArrayList<Estimation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimations(estimationId, identityCard));
				
				request.setAttribute("est", est);
				
				request.setAttribute("estimationid", estimationId);
				request.setAttribute("identitycard", identityCard);				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/estimations.jsp");
				rd.forward(request, response);
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}
	}
}
