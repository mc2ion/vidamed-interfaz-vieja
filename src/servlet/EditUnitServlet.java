package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.Unit;



/**
 * Servlet implementation class EditDepartmentServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditUnitServlet" })
public class EditUnitServlet extends HttpServlet {
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
    public EditUnitServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			String action = request.getParameter("sbmtButton");
			RequestDispatcher rd;
			if (action == null || action.trim().equals("")) {
				Long unitID = Long.parseLong(request.getParameter("unitID"));
				Unit u = (Unit)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnit(unitID));
				request.setAttribute("unit", u);
				rd = getServletContext().getRequestDispatcher("/editUnit.jsp");			
				rd.forward(request, response);
			}
			else {
				Long unitID = Long.parseLong(request.getParameter("unitID"));
				String name = request.getParameter("txtName");
				String description = request.getParameter("txtDescription");
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditUnit(unitID, name, description));
				rd = getServletContext().getRequestDispatcher("/ListUnitsServlet");			
				rd.forward(request, response);
			}
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
