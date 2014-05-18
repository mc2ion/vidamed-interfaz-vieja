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
 * Servlet implementation class RemoveAdmissionServlet
 */
@WebServlet(description = "servlet to remove admission", urlPatterns = { "/RemoveAdmissionServlet" })
public class RemoveAdmissionServlet extends HttpServlet {
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
    public RemoveAdmissionServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			String function 	= request.getParameter("function");
			String text_good	= "La admisión fue eliminada exitosamente";
			String text_bad 	= "Se ha presentado un error al eliminar la admisión. Por favor, intente nuevamente.";
			String action 		= "ListAdmissionsServlet";
			
		
			if (function.equals("emergency")){
				text_good	= "La emergencia fue eliminada exitosamente";
				text_bad 	= "Se ha presentado un error al eliminar la emergencia. Por favor, intente nuevamente.";
				action 		= "ListEmergenciesServlet";
			}else if (function.equals("treatment")){
				text_good	= "El tratamiento médico fue eliminado exitosamente";
				text_bad 	= "Se ha presentado un error al eliminar el tratamiento médico. Por favor, intente nuevamente.";
				action 		= "ListMedicalTreatmentsServlet";
			}else if (function.equals("hospitalization")){
				text_good	= "La hospitalización fue eliminada exitosamente";
				text_bad 	= "Se ha presentado un error al eliminar la hospitalización. Por favor, intente nuevamente.";
				action 		= "ListHospitalizationsServlet";
			}
			
			try {
				Long userID	 = Long.parseLong(request.getParameter("userID"));
				int result	 = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveAdmission(userID));
				if (result == 1)
					session.setAttribute("info",text_good);
				else
					session.setAttribute("info",text_bad);
				response.sendRedirect(request.getContextPath() + "/" + action);
			}
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
	}
}
