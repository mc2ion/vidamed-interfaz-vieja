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
import domain.Admission;
import domain.Cost;
import domain.Protocol;
import domain.User;



/**
 * Servlet implementation class PrintAdmissionServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/PrintAdmissionServlet" })
public class PrintAdmissionServlet extends HttpServlet {
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
    public PrintAdmissionServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			RequestDispatcher rd;
			Long admId = (Long) Long.valueOf(request.getParameter("admissionID"));
			String estId = request.getParameter("estimationID");
			try {
				Admission a = (Admission) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmission(admId));
				request.setAttribute("admission", a);
				
				@SuppressWarnings("unchecked")
				ArrayList<Cost> c = (ArrayList<Cost>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmissionCosts(admId));
				request.setAttribute("costs", c);
				
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> p = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(estId));
				request.setAttribute("protocols", p);
							
				request.setAttribute("admissionID", String.valueOf(admId));
				request.setAttribute("estimationID", String.valueOf(estId));
				
				rd = getServletContext().getRequestDispatcher("/printAdmission.jsp");			
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
