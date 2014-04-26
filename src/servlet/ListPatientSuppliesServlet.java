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
import domain.PatientSupply;


/**
 * Servlet implementation class ListPatientSuppliesServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListPatientSuppliesServlet" })
public class ListPatientSuppliesServlet extends HttpServlet {
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
    public ListPatientSuppliesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Long id = Long.parseLong(request.getParameter("id"));
			String name = request.getParameter("name");
			ArrayList<PatientSupply> supplies = (ArrayList<PatientSupply>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientSuppliesByAdmission(id));
			request.setAttribute("patName", name);
			request.setAttribute("supplies", supplies);
			request.setAttribute("adminId", String.valueOf(id));
			
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/patientSupplies.jsp");
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
