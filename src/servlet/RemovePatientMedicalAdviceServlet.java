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
 * Servlet implementation class RemovePatientMedicalAdviceServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/RemovePatientMedicalAdviceServlet" })
public class RemovePatientMedicalAdviceServlet extends HttpServlet {
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
    public RemovePatientMedicalAdviceServlet() {
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
		try {
			Long supPatId = Long.parseLong(request.getParameter("userId"));
			String id 	  =	request.getParameter("id");
			String name   =	request.getParameter("name");
			HttpSession session = request.getSession(false);
			
			Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RemovePatientMedicalAdvice(supPatId));
			String text = "La consulta fue eliminada exitosamente";
			if (result == 0)
				text =	"Hubo un problema al eliminar la consulta. Por favor, intente nuevamente.";
			
			session.setAttribute("text", text);
			response.sendRedirect(request.getContextPath() + "/ListPatientMedicalAdvicesByAdmissionServlet?id=" + id + "&name=" + name);
		}
		catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
