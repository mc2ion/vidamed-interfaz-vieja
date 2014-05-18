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
 * Servlet implementation class RemovePatientServiceServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/RemovePatientServiceServlet" })
public class RemovePatientServiceServlet extends HttpServlet {
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
    public RemovePatientServiceServlet() {
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
			try {
				Long servPatId = Long.parseLong(request.getParameter("userId"));
				String id 	  =	request.getParameter("id");
				String servId =	request.getParameter("servId");
				String name   =	request.getParameter("name");
				
				Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RemovePatientService(servPatId));
				String text = "El servicio fue eliminado exitosamente";
				if (result == 0)
					text =	"Hubo un problema al eliminar al servicio. Por favor, intente nuevamente.";
				
				session.setAttribute("text", text);
				
				response.sendRedirect(request.getContextPath() + "/ListPatientServicesServlet?id=" + id + "&servId=" + servId + "&name=" + name);
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
