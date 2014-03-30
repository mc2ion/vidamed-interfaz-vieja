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
import domain.CashBox;
import domain.CashBoxSalePoint;



/**
 * Servlet implementation class EditCashBoxServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditCashBoxServlet" })
public class EditCashBoxServlet extends HttpServlet {
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
    public EditCashBoxServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			String action = request.getParameter("sbmtButton");
			Long cashBoxID = Long.parseLong(request.getParameter("cashBoxID"));
			RequestDispatcher rd;
			if (action == null || action.trim().equals("")) {
				CashBox cb = (CashBox) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetCashBox(cashBoxID));
				ArrayList<CashBoxSalePoint> cbSalePoints = (ArrayList<CashBoxSalePoint>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetCashBoxSalePoints(cashBoxID));
				request.setAttribute("cashBox", cb);
				request.setAttribute("cbSalePoints", cbSalePoints);
				
				rd = getServletContext().getRequestDispatcher("/editCashBox.jsp");			
				rd.forward(request, response);
			}
			else {
				String name = request.getParameter("txtName");
				String description = request.getParameter("txtDescription");
				
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditCashBox(cashBoxID, name, description));

				for (int i = 0; i<4; i++) {
					
					String salePointID = request.getParameter("txtSalePointID" + i);
					String nameSP = request.getParameter("txtNameSP" + i);
					String commission = request.getParameter("txtCommission" + i); 
					String islrPercentage = request.getParameter("txtIslrPercentage" + i); 
					if (salePointID == null || salePointID.trim().equals("")) {
						if (commission != null && !commission.trim().equals("") && islrPercentage != null && !islrPercentage.trim().equals("")) {
							CommandExecutor.getInstance().executeDatabaseCommand(new command.AddCashBoxSalePoint(cashBoxID, nameSP, Double.parseDouble(commission), Double.parseDouble(islrPercentage)));
						}
					}
					else {
						if (commission != null && !commission.trim().equals("") && islrPercentage != null && !islrPercentage.trim().equals("")) {
							CommandExecutor.getInstance().executeDatabaseCommand(new command.EditCashBoxSalePoint(Long.parseLong(salePointID), nameSP, Double.parseDouble(commission), Double.parseDouble(islrPercentage)));
						}
						else {
							CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveCashBoxSalePoint(Long.parseLong(salePointID)));
						}
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
