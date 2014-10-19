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
import domain.User;



/**
 * Servlet implementation class RemoveEstimationPaymentRespServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/RemoveEstimationPaymentRespServlet" })
public class RemoveEstimationPaymentRespServlet extends HttpServlet {
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
    public RemoveEstimationPaymentRespServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			try {
				Long rId = Long.parseLong(request.getParameter("userId"));
				Long eId = Long.parseLong(request.getParameter("eId"));
				String function = request.getParameter("function");
				
				Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveEstimationPaymentResposible(rId, eId));
				request.setAttribute("result", result);
				
				if (function.equals("editHospitalization"))
					response.sendRedirect(request.getContextPath() + "/EditHospitalizationServlet?id="+ eId +"#tabs-2");
				
				if (result == 1) {
					session.setAttribute("text","Responsable de pago eliminado exitosamente.");
				}
				else {
					session.setAttribute("text","Hubo un problema al eliminar el responsable de pago. Por favor intente nuevamente.");
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
}
