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
 * Servlet implementation class CreateDepartmentServlet
 */
@WebServlet(description = "remove a supply inventory", urlPatterns = { "/RemoveSupplyInventoryServlet" })
public class RemoveSupplyInventoryServlet extends HttpServlet {
	
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
    public RemoveSupplyInventoryServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			try {
				Long supplyID = Long.parseLong(request.getParameter("supplyID"));
				Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
				Long supplyInventoryID = Long.parseLong(request.getParameter("supplyInventoryID"));
				int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveSupplyInventory(supplyInventoryID));
				
				String text_good = "El inventario fue eliminado exitosamente";
				String text_bad = "Se ha presentado un error al eliminar el inventario. Por favor, intente nuevamente.";
				
				if (result == 1) {
					session.setAttribute("info",text_good);
				} else {
					session.setAttribute("info",text_bad);
				}
				
				response.sendRedirect(request.getContextPath() + "/ListSupplyInventoriesServlet?supplyAreaID=" + supplyAreaID + "&supplyID=" + supplyID);
			}
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
