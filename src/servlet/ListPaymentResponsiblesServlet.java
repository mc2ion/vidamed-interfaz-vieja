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
import domain.PaymentResponsible;


/**
 * Servlet implementation class ListPaymentResponsiblesServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListPaymentResponsiblesServlet" })
public class ListPaymentResponsiblesServlet extends HttpServlet {
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
    public ListPaymentResponsiblesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd;
		
		ArrayList<PaymentResponsible> responsibles;
		try {
			responsibles = (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibles());
			request.setAttribute("responsibles", responsibles);
			
			rd = getServletContext().getRequestDispatcher("/paymentResponsibles.jsp");
			rd.forward(request, response);
		
		} catch (Exception e) {
			request.setAttribute("responsibles", new ArrayList<PaymentResponsible>());
			rd = getServletContext().getRequestDispatcher("/paymentResponsibles.jsp");
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
