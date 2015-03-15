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
import domain.SupplyProvider;
import domain.User;

/**
 * Servlet implementation class EditSupplyInventoryServlet
 */
@WebServlet(description = "servlet to edit a supply inventory", urlPatterns = { "/EditSupplyInventoryServlet" })
public class EditSupplyInventoryServlet extends HttpServlet {
	
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
    public EditSupplyInventoryServlet() {
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
		
		if(userE != null && perm ){
			try {
				Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
				Long supplyID = Long.parseLong(request.getParameter("supplyID"));
				Long supplyInventoryID = Long.parseLong(request.getParameter("supplyInventoryID"));
				ArrayList<SupplyProvider> supplyProviders = (ArrayList<SupplyProvider>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyProviders());
				SupplyInventory supplyInventory = (SupplyInventory) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyInventory(supplyInventoryID));
				
				request.setAttribute("supplyProviders", supplyProviders);
				request.setAttribute("supplyID", supplyID);
				request.setAttribute("supplyAreaID", supplyAreaID);
				request.setAttribute("supplyInventory", supplyInventory);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/editSupplyInventory.jsp");
				rd.forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
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

		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.pharmacyAdmin);
		
		if(userE != null && perm ){
			try {
				String text_good = "El inventario fue editado exitosamente.";
				String text_bad = "Se ha presentado un error al editar el inventario. Por favor, intente nuevamente.";
				Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
				Long supplyID = Long.parseLong(request.getParameter("supplyID"));
				Long supplyInventoryID = Long.parseLong(request.getParameter("supplyInventoryID"));
				String manufacturer = request.getParameter("txtManufacturer");
				Long boxes = Long.parseLong(request.getParameter("txtBoxes"));
				Long amountPerBox = Long.parseLong(request.getParameter("txtAmountPerBox"));
				Double purchasePrice = Double.parseDouble(request.getParameter("txtPurchasePrice"));
				Double salePrice = Double.parseDouble(request.getParameter("txtSalePrice"));
				Long providerID = Long.parseLong(request.getParameter("txtProvider"));
				String lotNumber = request.getParameter("txtLotNumber");
				String expirationDate = request.getParameter("txtExpirationDate");
				
				int result = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditSupplyInventory(manufacturer, boxes, amountPerBox, 
						purchasePrice, salePrice, providerID, lotNumber, expirationDate, supplyInventoryID));
				if (result == 1) {
					session.setAttribute("info",text_good);
				}
				else {
					session.setAttribute("info",text_bad);
				}
				
				response.sendRedirect(request.getContextPath() + "/ListSupplyInventoriesServlet?supplyAreaID=" + supplyAreaID + "&supplyID=" + supplyID);
			} catch (Exception e) {
				e.printStackTrace();
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

}
