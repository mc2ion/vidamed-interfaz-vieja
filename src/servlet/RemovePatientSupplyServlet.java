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
 * Servlet implementation class RemovePatientSupplyServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/RemovePatientSupplyServlet" })
public class RemovePatientSupplyServlet extends HttpServlet {
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
    public RemovePatientSupplyServlet() {
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
				Long supPatId = Long.parseLong(request.getParameter("userId"));
				String id 	  =	request.getParameter("id");
				String name   =	request.getParameter("name");
				
				Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RemovePatientSupply(supPatId));
				String text = "El suministro fue eliminado exitosamente";
				if (result == 0)
					text =	"Hubo un problema al eliminar el suministro. Por favor, intente nuevamente.";
				
				session.setAttribute("text", text);
				
				response.sendRedirect(request.getContextPath() + "/ListPatientSuppliesServlet?id=" + id + "&name=" + name);
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
