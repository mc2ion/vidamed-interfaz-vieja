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
import domain.PaymentResponsible;
import domain.User;



/**
 * Servlet implementation class SearchInsuranceServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/SearchInsuranceServlet" })
public class SearchInsuranceServlet extends HttpServlet {
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
    public SearchInsuranceServlet() {
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
			RequestDispatcher rd;
			String function = request.getParameter("function");
			String id 		= request.getParameter("id");
			
			
			try {
				ArrayList<PaymentResponsible> responsibles = (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibles());
				request.setAttribute("responsibles", responsibles);
				request.setAttribute("function", function);
				request.setAttribute("id", id);
				
				rd = getServletContext().getRequestDispatcher("/searchInsurance.jsp");
				rd.forward(request, response);
			
			} catch (Exception e) {
				
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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			String function 	= request.getParameter("function");
			String id 			= request.getParameter("id");
			String insurance 	= request.getParameter("paymentId");
			String aval	 		= request.getParameter("aval");
			String isTitular	= request.getParameter("titular");
			String cedId	 	= request.getParameter("cedId");
			String cedula	 	= request.getParameter("cedula");
			String name		 	= request.getParameter("name");
			
			System.out.println(function + " " + id + " " + insurance + " " + aval + " " + isTitular + " " + cedId + " " +cedula + " " + name );
			//Add Payment responsible
			
			String identityCard = "";
			if (cedula != null && !cedula.equals(""))
				identityCard = cedId + cedula;
			try {
				int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(
						new command.AddEstimationPaymentResponsible(Long.valueOf(id), Long.valueOf(insurance), aval, isTitular, identityCard, name));
				if (result == 1) {
					session.setAttribute("text","Pago de responsable agregado exitosamente.");
				}
				else {
					session.setAttribute("text","Hubo un problema al agregar el pago de responsable. Por favor intente nuevamente.");
				}
				
				if (function.equals("editHospitalization"))
					response.sendRedirect(request.getContextPath() + "/EditHospitalizationServlet?id=" + id + "#tabs-2");
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
	}	
}
