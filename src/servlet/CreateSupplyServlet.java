package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.SupplyForm;



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

		try {
			String action = request.getParameter("sbmtButton");
			RequestDispatcher rd;
			if (action == null || action.trim().equals("")) {
				ArrayList<SupplyForm> supplyForms = (ArrayList<SupplyForm>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyForms());
				Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
				request.setAttribute("supplyForms", supplyForms);
				request.setAttribute("supplyAreaID", supplyAreaID);
				rd = getServletContext().getRequestDispatcher("/createSupply.jsp");			
				rd.forward(request, response);
			}
			else {
				Long supplyAreaID = Long.parseLong(request.getParameter("supplyAreaID"));
				String name = request.getParameter("txtName");
				int type = Integer.parseInt(request.getParameter("txtType"));
				String activeComponent = "";
				String manufacturer = "";
				Long formID = null;
				if (type == 1) {
					activeComponent = request.getParameter("txtActiveComponent");
					manufacturer = request.getParameter("txtManufacturer");
					formID = Long.parseLong(request.getParameter("txtForm"));
				}
				String description = request.getParameter("txtDescription");				
				Long amount = Long.parseLong(request.getParameter("txtAmount"));
				Double unitPrice = Double.parseDouble(request.getParameter("txtUnitPrice"));
				String regulated = request.getParameter("isRegulated");
				int isRegulated = regulated != null && regulated.equals("true") ? 1 : 0;
				
				CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSupply(supplyAreaID, name, type, description, activeComponent, manufacturer, formID, amount, unitPrice, isRegulated));
				
				rd = getServletContext().getRequestDispatcher("/ListSuppliesServlet?supplyAreaID=" + supplyAreaID);			
				rd.forward(request, response);
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
