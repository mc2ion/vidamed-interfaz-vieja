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
import domain.SupplyProvider;
import domain.User;

/**
 * Servlet implementation class CreateSupplyInventoryServlet
 */
@WebServlet(description = "servlet to create a inventory for a supply", urlPatterns = { "/CreateSupplyInventoryServlet" })
public class CreateSupplyInventoryServlet extends HttpServlet {

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
    public CreateSupplyInventoryServlet() {
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
				ArrayList<SupplyProvider> supplyProviders = (ArrayList<SupplyProvider>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyProviders());
				request.setAttribute("supplyProviders", supplyProviders);
				request.setAttribute("supplyID", supplyID);
				request.setAttribute("supplyAreaID", supplyAreaID);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/createSupplyInventory.jsp");
				rd.forward(request, response);
			} catch (Exception e) {
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
				String text_good = "El inventario fue creado exitosamente.";
				String text_bad = "Se ha presentado un error al crear el inventario. Por favor, intente nuevamente.";
				Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
				Long supplyID = Long.parseLong(request.getParameter("supplyID"));
				String manufacturer = request.getParameter("txtManufacturer");
				Long boxes = Long.parseLong(request.getParameter("txtBoxes"));
				Long amountPerBox = Long.parseLong(request.getParameter("txtAmountPerBox"));
				Double purchasePrice = Double.parseDouble(request.getParameter("txtPurchasePrice"));
				Double salePrice = Double.parseDouble(request.getParameter("txtSalePrice"));
				Long providerID = Long.parseLong(request.getParameter("txtProvider"));
				String lotNumber = request.getParameter("txtLotNumber");
				String expirationDate = request.getParameter("txtExpirationDate");
				
				Long supplyInventoryID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSupplyInventory(supplyID, manufacturer, boxes, amountPerBox, 
						purchasePrice, salePrice, providerID, lotNumber, expirationDate));
				
				if (supplyInventoryID != null) {
					session.setAttribute("info",text_good);
				} else {
					session.setAttribute("info",text_bad);
				}
				
				response.sendRedirect(request.getContextPath() + "/ListSupplyInventoriesServlet?supplyAreaID=" + supplyAreaID + "&supplyID=" + supplyID);
			} catch (Exception e) {
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
