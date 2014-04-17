package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.MedicalTreatment;



/**
 * Servlet implementation class ShowMedicalTreatmentServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ShowMedicalTreatmentServlet" })
public class ShowMedicalTreatmentServlet extends HttpServlet {
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
    public ShowMedicalTreatmentServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Long id = Long.valueOf(request.getParameter("id"));
		RequestDispatcher rd;
		try {
			MedicalTreatment med = (MedicalTreatment) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetMedicalTreatment(id));
			request.setAttribute("medical", med);
			rd = getServletContext().getRequestDispatcher("/showMedicalTreatment.jsp");			
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
