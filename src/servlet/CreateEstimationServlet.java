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
import domain.User;



/**
 * Servlet implementation class CreateEstimationServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateEstimationServlet" })
public class CreateEstimationServlet extends HttpServlet {
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
    public CreateEstimationServlet() {
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
			String patientID = request.getParameter("patientID");
			String txtCedNumber = request.getParameter("txtCedNumber");
			String txtName = request.getParameter("txtName");
			String txtLastName = request.getParameter("txtLastName");
			
			System.out.println("get " + function + " " + patientID + " " + txtCedNumber + " " + txtName + " " + txtLastName );
			
			request.setAttribute("txtCedNumber", txtCedNumber);
			request.setAttribute("patientID", patientID);
			request.setAttribute("txtName", txtName);
			request.setAttribute("txtLastName", txtLastName);
			
			
			rd = getServletContext().getRequestDispatcher("/createEstimation.jsp");			
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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			String function = request.getParameter("function");
			String patientID = request.getParameter("patientID");
			String txtCedNumber = request.getParameter("txtCedNumber");
			String txtName = request.getParameter("txtName");
			String txtLastName = request.getParameter("txtLastName");
			
			System.out.println(function + " " + patientID + " " + txtCedNumber + " " + txtName + " " + txtLastName );
			if (function.equals("estimationForm")){
				doGet(request, response);
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
		
	}
}
