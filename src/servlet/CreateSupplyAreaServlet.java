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
 * Servlet implementation class CreateSupplyAreaServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateSupplyAreaServlet" })
public class CreateSupplyAreaServlet extends HttpServlet {
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
    public CreateSupplyAreaServlet() {
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
				String action = request.getParameter("sbmtButton");
				RequestDispatcher rd;
				if (action == null || action.trim().equals("")) {				
					rd = getServletContext().getRequestDispatcher("/createSupplyArea.jsp");
					rd.forward(request, response);
				}
				else {
					String text_good = "El área de insumos fue creado exitosamente.";
					String text_bad = "Se ha presentado un error al crear el área de insumos. Por favor, intente nuevamente.";
					String name = request.getParameter("txtName");
					String description = request.getParameter("txtDescription");
					description = description == null ? "" : description;
					Long supplyAreaID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSupplyArea(name, description));
					if (supplyAreaID != null) {
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
