package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.BussinessMicro;
import domain.EstimationSpecialist;
import domain.PermissionsList;
import domain.ProtocolScale;
import domain.Unit;
import domain.User;

/**
 * Servlet implementation class EditEstimationProtocolServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditEstimationProtocolServlet" })
public class EditEstimationProtocolServlet extends HttpServlet {
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
    public EditEstimationProtocolServlet() {
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
			String estimationID = request.getParameter("estimationID");
			String protocolID = request.getParameter("protocolID");
			System.out.println(estimationID + " " + protocolID);
		
			try {
				@SuppressWarnings("unchecked")
				List<ProtocolScale> est = (List<ProtocolScale>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetFinalEstimationProtocolScale(estimationID, protocolID));
				request.setAttribute("p", est);
				RequestDispatcher rd;
				
				@SuppressWarnings("unchecked")
				ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
				request.setAttribute("bm", bm);
				
				@SuppressWarnings("unchecked")
				ArrayList<Unit> lList = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				request.setAttribute("units", lList);
				
				@SuppressWarnings("unchecked")
				ArrayList<EstimationSpecialist> spec = (ArrayList<EstimationSpecialist>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationSpecialists(estimationID, protocolID));
				request.setAttribute("spec", spec);
				
				
				rd = getServletContext().getRequestDispatcher("/editEstimationProtocolStep2.jsp");
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
			//Medicos
			String[] id = request.getParameterValues("ids");
			String estimationid = request.getParameter("estimationid");
			String protocolid   = request.getParameter("protocolid");
			String honorario    = "";
			
			for (int i = 0 ; i < id.length; i++){
				if (id[i] != null){
					String specialistid  = request.getParameter("specialist" + id[i]);
					//String unitid  		 = request.getParameter("unitId" + id[i]);
					String scaleId	   = id[i];
					try {
						if (id[i] != null && id[i].equals("29")){
							honorario = request.getParameter("hon" + id[i]);
							CommandExecutor.getInstance().executeDatabaseCommand(new command.EditEstimationProtocolScale(estimationid, protocolid, scaleId, honorario));
						}
						//Agrego el especialista
						System.out.println("agrego " + specialistid + " b "  + scaleId + " c " + protocolid  + " d " + estimationid  + " e "+ honorario);
						//CommandExecutor.getInstance().executeDatabaseCommand(new command.EditEstimationSpecialist(estimationid, specialistid, uni));
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			
			//Items costo variables
			String[] variable = request.getParameterValues("variableids");
			if (variable != null){
				for (int i = 0 ; i < variable.length; i++){
				if (variable[i] != null){
					String scaleId	  = variable[i];
					String costo	  = request.getParameter("variable" + variable[i]);
					try {
						CommandExecutor.getInstance().executeDatabaseCommand(new command.EditEstimationProtocolScale(estimationid, protocolid, scaleId, costo));
						System.out.println("agrego " + scaleId + " b "  + costo );
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			}
			
			//Obtener valores establecidos
			try {
				@SuppressWarnings("unchecked")
				ArrayList<ProtocolScale> ps = (ArrayList<ProtocolScale>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetFinalEstimationProtocolScale(estimationid, protocolid));
				request.setAttribute("ps", ps);
				
				@SuppressWarnings("unchecked")
				ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
				request.setAttribute("bm", bm);
				
				request.setAttribute("estimationID", estimationid);
				request.setAttribute("protocolID", protocolid);
				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/showFinalEstimationProtocolScale_edit.jsp");			
				rd.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
		
		
		/*HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm){
				String[] fields = {"estimationid", "patientid", "unitId", "specialist", "clinicType", "paymentId", "aval", "titular", "cedIdTitular", "cedulaTitular", "nameTitular"};
				Map<String, String> params = new HashMap<String, String>();
				for(int i=0; i< fields.length; i++ ){
					params.put(fields[i] , (String) request.getParameter(fields[i]));
				}
				String pid = params.get("cedIdTitular") + params.get("cedulaTitular");
				if (params.get("cedulaTitular").equals("") ||  params.get("titular")!= null)   pid = null;
				String name = params.get("nameTitular");
				if (params.get("nameTitular").equals("")   ||  params.get("titular")!= null)   name = null;
				try {
					CommandExecutor.getInstance().executeDatabaseCommand(new command.EditEstimation(params.get("patientid"), params.get("unitId"), params.get("specialist"), params.get("paymentId"), params.get("aval"), params.get("titular"), pid,  name,  params.get("clinicType"), params.get("estimationid"), String.valueOf(userE.getUserID())));
					//Leer todos los protocolos
					@SuppressWarnings("unchecked")
					ArrayList<Protocol> pt = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocols());
					request.setAttribute("pt", pt);
					request.setAttribute("spID", String.valueOf(params.get("estimationid")));
					
					//Obtener los protocolos del presupuesto
					
					@SuppressWarnings("unchecked")
					ArrayList<Protocol> lp = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(params.get("estimationid")));
					request.setAttribute("lp", lp);
					
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/editEstimationProtocol.jsp");			
					rd.forward(request, response);
					
				} catch (Exception e) {
				e.printStackTrace();
				}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}*/
	}
}
