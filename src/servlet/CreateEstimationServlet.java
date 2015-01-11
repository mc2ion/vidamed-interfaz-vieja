package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.ClinicType;
import domain.PaymentResponsible;
import domain.PermissionsList;
import domain.Protocol;
import domain.Unit;
import domain.User;



/**
 * Servlet implementation class CreateEstimationServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateEstimationServlet" })
public class CreateEstimationServlet extends HttpServlet {
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
    public CreateEstimationServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("a");
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm){
			RequestDispatcher rd;
			String function = request.getParameter("function");
			System.out.println("create estimation servlet " + function);
			String patientID 	= (String) request.getParameter("patientID");
			String txtCedNumber = (String) request.getParameter("txtCedNumber");
			String txtName 		= (String) request.getParameter("txtName");
			String txtLastName 	= (String) request.getParameter("txtLastName");
			
			if (patientID != null){
				request.setAttribute("txtCedNumber", txtCedNumber);
				request.setAttribute("patientID", patientID);
				request.setAttribute("txtName", txtName);
				request.setAttribute("txtLastName", txtLastName);
			}
			//Obtener Unidades, y especialistas.
			try {
				@SuppressWarnings("unchecked")
				ArrayList<Unit> lList = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				request.setAttribute("units", lList);
				@SuppressWarnings("unchecked")
				ArrayList<PaymentResponsible> responsibles = (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibles());
				request.setAttribute("responsibles", responsibles);
				
				@SuppressWarnings("unchecked")
				ArrayList<ClinicType> clinic = (ArrayList<ClinicType>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetClinicTypes());
				request.setAttribute("clinic", clinic);
				if (function != "" && function.equals("admision")) request.setAttribute("function", "admisionCreate");
				else request.setAttribute("function", "estimationCreate");
				rd = getServletContext().getRequestDispatcher("/createEstimation.jsp");			
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
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm){
			String function 	= request.getParameter("function");
			String f 			= (String) request.getAttribute("function");
			
			System.out.println("function create estimation servlet " + function);
			
			if (function != null && function.equals("estimation")){ doGet(request, response); return;}
			else if (f != null && f.equals("admisionCreate")) {doGet(request, response); return;}
			else{
				String[] fields = {"patientid", "unitId", "specialist", "clinicType", "paymentId", "aval", "titular", "cedIdTitular", "cedulaTitular", "nameTitular"};
				Map<String, String> params = new HashMap<String, String>();
				for(int i=0; i< fields.length; i++ ){
					params.put(fields[i] , (String) request.getParameter(fields[i]));
				}
			String pid = params.get("cedIdTitular") + params.get("cedulaTitular");
			if (params.get("cedulaTitular").equals("") ||  params.get("titular")!= null)   pid = null;
			String name = params.get("nameTitular");
			if (params.get("nameTitular").equals("")   ||  params.get("titular")!= null)   name = null;
			if (params.get("titular") != null && params.get("titular").equals("1")){
				pid = null; 
				name = null;
			}
			try {
				Long spID = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddEstimation(params.get("patientid"), params.get("unitId"), params.get("specialist"), params.get("paymentId"), params.get("aval"), params.get("titular"), pid,  name,  params.get("clinicType"), String.valueOf(userE.getUserID())));
				
				//Leer todos los protocolos
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> pt = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocols());
				request.setAttribute("pt", pt);
				request.setAttribute("spID", String.valueOf(spID));
				
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> lp = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(String.valueOf(spID)));
				request.setAttribute("lp", lp);
			
				request.setAttribute("function", function);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/createEstimationProtocol.jsp");			
				rd.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
				
				
			}
			/*String patientID 	= request.getParameter("patientID");
			String txtCedNumber = request.getParameter("txtCedNumber");
			String txtName		= request.getParameter("txtName");
			String txtLastName 	= request.getParameter("txtLastName");*/
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
		
	}
}
