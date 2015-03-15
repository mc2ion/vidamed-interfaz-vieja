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
import domain.DoseUnit;
import domain.PermissionsList;
import domain.SupplyForm;
import domain.User;



/**
 * Servlet implementation class CreateSupplyServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateSupplyServlet" })
public class CreateSupplyServlet extends HttpServlet {
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
    public CreateSupplyServlet() {
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
				String action = request.getParameter("txtName");
				RequestDispatcher rd;
				if (action == null || action.trim().equals("")) {
					ArrayList<SupplyForm> supplyForms = (ArrayList<SupplyForm>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyForms());
					ArrayList<DoseUnit> doseUnits = (ArrayList<DoseUnit>)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetDoseUnits());
					Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
					request.setAttribute("supplyForms", supplyForms);
					request.setAttribute("doseUnits", doseUnits);
					request.setAttribute("supplyAreaID", supplyAreaID);
					rd = getServletContext().getRequestDispatcher("/createSupply.jsp");			
					rd.forward(request, response);
				}
				else {
					String text_good = "El insumo fue creado exitosamente.";
					String text_bad = "Se ha presentado un error al crear el insumo. Por favor, intente nuevamente.";
					Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
					String name = request.getParameter("txtName");
					int type = Integer.parseInt(request.getParameter("txtType"));
					String activeComponent = "";
					Long formID = null;
					Double dose = null;
					Long doseUnit = null;
					if (type == 1) {
						activeComponent = request.getParameter("txtActiveComponent");
						formID = Long.parseLong(request.getParameter("txtForm"));
						dose = Double.parseDouble(request.getParameter("txtDose"));
						doseUnit = Long.parseLong(request.getParameter("txtDoseUnit"));
					}
					String description = request.getParameter("txtDescription");				
					Long amount = Long.parseLong(request.getParameter("txtAmount"));
					String regulated = request.getParameter("isRegulated");
					int isRegulated = regulated != null && regulated.equals("true") ? 1 : 0;
					
					Long supplyID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSupply(supplyAreaID, name, type, description, activeComponent, formID, amount, isRegulated, dose, doseUnit));
					if (supplyID != null) {
						session.setAttribute("info",text_good);
					}
					else {
						session.setAttribute("info",text_bad);
					}
					
					response.sendRedirect(request.getContextPath() + "/ListSuppliesServlet?supplyAreaID=" + supplyAreaID);
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
