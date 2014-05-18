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
import domain.CashBox;
import domain.CashBoxSalePoint;
import domain.User;



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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
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
					String text_good = "La caja fue editada exitosamente.";
					String text_bad = "Se ha presentado un error al editar la caja. Por favor, intente nuevamente.";
					String name = request.getParameter("txtName");
					String description = request.getParameter("txtDescription");
					
					int result = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditCashBox(cashBoxID, name, description));
					if (result == 1) {
						for (int i = 0; i<4; i++) {
							
							String salePointID = request.getParameter("txtSalePointID" + i);
							String nameSP = request.getParameter("txtNameSP" + i);
							String commission = request.getParameter("txtCommission" + i); 
							String islrPercentage = request.getParameter("txtIslrPercentage" + i); 
							if (salePointID == null || salePointID.trim().equals("")) {
								if (commission != null && !commission.trim().equals("") && islrPercentage != null && !islrPercentage.trim().equals("")) {
									Long spID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddCashBoxSalePoint(cashBoxID, nameSP, Double.parseDouble(commission), Double.parseDouble(islrPercentage)));
									if (spID == null) {
										text_good = "La caja fue editada exitosamente. Se ha presentado un error al editar uno o más puntos de venta. Por favor, intente nuevamente."; 
									}
								}
							}
							else {
								if (commission != null && !commission.trim().equals("") && islrPercentage != null && !islrPercentage.trim().equals("")) {
									Long spID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditCashBoxSalePoint(Long.parseLong(salePointID), nameSP, Double.parseDouble(commission), Double.parseDouble(islrPercentage)));
									if (spID == null) {
										text_good = "La caja fue editada exitosamente. Se ha presentado un error al editar uno o más puntos de venta. Por favor, intente nuevamente."; 
									}
								}
								else {
									int resp = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveCashBoxSalePoint(Long.parseLong(salePointID)));
									if (resp == 0) {
										text_good = "La caja fue editada exitosamente. Se ha presentado un error al editar uno o más puntos de venta. Por favor, intente nuevamente."; 
									}
								}
							}
						}
						session.setAttribute("info",text_good);
					}
					else {
						session.setAttribute("info",text_bad);
					}
					
					response.sendRedirect(request.getContextPath() + "/ListCashBoxesServlet");
				}			
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
	}
		

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
