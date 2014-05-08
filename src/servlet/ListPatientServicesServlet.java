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
import domain.PatientService;


/**
 * Servlet implementation class ListPatientServicesServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListPatientServicesServlet" })
public class ListPatientServicesServlet extends HttpServlet {
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
    public ListPatientServicesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Long id = Long.parseLong(request.getParameter("id"));
			Long servId = Long.parseLong(request.getParameter("servId"));
			String function = "";
			if (servId == 1)
				function = "ListBloodBankServlet";
			else if (servId == 2)
				function = "ListEcoServlet";
			else if (servId == 3)
				function = "ListLabServlet";
			else if (servId == 4)
				function = "ListXRayReportsServlet";
			
			String name = request.getParameter("name");
			ArrayList<PatientService> supplies = (ArrayList<PatientService>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientServicesByAdmission(id, servId));
			request.setAttribute("patName", name);
			request.setAttribute("function", function);
			request.setAttribute("supplies", supplies);
			request.setAttribute("servId", String.valueOf(servId));
			request.setAttribute("adminId", String.valueOf(id));
			
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/patientServices.jsp");
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