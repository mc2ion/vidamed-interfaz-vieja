package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;

/**
 * Servlet implementation class CreateDepartmentServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/DischargePatientServlet" })
public class DischargePatientServlet extends HttpServlet {
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
    public DischargePatientServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		try {
			Long userID 		= Long.parseLong(request.getParameter("userID"));
			Long dischargeID 	= Long.parseLong(request.getParameter("dischargeID"));
			String function 	= request.getParameter("function");
			String action 		= "/ListHospitalizationsServlet";
			if (function.equals("treatment"))
				action = "/ListMedicalTreatmentsServlet";
			else if (function.equals("emergency"))
				action = "/ListEmergenciesServlet";
					
			CommandExecutor.getInstance().executeDatabaseCommand(new command.SetDischarge(userID, dischargeID));
			session.setAttribute("info","El paciente se ha dado de alta éxitosamente.");
			response.sendRedirect(request.getContextPath() + action);
		}
		catch (Exception e) {
			session.setAttribute("info","Ha ocurrido un error al dar de alta al paciente. Por favor, intente de nuevo.");
			response.sendRedirect(request.getContextPath() + "/ListHospitalizationsServlet");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
