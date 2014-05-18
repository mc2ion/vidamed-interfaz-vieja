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
import domain.Admission;
import domain.User;



/**
 * Servlet implementation class ShowAdmissionServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ShowAdmissionServlet" })
public class ShowAdmissionServlet extends HttpServlet {
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
    public ShowAdmissionServlet() {
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
			String function = request.getParameter("function");
			if (function != null)
				rd = getServletContext().getRequestDispatcher("/showAdmission.jsp?function=" + function);			
			else{
				try {
					Long id = Long.parseLong(request.getParameter("id"));
					Admission admission = (Admission) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmission(id));
					request.setAttribute("admission", admission);
					rd = getServletContext().getRequestDispatcher("/showAdmission.jsp");			
					rd.forward(request, response);
				} 
				catch (Exception e) {
					throw new ServletException(e);
				}
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
