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
import domain.Supply;
import domain.SupplyForm;



/**
 * Servlet implementation class EditSupplyServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditSupplyServlet" })
public class EditSupplyServlet extends HttpServlet {
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
    public EditSupplyServlet() {
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
				Long supplyID = Long.parseLong(request.getParameter("supplyID"));
				Supply supply = (Supply) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupply(supplyID));
				ArrayList<SupplyForm> supplyForms = (ArrayList<SupplyForm>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyForms());
				request.setAttribute("supplyForms", supplyForms);
				request.setAttribute("supply", supply);
				rd = getServletContext().getRequestDispatcher("/editSupply.jsp");			
				rd.forward(request, response);
			}
			else {
				Long supplyID = Long.parseLong(request.getParameter("supplyID"));
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
				
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditSupply(supplyID, name, type, description, activeComponent, manufacturer, formID, amount, unitPrice, isRegulated));
				
				rd = getServletContext().getRequestDispatcher("/ListSuppliesServlet?supplyAreaID=" + supplyAreaID);			
				rd.forward(request, response);
			}			
		} 
		catch (Exception e) {
			e.printStackTrace();
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
