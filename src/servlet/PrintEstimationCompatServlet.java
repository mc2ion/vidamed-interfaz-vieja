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
import domain.Protocol;
import domain.User;



/**
 * Servlet implementation class PrintEstimationCompatServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/PrintEstimationCompatServlet" })
public class PrintEstimationCompatServlet extends HttpServlet {
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
    public PrintEstimationCompatServlet() {
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
			String estimationID = request.getParameter("userId");
			Estimation est;
			try {
				est = (Estimation) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationToPrint(estimationID));
				request.setAttribute("est", est);
				request.setAttribute("estimationID", estimationID);
				
				//Get protocols
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> plist = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(estimationID));
				request.setAttribute("plist", plist);
				
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> pDetail = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetCompactEstimationScaleToPrint(estimationID));
				request.setAttribute("estList", pDetail);
				
				
				RequestDispatcher rd;
				rd = getServletContext().getRequestDispatcher("/printEstimationCompact.jsp");			
				rd.forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
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
		doGet(request,response);
	}
}
