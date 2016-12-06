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
import domain.SupplyArea;
import domain.User;



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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.pharmacyAdmin);
		boolean perm1 = PermissionsList.hasPermission(request, PermissionsList.pharmacyAdminRestricted);
		if(userE != null && (perm || perm1)){
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
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
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
