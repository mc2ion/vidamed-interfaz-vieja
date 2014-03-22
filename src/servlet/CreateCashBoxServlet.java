package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;



/**
 * Servlet implementation class CreateCashBoxServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateCashBoxServlet" })
public class CreateCashBoxServlet extends HttpServlet {
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
    public CreateCashBoxServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			String action = request.getParameter("sbmtButton");
			RequestDispatcher rd;
			if (action == null || action.trim().equals("")) {				
				rd = getServletContext().getRequestDispatcher("/createCashBox.jsp");
				rd.forward(request, response);
			}
			else {
				String name = request.getParameter("txtName");
				String description = request.getParameter("txtDescription");
				Long cashBoxID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddCashBox(name, description));
				
				for (int i = 0; i<4; i++) {
					String nameSP = request.getParameter("txtNameSP" + i);
					String commission = request.getParameter("txtCommission" + i); 
					String islrPercentage = request.getParameter("txtIslrPercentage" + i); 
					if (commission != null && !commission.trim().equals("") && islrPercentage != null && !islrPercentage.trim().equals("")) {
						CommandExecutor.getInstance().executeDatabaseCommand(new command.AddCashBoxSalePoint(cashBoxID, nameSP, Double.parseDouble(commission), Double.parseDouble(islrPercentage)));
					}
				}
				
				rd = getServletContext().getRequestDispatcher("/ListCashBoxesServlet");
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
