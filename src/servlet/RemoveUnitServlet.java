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
@WebServlet(description = "servlet to log in users", urlPatterns = { "/RemoveUnitServlet" })
public class RemoveUnitServlet extends HttpServlet {
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
    public RemoveUnitServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			HttpSession session = request.getSession(false);
			Long unitID = Long.parseLong(request.getParameter("unitID"));
			int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveUnit(unitID));
			
			String text_good = "La unidad fue eliminada exitosamente";
			String text_bad = "Se ha presentado un error al eliminar la unidad. Por favor, intente nuevamente.";
			if (result == 1) {
				session.setAttribute("info",text_good);
			}
			else {
				session.setAttribute("info",text_bad);
			}
			
			response.sendRedirect(request.getContextPath() + "/ListUnitsServlet");
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
