
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
import domain.MedicalFee;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListMedicalFeeReportServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListMedicalFeeReportServlet" })
public class ListMedicalFeeReportServlet extends HttpServlet {
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
    public ListMedicalFeeReportServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		if(userE != null && perm ){
			try {
				ArrayList<MedicalFee> pp = (ArrayList<MedicalFee>) CommandExecutor.getInstance().executeDatabaseCommand(
												new command.GetMedicalFeeReport());
				request.setAttribute("pp", pp);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_medicalFee.jsp");
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

		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		
		if(userE != null && perm ){
			String identityCard   = request.getParameter("identityCard");
			String g 	  	  = request.getParameter("gender");
			String gender = null;
			if (!g.equals("-"))
				gender = g;
			String rif 	  = request.getParameter("rif");
			
			String billid = request.getParameter("billid");
			String b = request.getParameter("billwasgenerated");
			String billwasgenerated = null;
			if (!b.equals("-"))
				billwasgenerated = b;
			
			String billgenerationfrom = request.getParameter("billgenerationfrom");
			String billgenerationto = request.getParameter("billgenerationto");
			String p = request.getParameter("billwaspaid");
			String billwaspaid = null;
			if (!p.equals("-"))
				billwaspaid = p;
			
			
			String billpaymentfrom = request.getParameter("billpaymentfrom");
			String billpaymentto = request.getParameter("billpaymentto");
			String i = request.getParameter("ispromptpayment");
			String ispromptpayment = null;
			if (!i.equals("-"))
				ispromptpayment = i;
			
			
			String w = request.getParameter("waspaid");
			String waspaid = null;
			if (!w.equals("-"))
				waspaid = w;
			
			String paymentfrom = request.getParameter("paymentfrom");
			String paymentto = request.getParameter("paymentto");
			
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<MedicalFee> pp = (ArrayList<MedicalFee>) CommandExecutor.getInstance().executeDatabaseCommand(
						new command.GetMedicalFeeReport(identityCard, gender, rif, billid, billwasgenerated, billgenerationfrom, billgenerationto, billwaspaid, billpaymentfrom, billpaymentto, ispromptpayment, waspaid, paymentfrom, paymentto));
				
				request.setAttribute("pp", pp);
				
				request.setAttribute("identityCard", identityCard);
				request.setAttribute("gender", gender);
				request.setAttribute("rif", rif);
				request.setAttribute("billid", billid);
				request.setAttribute("billwasgenerated", billwasgenerated);
				request.setAttribute("billgenerationfrom", billgenerationfrom);
				request.setAttribute("billgenerationto", billgenerationto);
				request.setAttribute("billwaspaid", billwaspaid);
				request.setAttribute("billpaymentfrom", billpaymentfrom);
				request.setAttribute("billpaymentto", billpaymentto);
				request.setAttribute("ispromptpayment", ispromptpayment);
				request.setAttribute("waspaid", waspaid);
				request.setAttribute("paymentfrom", paymentfrom);
				request.setAttribute("paymentto", paymentto);
				
				RequestDispatcher rd;			
				rd = getServletContext().getRequestDispatcher("/reports_medicalFee.jsp");
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
}
