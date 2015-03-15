package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.SupplyInventory;

/**
 * Servlet implementation class GetSupplyInventoriesServlet
 */
@WebServlet(description = "servlet to get the available inventories of a supply", urlPatterns = { "/GetSupplyInventoriesServlet" })
public class GetSupplyInventoriesServlet extends HttpServlet {
	
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
    public GetSupplyInventoriesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            Long category = Long.valueOf(request.getParameter("category"));
            @SuppressWarnings("unchecked")
			ArrayList<SupplyInventory> supplyInventories = (ArrayList<SupplyInventory>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetExistingSupplyInventories(category));
			String options = "";
            for (int i = 0; i < supplyInventories.size(); i++){
            	String option = supplyInventories.get(i).getManufacturer() + " - " + supplyInventories.get(i).getLotNumber() + " - " + supplyInventories.get(i).getExpirationDate();
				options += "<option value="+ supplyInventories.get(i).getSupplyInventoryID()+">" + option + "</option>";
			}
            out.print(options);
        }  catch (Exception ex) {
            out.print("Error getting supply inventories..." + ex.toString());
        }
        finally {
            out.close();
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
