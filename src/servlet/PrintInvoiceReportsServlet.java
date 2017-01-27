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

import domain.Admission;
import domain.AdmissionPaymentResponsible;
import domain.User;

/**
 * Servlet implementation class PrintInvoiceReportsServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/PrintInvoiceReportsServlet" })
public class PrintInvoiceReportsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
     * @see HttpServlet#HttpServlet()
     */
    public PrintInvoiceReportsServlet() {
        super();
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			Long admissionID = Long.parseLong(request.getParameter("admId"));
			System.out.println(admissionID);
			Admission admission;
			String factId   = request.getParameter("factId");
			String prefactId   = request.getParameter("prefactId");
			String f 		= request.getParameter("f");
			
			try {
				admission = (Admission)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetTotalAdmissionPayments(admissionID));
				request.setAttribute("admission", admission);
				
				ArrayList<AdmissionPaymentResponsible> responsibles = (ArrayList<AdmissionPaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmissionPaymentResponsibles(admissionID));
				request.setAttribute("responsibles", responsibles);		
				
				if(prefactId != null){
					factId = prefactId;
				}
				
				request.setAttribute("factId", factId);
				request.setAttribute("f", f);	
				request.setAttribute("user", userE);
				
				RequestDispatcher rd;				   
				rd = getServletContext().getRequestDispatcher("/printInvoiceReports.jsp");			
				rd.forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request,response);
	}
}
