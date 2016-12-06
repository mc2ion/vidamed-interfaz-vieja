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

import command.AddCashBoxPayment;
import command.CommandExecutor;
import domain.Admission;
import domain.Bank;
import domain.CashBoxSalePoint;
import domain.PaymentMethod;
import domain.PaymentResponsible;
import domain.PaymentTypes;
import domain.PermissionsList;
import domain.User;



/**
 * Servlet implementation class CreatePaymentServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreatePaymentServlet" })
public class CreatePaymentServlet extends HttpServlet {
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
    public CreatePaymentServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.cashBoxes);
		boolean perm1 = PermissionsList.hasPermission(request, PermissionsList.admissionCashBoxes);
		if(userE != null && (perm || perm1)){
			
			String search   = request.getParameter("search");
			if (search != null){
				String cashBoxID  	= request.getParameter("cashBoxID");
				String cedId 		= request.getParameter("cedId");
				String cedNumber 	= request.getParameter("cedNumber");
				String identityCard = cedId + cedNumber;
				try {
					@SuppressWarnings("unchecked")
					ArrayList<Admission> cb = (ArrayList<Admission>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmissionsByPatient(identityCard));
					request.setAttribute("cb", cb);
					
					@SuppressWarnings("unchecked")
					ArrayList<PaymentTypes> pt = (ArrayList<PaymentTypes>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentTypes());
					request.setAttribute("pt", pt);
					
					@SuppressWarnings("unchecked")
					ArrayList<PaymentMethod> pm = (ArrayList<PaymentMethod>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentMethods());
					request.setAttribute("pm", pm);
					
					@SuppressWarnings("unchecked")
					ArrayList<Bank> b = (ArrayList<Bank>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBanks());
					request.setAttribute("b", b);
					
					@SuppressWarnings("unchecked")
					ArrayList<PaymentResponsible> pr = (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibles());
					request.setAttribute("pr", pr);
					
					@SuppressWarnings("unchecked")
					ArrayList<CashBoxSalePoint> sp = (ArrayList<CashBoxSalePoint>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetCashBoxSalePoints(Long.valueOf(cashBoxID)));
					request.setAttribute("sp", sp);
					
				}catch (Exception e) {
					e.printStackTrace();
				}
			
			}
			RequestDispatcher rd;
			rd = getServletContext().getRequestDispatcher("/createPayment.jsp");			
			rd.forward(request, response);
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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.cashBoxes);
		boolean perm1 = PermissionsList.hasPermission(request, PermissionsList.admissionCashBoxes);
		if(userE != null && (perm || perm1)){
			
			String adId 			= request.getParameter("adId");
			String paymentType	 	= request.getParameter("paymentType");
			String paymentMethod 	= request.getParameter("paymentMethod");
			String pass 			= request.getParameter("pass");
			String bank 			= request.getParameter("bank");
			String check 			= request.getParameter("check");
			String salesPoint 		= request.getParameter("salesPoint");
			String aprob 			= request.getParameter("aprob");
			String insurance 		= request.getParameter("insurance");
			String amount 			= request.getParameter("amount");
			String cashBoxId		= request.getParameter("cashBoxID");
			String bankTo			= request.getParameter("bankTo");
			String transference		= request.getParameter("transference");
			
			String number = "";
			
			if (paymentType.equals("1"))
				number = check;
			else if (paymentType.equals("3"))
				number = pass;
			else if (paymentType.equals("4") || paymentType.equals("5"))
				number = aprob;
			else if (paymentType.equals("7"))
				number = transference;
			try {
				int result =  (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new AddCashBoxPayment(Long.valueOf(paymentType), Long.valueOf(paymentMethod), amount, Long.valueOf(cashBoxId),
								Long.valueOf(userE.getUserID()), Long.valueOf(adId), Long.valueOf(bank), number, Long.valueOf(insurance), Long.valueOf(salesPoint), Long.valueOf(bankTo)));
				
				String msg =  "Su pago fue registrado exitosamente.";
				if (result != 1)
						msg = "Ocurrió un error al registrar su pago. Por favor, intente nuevamente.";
				session.setAttribute("info", msg);
				response.sendRedirect(request.getContextPath() + "/ListCashBoxesServlet");
			}catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//doGet(request, response);
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
}
