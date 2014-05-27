package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.PermissionsList;
import domain.User;



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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.cashBoxes);
		if(userE != null && perm ){
			try {
			String action = request.getParameter("txtName");
			if (action == null || action.trim().equals("")) {				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/createCashBox.jsp");
				rd.forward(request, response);
			}
			else {
				String text_good = "La caja fue creada exitosamente.";
				String text_bad = "Se ha presentado un error al crear la caja. Por favor, intente nuevamente.";
				String name = request.getParameter("txtName");
				String description = request.getParameter("txtDescription");
				Long cashBoxID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddCashBox(name, description));
				if (cashBoxID != null) {					
					for (int i = 0; i<4; i++) {
						String nameSP = request.getParameter("txtNameSP" + i);
						String commission = request.getParameter("txtCommission" + i); 
						String islrPercentage = request.getParameter("txtIslrPercentage" + i); 
						if (commission != null && !commission.trim().equals("") && islrPercentage != null && !islrPercentage.trim().equals("")) {
							Long salePointID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddCashBoxSalePoint(cashBoxID, nameSP, Double.parseDouble(commission), Double.parseDouble(islrPercentage)));
							if (salePointID == null) {
								text_good = "La caja fue creada exitosamente. Se ha presentado un error al crear uno o más puntos de venta. Por favor, intente nuevamente.";
							}
						}
						session.setAttribute("info",text_good);
					}
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
		}else {
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
