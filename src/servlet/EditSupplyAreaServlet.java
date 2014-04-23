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
				HttpSession session = request.getSession(false);
				String text_good = "El área de insumos fue editado exitosamente.";
				String text_bad = "Se ha presentado un error al editar el área de insumos. Por favor, intente nuevamente.";
				Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
				String name = request.getParameter("txtName");
				String description = request.getParameter("txtDescription");
				int result = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditSupplyArea(supplyAreaID, name, description));
				if (result == 1) {
					session.setAttribute("info",text_good);
				}
				else {
					session.setAttribute("info",text_bad);
				}
				
				response.sendRedirect(request.getContextPath() + "/ListSupplyAreasServlet");
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
