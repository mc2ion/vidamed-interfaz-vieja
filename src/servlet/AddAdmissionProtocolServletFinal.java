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
import domain.ProtocolScale;
import domain.User;



/**
 * Servlet implementation class AddAdmissionProtocolServletFinal
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AddAdmissionProtocolServletFinal" })
public class AddAdmissionProtocolServletFinal extends HttpServlet {
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
    public AddAdmissionProtocolServletFinal() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm1  = PermissionsList.hasPermission(request, PermissionsList.emergency);
		boolean perm2  = PermissionsList.hasPermission(request, PermissionsList.hospitalization);
		if(userE != null && (perm2 || perm1)){
			String estimationid = request.getParameter("estimationid");
			String protocolid   = request.getParameter("protocolid");
			String function = request.getParameter("function");
			System.out.println("ultimo function " + function + " " + protocolid + " " + estimationid);
			//Obtener valores establecidos
			try {
				
				CommandExecutor.getInstance().executeDatabaseCommand(new command.GenerateEstimationProtocolRates(estimationid, protocolid));
				if (function != null && function.equals("editEmergency")){
					String text_good = "Cambios realizados exitosamente";
					session.setAttribute("info",text_good);
					response.sendRedirect(request.getContextPath() + "/EditEmergencyServlet?id=" + estimationid + "#tabs-2");
				}else {
					String text_good = "Cambios realizados exitosamente";
					session.setAttribute("info",text_good);
					response.sendRedirect(request.getContextPath() + "/EditHospitalizationServlet?id=" + estimationid + "#tabs-2");
				}
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
			
			String function = request.getParameter("function");
			
			//Medicos
			String[] id = request.getParameterValues("ids");
			String estimationid = request.getParameter("estimationid");
			String protocolid   = request.getParameter("protocolid");
			String honorario    = "";
			
			//Items base
			try {
				Long result = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddEstimationProtocolScaleBase(estimationid, protocolid));
				System.out.println(result);
			}catch (Exception e1) {
				e1.printStackTrace();
			}
			
			for (int i = 0 ; i < id.length; i++){
				if (id[i] != null){
					String specialistid  = request.getParameter("specialist" + id[i]);
					String unitid  = request.getParameter("unitId" + id[i]);
					System.out.println(unitid);
					
					String scaleId	   = id[i];
					try {
						if (id[i] != null && id[i].equals("29")){
							honorario = request.getParameter("hon" + id[i]);
							CommandExecutor.getInstance().executeDatabaseCommand(new command.AddEstimationProtocolScale(estimationid, protocolid, scaleId, honorario));
						}
						//Agrego el especialista
						System.out.println("agrego en admission " + specialistid + " b "  + scaleId + " c " + protocolid  + " d " + estimationid  + " e "+ honorario);
						CommandExecutor.getInstance().executeDatabaseCommand(new command.AddEstimationSpecilist(estimationid, protocolid, scaleId, specialistid, unitid));
						
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
						CommandExecutor.getInstance().executeDatabaseCommand(new command.AddEstimationProtocolScale(estimationid, protocolid, scaleId, costo));
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
				request.setAttribute("function", function);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/showFinalAdmissionProtocolScale.jsp");			
				rd.forward(request, response);
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
