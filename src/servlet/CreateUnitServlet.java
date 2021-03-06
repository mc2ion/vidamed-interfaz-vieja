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
import domain.PermissionsList;
import domain.User;



/**
 * Servlet implementation class CreateDepartmentServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateUnitServlet" })
public class CreateUnitServlet extends HttpServlet {
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
    public CreateUnitServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.units);
		if(userE != null && perm ){
			try {
				String action = request.getParameter("sbmtButton");
				RequestDispatcher rd;
				if (action == null || action.trim().equals("")) {				
					rd = getServletContext().getRequestDispatcher("/createUnit.jsp");
					rd.forward(request, response);
				}
				else {
					String text_good = "La unidad fue creada exitosamente.";
					String text_bad = "Se ha presentado un error al crear la unidad. Por favor, intente nuevamente.";
					String name = request.getParameter("txtName");
					String description = request.getParameter("txtDescription");
					description = description == null ? "" : description;
					Long unitID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddUnit(name, description));
					if (unitID != null) {
						session.setAttribute("info",text_good);
					}
					else {
						session.setAttribute("info",text_bad);
					}
					
					response.sendRedirect(request.getContextPath() + "/ListUnitsServlet");
				}
			}
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
