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
 * Servlet implementation class ShowEstimationServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ShowEstimationServlet" })
public class ShowEstimationServlet extends HttpServlet {
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
    public ShowEstimationServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm ){
			RequestDispatcher rd;
			
			try {
				//Obtener informacion basica del presupuesto
				Estimation est = (Estimation) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationToPrint(request.getParameter("id")));
			    request.setAttribute("est", est);
			    
			    //Obtener lista de protocolos
			    @SuppressWarnings("unchecked")
				ArrayList<Protocol> lp = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(request.getParameter("id")));
			    request.setAttribute("lp", lp);
			    
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			String function = request.getParameter("function");
			if (function != null)
				rd = getServletContext().getRequestDispatcher("/showEstimation.jsp?function=" + function);			
			else
				rd = getServletContext().getRequestDispatcher("/showEstimation.jsp");	
			rd.forward(request, response);
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
