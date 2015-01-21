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
import domain.BussinessMicro;
import domain.PermissionsList;
import domain.Protocol;
import domain.ProtocolScale;
import domain.Unit;
import domain.User;



/**
 * Servlet implementation class AddAdmissionProtocolServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AddAdmissionProtocolServlet" })
public class AddAdmissionProtocolServlet extends HttpServlet {
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
    public AddAdmissionProtocolServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("addAdmissionProtocolServlet");
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm1  = PermissionsList.hasPermission(request, PermissionsList.emergency);
		boolean perm2  = PermissionsList.hasPermission(request, PermissionsList.hospitalization);
		if(userE != null && (perm2 || perm1)){
			RequestDispatcher rd;
			String function = request.getParameter("function");
			String spID 	= request.getParameter("id");
			//System.out.println("create estimation servlet " + function);
			try {
				//Leer todos los protocolos
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> pt = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocols());
				request.setAttribute("pt", pt);
				request.setAttribute("spID", String.valueOf(spID));
				
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> lp = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(String.valueOf(spID)));
				request.setAttribute("lp", lp);
			
				request.setAttribute("function", function);
				rd = getServletContext().getRequestDispatcher("/addAdmissionProtocol.jsp");			
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
		boolean perm1  = PermissionsList.hasPermission(request, PermissionsList.emergency);
		boolean perm2  = PermissionsList.hasPermission(request, PermissionsList.hospitalization);
		if(userE != null && (perm2 || perm1)){
			try {
				RequestDispatcher rd;
				String estimationID = request.getParameter("estimationID");
				String protocolID   = request.getParameter("protocoloID");
				String diagnosis    = request.getParameter("diagnosis");
				String function		= request.getParameter("function");
				
				System.out.println(estimationID + " " + protocolID + " "+ diagnosis + " " + function);
				Long spID = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddEstimationProtocolOnAdmission(estimationID, protocolID, diagnosis));
				System.out.println(spID);
				if (spID != 0) {
					//Obtener los items del presupuesto
					@SuppressWarnings("unchecked")
					ArrayList<ProtocolScale> p = (ArrayList<ProtocolScale>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocolScale(estimationID, protocolID));
					request.setAttribute("p",p);
					
					@SuppressWarnings("unchecked")
					ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
					request.setAttribute("bm", bm);
					
					@SuppressWarnings("unchecked")
					ArrayList<Unit> lList = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
					request.setAttribute("units", lList);
					
					request.setAttribute("function", function);
					request.setAttribute("protocolID", protocolID);
					rd = getServletContext().getRequestDispatcher("/addAdmissionProtocolStep2.jsp");
					rd.forward(request, response);
				}
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
