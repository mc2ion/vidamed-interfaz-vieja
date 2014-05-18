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
import domain.PatientMedicalAdvice;
import domain.User;


/**
 * Servlet implementation class ListPatientMedicalAdvicesByAdmissionServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListPatientMedicalAdvicesByAdmissionServlet" })
public class ListPatientMedicalAdvicesByAdmissionServlet extends HttpServlet {
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
    public ListPatientMedicalAdvicesByAdmissionServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
		try {
			Long id = Long.parseLong(request.getParameter("id"));
			//Long servId = Long.parseLong(request.getParameter("servId"));
				
			String name = request.getParameter("name");
			ArrayList<PatientMedicalAdvice> advice = (ArrayList<PatientMedicalAdvice>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientMedicalAdvicesByAdmission(id));
			request.setAttribute("patName", name);
			request.setAttribute("advice", advice);
			//request.setAttribute("servId", String.valueOf(servId));
			request.setAttribute("adminId", String.valueOf(id));
			
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/patientAdvice.jsp");
			rd.forward(request, response);
		} 
		catch (Exception e) {
			throw new ServletException(e);
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
