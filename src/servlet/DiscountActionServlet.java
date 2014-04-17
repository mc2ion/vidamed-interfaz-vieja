package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;



/**
 * Servlet implementation class DiscountActionServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/DiscountActionServlet" })
public class DiscountActionServlet extends HttpServlet {
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
    public DiscountActionServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/ListRequestsServlet");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String submit 	= request.getParameter("sbmtButton");
			Long 	id 		= Long.valueOf(request.getParameter("id"));
			HttpSession session = request.getSession(false);
			System.out.println("submit " + submit);
			
			if (submit != null && submit.equals("Aceptar")){
				int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.ApproveEstimationDiscount(id));
				if (result == 1)
					session.setAttribute("info", "El descuento fue aceptado exitosamente!.");
				else
					session.setAttribute("info", "Hubo un error al aceptar el descuento. Por favor, intente nuevamente.");
			}else if (submit != null && submit.equals("Rechazar")){
				int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RejectEstimationDiscount(id));
				if (result == 1)
					session.setAttribute("info", "El descuento fue rechazado exitosamente!.");
				else
					session.setAttribute("info", "Hubo un error al rechazar el descuento. Por favor, intente nuevamente.");
			}
			response.sendRedirect(request.getContextPath() + "/ListRequestsServlet");
			
		} 
		catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
