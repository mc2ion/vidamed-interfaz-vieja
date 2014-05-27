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
 * Servlet implementation class ListBillingsRPServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListBillingsRPServlet" })
public class ListBillingsRPServlet extends HttpServlet {
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
    public ListBillingsRPServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.billsRP);
		if(userE != null && perm ){
			try {
				
				ArrayList<MedicalFee> pp = (ArrayList<MedicalFee>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetMedicalFees());
				request.setAttribute("pp", pp);
				RequestDispatcher rd;			
				rd = getServletContext().getRequestDispatcher("/billingRP.jsp");
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
    @SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.billsRP);
		if(userE != null && perm ){
    	
	    	String dateIni 	  = request.getParameter("txtDateIni");
			String dateEnd 	  = request.getParameter("txtDateEnd");
			String name  	  = request.getParameter("eName");
			String lastName   = request.getParameter("eLastname");
			String amount 	  = request.getParameter("amount");
			
			try {
				
				ArrayList<MedicalFee> pp = (ArrayList<MedicalFee>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetMedicalFees(dateIni, dateEnd, name, lastName, amount));
				request.setAttribute("pp", pp);
				RequestDispatcher rd;			
				request.setAttribute("dateIni", dateIni);
				request.setAttribute("dateEnd", dateEnd);
				request.setAttribute("name", name);
				request.setAttribute("amount", amount);
				request.setAttribute("lastname", lastName);
				
				
				rd = getServletContext().getRequestDispatcher("/billingRP.jsp");
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
