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
@WebServlet(description = "servlet to log in users", urlPatterns = { "/RemoveSupplyServlet" })
public class RemoveSupplyServlet extends HttpServlet {
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
    public RemoveSupplyServlet() {
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
			int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveSupply(supplyID));
			
			String text_good = "El insumo fue eliminado exitosamente";
			String text_bad = "Se ha presentado un error al eliminar el insumo. Por favor, intente nuevamente.";
			if (result == 1) {
				session.setAttribute("info",text_good);
			}
			else {
				session.setAttribute("info",text_bad);
			}
			
			response.sendRedirect(request.getContextPath() + "/ListSuppliesServlet?supplyAreaID=" + supplyAreaID);
		}
		catch (Exception e) {
			throw new ServletException(e);
		}
		} else {
			request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
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
