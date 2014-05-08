package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.PatientMedicalAdvice;


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
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
