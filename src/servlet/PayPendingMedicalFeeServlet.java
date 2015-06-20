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
 * Servlet implementation class PayPendingMedicalFeeServlet
 */
@WebServlet(description = "servlet to remove admission", urlPatterns = { "/PayPendingMedicalFeeServlet" })
public class PayPendingMedicalFeeServlet extends HttpServlet {
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
    public PayPendingMedicalFeeServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			try {
				Long userID	 	= Long.parseLong(request.getParameter("userId"));
				String function = request.getParameter("function");
				String documentNumber = request.getParameter("documentnumber");
				String bank = request.getParameter("bank");
				int result	 = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.PayMedicalFee(userID, documentNumber, bank));
				if (result == 1)
					session.setAttribute("text", "Se registró el pago exitosamente.");
				else
					session.setAttribute("text","Hubo un problema el registrar el pago. Por favor, intente más tarde");
				if (function != null && function.equals("pendingPayments"))
					response.sendRedirect("./ListPendingPaymentsServlet");
				else
					response.sendRedirect("./ListBillingsHServlet");
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
