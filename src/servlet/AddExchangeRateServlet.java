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
import domain.ExchangeRate;
import domain.User;



/**
 * Servlet implementation class AddExchangeRateServlet
 */
@WebServlet(description = "servlet to add exchange rate", urlPatterns = { "/AddExchangeRateServlet" })
public class AddExchangeRateServlet extends HttpServlet {
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
    public AddExchangeRateServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.exchangeRate);
		
		if(userE != null && perm){
			RequestDispatcher rd;
			
			try {
				ExchangeRate er = (ExchangeRate) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetExchangeRate());
				request.setAttribute("er", er);
				
				rd = getServletContext().getRequestDispatcher("/addExchangeRate.jsp");			
				rd.forward(request, response);
			} catch (Exception e) {
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
		
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.exchangeRate);
		
		if(userE != null && perm){
			/*try {
				RequestDispatcher rd;
				String estimationID = request.getParameter("estimationID");
				String protocolID   = request.getParameter("protocoloID");
				String diagnosis    = request.getParameter("diagnosis");
				String function		= request.getParameter("function");
				String adminID  	= request.getParameter("adminID");
				
				System.out.println(estimationID + " " + protocolID + " "+ diagnosis + " " + function + " " + adminID);
				Long spID = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddEstimationProtocolOnAdmission(estimationID, protocolID, diagnosis));
				System.out.println(spID);
				if (spID != 0) {
					//Obtener los items del presupuesto
					@SuppressWarnings("unchecked")
					ArrayList<ProtocolScale> p = (ArrayList<ProtocolScale>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocolScale(estimationID, protocolID));
					request.setAttribute("p",p);
					
					Integer hasMainSpecialist = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.HasMainSpecialist(protocolID));
					request.setAttribute("hms", hasMainSpecialist);
					
					@SuppressWarnings("unchecked")
					ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
					request.setAttribute("bm", bm);
					
					@SuppressWarnings("unchecked")
					ArrayList<Unit> lList = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
					request.setAttribute("units", lList);
					
					request.setAttribute("function", function);
					request.setAttribute("protocolID", protocolID);
					request.setAttribute("adminID", adminID);
					rd = getServletContext().getRequestDispatcher("/addAdmissionProtocolStep2.jsp");
					rd.forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}*/
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
		
	}
}

