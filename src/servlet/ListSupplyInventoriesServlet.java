package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.PermissionsList;
import domain.SupplyInventory;
import domain.User;

/**
 * Servlet implementation class ListSupplyInventoriesServlet
 */
@WebServlet(description = "servlet to list the inventories of a supply", urlPatterns = { "/ListSupplyInventoriesServlet" })
public class ListSupplyInventoriesServlet extends HttpServlet {

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
    public ListSupplyInventoriesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.pharmacyAdmin);
		boolean perm1  = PermissionsList.hasPermission(request, PermissionsList.pharmacyAdminRestricted);
		
		if(userE != null && (perm || perm1)){
			try {
				Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
				Long supplyID = Long.parseLong(request.getParameter("supplyID"));
				ArrayList<SupplyInventory> supplyInventories = (ArrayList<SupplyInventory>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyInventories(supplyID));
				request.setAttribute("supplyInventories", supplyInventories);
				request.setAttribute("supplyID", supplyID);
				request.setAttribute("supplyAreaID", supplyAreaID);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/supplyInventories.jsp");
				rd.forward(request, response);
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
}
