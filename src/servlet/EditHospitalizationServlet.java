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
import domain.Hospitalization;
import domain.PaymentResponsible;
import domain.User;



/**
 * Servlet implementation class EditHospitalizationServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditHospitalizationServlet" })
public class EditHospitalizationServlet extends HttpServlet {
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
    public EditHospitalizationServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			Long id = Long.valueOf(request.getParameter("id"));
			RequestDispatcher rd;
			try {
				Hospitalization hospitalization = (Hospitalization) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetHospitalization(id));
				
				//Lista de responsables
				@SuppressWarnings("unchecked")
				ArrayList<PaymentResponsible> a =  (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command. GetEstimationPaymentResponsibles(id));
				
				request.setAttribute("hospitalization", hospitalization);
				request.setAttribute("paymentR", a);
				
				rd = getServletContext().getRequestDispatcher("/editHospitalization.jsp");			
				rd.forward(request, response);
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
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
