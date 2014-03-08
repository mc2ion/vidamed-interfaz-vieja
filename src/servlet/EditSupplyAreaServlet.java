package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.SupplyArea;



/**
 * Servlet implementation class EditSupplyAreaServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditSupplyAreaServlet" })
public class EditSupplyAreaServlet extends HttpServlet {
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
    public EditSupplyAreaServlet() {
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
				Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
				SupplyArea sa = (SupplyArea)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyArea(supplyAreaID));
				request.setAttribute("supplyArea", sa);
				rd = getServletContext().getRequestDispatcher("/editSupplyArea.jsp");			
				rd.forward(request, response);
			}
			else {
				Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
				String name = request.getParameter("txtName");
				String description = request.getParameter("txtDescription");
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditSupplyArea(supplyAreaID, name, description));
				rd = getServletContext().getRequestDispatcher("/ListSupplyAreasServlet");			
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
