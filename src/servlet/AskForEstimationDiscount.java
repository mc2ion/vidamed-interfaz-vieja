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
 * Servlet implementation class AskForEstimationDiscount
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AskForEstimationDiscount" })
public class AskForEstimationDiscount extends HttpServlet {
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
    public AskForEstimationDiscount() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm){
			try {
				String estimationid = request.getParameter("userId");
				String typeDiscount = request.getParameter("typeDiscount");
				String justify = request.getParameter("justify");
				String amount = request.getParameter("amount");
				
				System.out.println(estimationid + " "+ typeDiscount + " " + justify + " "+ amount);
				int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.AskForEstimationDiscount(estimationid, typeDiscount, amount, justify));
				String text_good = "El descuento del presupuesto fue solicitado exitosamente";
				String text_bad = "Se ha presentado un error al solicitar el descuento del presupuesto. Por favor, intente nuevamente.";
				if (result == 1) {
					session.setAttribute("info",text_good);
				}
				else {
					session.setAttribute("info",text_bad);
				}
				response.sendRedirect(request.getContextPath() + "/ListEstimationsServlet");
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
}
