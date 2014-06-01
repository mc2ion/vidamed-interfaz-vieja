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
 * Servlet implementation class ListInterServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListReportsServlet" })
public class ListReportsServlet extends HttpServlet {
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
    public ListReportsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		if(userE != null && perm ){
			try {
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports.jsp");
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
		String modId = request.getParameter("modId");
		request.setAttribute("modId", modId);
		
		if (modId.equals("1")){
			response.sendRedirect(request.getContextPath() + "/ListUserReportsServlet");
		}else if (modId.equals("2")){
			response.sendRedirect(request.getContextPath() + "/ListSpecialistReportsServlet");
		}
		else if (modId.equals("3")){
			response.sendRedirect(request.getContextPath() + "/ListPaymentResponsibleReportsServlet");
		}
		else if (modId.equals("4")){
			response.sendRedirect(request.getContextPath() + "/ListSupplyReportsServlet");
		}
		else if (modId.equals("5")){
			response.sendRedirect(request.getContextPath() + "/ListPatientSupplyReportsServlet");
		}
		else if (modId.equals("6")){
			response.sendRedirect(request.getContextPath() + "/ListBloodBankReportsServlet");
		}
		else if (modId.equals("7")){
			response.sendRedirect(request.getContextPath() + "/ListEcoReportsServlet");
		}
		else if (modId.equals("8")){
			response.sendRedirect(request.getContextPath() + "/ListRayXReportsServlet");
		}		
		else if (modId.equals("9")){
			response.sendRedirect(request.getContextPath() + "/ListLabReportsServlet");
		}	
		else if (modId.equals("10")){
			response.sendRedirect(request.getContextPath() + "/ListPatientMedicalAdviceReportsServlet");
		}
		else if (modId.equals("11")){
			response.sendRedirect(request.getContextPath() + "/ListEstimationDiscountReportServlet");
		}
		else if (modId.equals("12")){
			response.sendRedirect(request.getContextPath() + "/ListBillReportServlet");
		}
		else if (modId.equals("13")){
			response.sendRedirect(request.getContextPath() + "/ListAdmissionReportServlet");
		}
		else if (modId.equals("14")){
			response.sendRedirect(request.getContextPath() + "/ListMedicalFeeReportServlet");
		}
		
		
		
		else{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports.jsp");
			rd.forward(request, response);
		}
		
	}
}
