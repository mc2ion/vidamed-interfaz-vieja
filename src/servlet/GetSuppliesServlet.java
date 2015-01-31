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
import domain.Supply;

/**
 * Servlet implementation class GetSuppliesServlet
 */
@WebServlet(description = "servlet to edit x-ray reports", urlPatterns = { "/GetSuppliesServlet" })
public class GetSuppliesServlet extends HttpServlet {

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
    public GetSuppliesServlet() {
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
				ArrayList<Supply> supplies = (ArrayList<Supply>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSuppliesWithInventory(category));
				String options = "";
	            for (int i = 0; i < supplies.size(); i++){
					options += "<option value="+ supplies.get(i).getSupplyID()+">" + supplies.get(i).getName() + "</option>";
				}
	            out.print(options);
	        }  catch (Exception ex) {
	            out.print("Error getting product name..." + ex.toString());
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
