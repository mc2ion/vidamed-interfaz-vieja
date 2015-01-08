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
import domain.AdmissionReasons;
import domain.BedLocation;
import domain.PaymentResponsible;
import domain.PermissionsList;
import domain.Protocol;
import domain.User;

/**
 * Servlet implementation class CreateEstimationProtocolServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateFinalEstimationProtocolServlet" })
public class CreateFinalEstimationProtocolServlet extends HttpServlet {
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
    public CreateFinalEstimationProtocolServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm){
			try {
				String estimationid = request.getParameter("estimationid");
				String function = request.getParameter("function");
				
				//Leer todos los protocolos
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> pt = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocols());
				request.setAttribute("pt", pt);
				request.setAttribute("spID", String.valueOf(estimationid));
				
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> lp = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(String.valueOf(estimationid)));
				request.setAttribute("lp", lp);
				
				request.setAttribute("function", function);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/createEstimationProtocol.jsp");			
				rd.forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm){
			String estimationid = request.getParameter("estimationid");
			String function = request.getParameter("function");
			System.out.println("ultimo function " + function);
			//Obtener valores establecidos
			try {
				CommandExecutor.getInstance().executeDatabaseCommand(new command.GenerateEstimationRates(estimationid));
				if (function != null && function.equals("admisionCreate")){
					//Vengo de tratar admitir un paciente que no existia
					User pat = (User) session.getAttribute("userInfo");
					System.out.println(pat);
					session.setAttribute("pat", pat);
					session.setAttribute("estimationId", estimationid);
					
					
					@SuppressWarnings("unchecked")
					ArrayList<AdmissionReasons> ar = (ArrayList<AdmissionReasons>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmissionReasons());
					request.setAttribute("ar", ar);
					
					// Lista de responsable de pagos
					@SuppressWarnings("unchecked")
					ArrayList<PaymentResponsible> pr = (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibles());
					request.setAttribute("pr", pr);
					
					
					//Lista de camas
					@SuppressWarnings("unchecked")
					ArrayList<BedLocation> lList = (ArrayList<BedLocation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.SearchLocations());
					request.setAttribute("locations", lList);
					
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/admitPatient.jsp");			
					rd.forward(request, response);
				}else response.sendRedirect(request.getContextPath() + "/ListEstimationsServlet");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
		
	}
}
