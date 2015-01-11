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
import domain.Estimation;
import domain.PaymentResponsible;
import domain.PermissionsList;
import domain.Protocol;
import domain.Unit;
import domain.User;



/**
 * Servlet implementation class EditEstimationServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditEstimationServlet" })
public class EditEstimationServlet extends HttpServlet {
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
    public EditEstimationServlet() {
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
			String estimationID = request.getParameter("id");
			try {
				
				Estimation est = (Estimation) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimation(estimationID));
				request.setAttribute("est", est);
				RequestDispatcher rd;
				
				@SuppressWarnings("unchecked")
				ArrayList<Unit> lList = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				request.setAttribute("units", lList);
				
				@SuppressWarnings("unchecked")
				ArrayList<PaymentResponsible> responsibles = (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibles());
				request.setAttribute("responsibles", responsibles);
				
				@SuppressWarnings("unchecked")
				ArrayList<ClinicType> clinic = (ArrayList<ClinicType>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetClinicTypes());
				request.setAttribute("clinic", clinic);
				
				rd = getServletContext().getRequestDispatcher("/editEstimation.jsp");			
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
			
				String submit = request.getParameter("sbmtButton");
				System.out.println(submit);
				String[] fields = {"estimationid", "patientid", "unitId", "specialist", "clinicType", "paymentId", "aval", "titular", "cedIdTitular", "cedulaTitular", "nameTitular"};
				Map<String, String> params = new HashMap<String, String>();
				for(int i=0; i< fields.length; i++ ){
					params.put(fields[i] , (String) request.getParameter(fields[i]));
				}
				String pid = params.get("cedIdTitular") + params.get("cedulaTitular");
				if (params.get("cedulaTitular").equals("") ||  params.get("titular")!= null)   pid = null;
				String name = params.get("nameTitular");
				if (params.get("nameTitular").equals("")   ||  params.get("titular")!= null)   name = null;
				if (params.get("titular") != null && params.get("titular").equals("1")){
					pid = null; name = null;
				}
				try {
					Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditEstimation(params.get("patientid"), params.get("unitId"), params.get("specialist"), params.get("paymentId"), params.get("aval"), params.get("titular"), pid,  name,  params.get("clinicType"), params.get("estimationid"), String.valueOf(userE.getUserID())));
					//Leer todos los protocolos
					@SuppressWarnings("unchecked")
					ArrayList<Protocol> pt = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocols());
					request.setAttribute("pt", pt);
					request.setAttribute("spID", String.valueOf(params.get("estimationid")));
					
					//Obtener los protocolos del presupuesto
					
					@SuppressWarnings("unchecked")
					ArrayList<Protocol> lp = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(params.get("estimationid")));
					request.setAttribute("lp", lp);
					
					RequestDispatcher rd;
					if (submit.equals("Guardar y Salir")){
						String text_good = "El presupuesto fue editado exitosamente";
						String text_bad = "Se ha presentado un error al editar el presupuesto. Por favor, intente nuevamente.";
						if (result == 1) {
							session.setAttribute("info",text_good);
						}
						else {
							session.setAttribute("info",text_bad);
						}
						response.sendRedirect(request.getContextPath() + "/ListEstimationsServlet");	
					}else{
						rd = getServletContext().getRequestDispatcher("/editEstimationProtocol.jsp");			
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
