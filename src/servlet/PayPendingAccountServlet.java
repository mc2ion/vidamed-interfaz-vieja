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
import domain.PaymentResponsibleCollection;
import domain.PaymentResponsibleCollectionHeader;
import domain.User;



/**
 * Servlet implementation class PayPendingAccountServlet
 */
@WebServlet(description = "servlet to remove admission", urlPatterns = { "/PayPendingAccountServlet" })
public class PayPendingAccountServlet extends HttpServlet {
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
    public PayPendingAccountServlet() {
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
				Long userID	 = Long.parseLong(request.getParameter("userId"));
				String documentNumber = request.getParameter("documentnumber");
				String bank = request.getParameter("bank");
				Long admissionID = Long.parseLong(request.getParameter("admissionId"));
				Long paymentResponsibleID = Long.parseLong(request.getParameter("paymentResponsibleId"));
				Integer hasMultiple = Integer.parseInt(request.getParameter("hasMultiple"));
				Integer mainResponsible = Integer.parseInt(request.getParameter("mainResponsible"));
				Double islr = Double.parseDouble(request.getParameter("islr"));
				Double otherRetentions = Double.parseDouble(request.getParameter("otherRetentions"));
				Double promptPayment = Double.parseDouble(request.getParameter("promptPayment"));
				Double amount = (request.getParameter("amount") != null) ? Double.parseDouble(request.getParameter("amount")) : null;
				int result	 = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.PayPendingAccount(userID, documentNumber, bank, hasMultiple, mainResponsible, admissionID, paymentResponsibleID, islr, otherRetentions, promptPayment, amount));
				
				if (result == 1) {
					if(amount != null) {
						session.setAttribute("text", "Se registró el abono exitosamente.");
					} else {
						session.setAttribute("text", "Se registró el cobro exitosamente.");
					}
					
					PaymentResponsibleCollectionHeader header = (PaymentResponsibleCollectionHeader) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibleCollectionHeaderReport(bank, documentNumber, islr, amount));
					@SuppressWarnings("unchecked")
					ArrayList<PaymentResponsibleCollection> payments = (ArrayList<PaymentResponsibleCollection>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibleCollectionReport(bank, documentNumber, islr, amount));
					@SuppressWarnings("unchecked")
					ArrayList<PaymentResponsibleCollection> subtotals = (ArrayList<PaymentResponsibleCollection>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibleCollectionSubtotalReport(bank, documentNumber, islr, amount));
					
					request.setAttribute("header", header);
					request.setAttribute("payments", payments);
					request.setAttribute("subtotals", subtotals);
					
					RequestDispatcher rd;			
					rd = getServletContext().getRequestDispatcher("/paymentResponsibleCollectionReport.jsp");
					rd.forward(request, response);
				} else {
					session.setAttribute("text","Hubo un problema el registrar el cobro. Por favor, intente más tarde");				
					response.sendRedirect("./ListAccountsServlet");
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
