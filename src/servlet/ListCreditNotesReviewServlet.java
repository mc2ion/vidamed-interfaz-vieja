package servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.PaymentResponsible;
import domain.PendingCreditNotes;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListCreditNotesReviewServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListCreditNotesReviewServlet" })
public class ListCreditNotesReviewServlet extends HttpServlet {
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
    public ListCreditNotesReviewServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");

		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.creditNotesReview);
		if(userE != null && perm ){
			try {
				@SuppressWarnings("unchecked")
				ArrayList<PendingCreditNotes> creditNotes = (ArrayList<PendingCreditNotes>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPendingCreditNotesReview());
				request.setAttribute("creditNotes", creditNotes);
				
				@SuppressWarnings("unchecked")
				ArrayList<PaymentResponsible> responsibles = (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibles());
				request.setAttribute("responsibles", responsibles);
				
				Properties propertiesFile = new Properties();
				propertiesFile.load( new FileInputStream( getServletContext().getInitParameter("properties")));
				Long cashPayment = Long.parseLong(propertiesFile.getProperty("cashPayment"));
				request.setAttribute("cashPayment", cashPayment);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/pendingCreditNotesReview.jsp");
				rd.forward(request, response);
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
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
