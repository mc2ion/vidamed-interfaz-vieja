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
import domain.Unit;
import domain.User;



/**
 * Servlet implementation class ShowProtocolEstimationDetailServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ShowProtocolEstimationDetailServlet" })
public class ShowProtocolEstimationDetailServlet extends HttpServlet {
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
    public ShowProtocolEstimationDetailServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm ){
			String protocolID = request.getParameter("protocolID");
			String estimationID = request.getParameter("estimationID");
			String fnc = request.getParameter("fnc");
			
			ArrayList<ProtocolScale> est;
			try {
				est = (ArrayList<ProtocolScale>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetFinalEstimationProtocolScale(estimationID, protocolID));
				request.setAttribute("est",est);
				
				ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
				request.setAttribute("bm", bm);
				
				ArrayList<Unit> lList = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				request.setAttribute("units", lList);
				
				Integer hasMainSpecialist = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.HasMainSpecialist(protocolID));
				request.setAttribute("hms", hasMainSpecialist);
				
				RequestDispatcher rd;
				if(fnc != null && fnc.equalsIgnoreCase("emergency")){
					rd = getServletContext().getRequestDispatcher("/showProtocolEmergencyDetail.jsp");
					rd.forward(request, response);
				} else if(fnc != null && fnc.equalsIgnoreCase("hospitalization")){
					rd = getServletContext().getRequestDispatcher("/showProtocolHospitalizationDetail.jsp");
					rd.forward(request, response);
				}else if(fnc != null && fnc.equalsIgnoreCase("med")){
					rd = getServletContext().getRequestDispatcher("/showProtocolMedicalTDetail.jsp");
					rd.forward(request, response);
				}
				else {
					rd = getServletContext().getRequestDispatcher("/showProtocolEstimationDetail.jsp");	
					rd.forward(request, response);
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
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm ){
			String protocolID = request.getParameter("protocolID");
			String estimationID = request.getParameter("estimationID");
			String adminID = request.getParameter("adminID");
			String[] id = request.getParameterValues("ids");
			String honorario    = "";
			
			try {
				if(id != null){
					for (int i = 0 ; i < id.length; i++){
						if (id[i] != null){
							String specialistid  = request.getParameter("specialist" + id[i]);
							String unitid  = request.getParameter("unitId" + id[i]);
							String scaleId	   = id[i];
							
							honorario = request.getParameter("hon" + id[i]);
							CommandExecutor.getInstance().executeDatabaseCommand(new command.EditEstimationProtocolScale(estimationID, protocolID, scaleId, honorario));
							CommandExecutor.getInstance().executeDatabaseCommand(new command.EditEstimationProtocolSpecialist(specialistid, unitid, estimationID, protocolID, scaleId));
						}
					}
				}
				
				Integer result = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.UpdateEstimationProtocol(estimationID, protocolID));
				
				if(result == 1) {
					String text_good = "Cambios realizados exitosamente";
					session.setAttribute("text",text_good);
				}
				
				response.sendRedirect(request.getContextPath() + "/EditHospitalizationServlet?id=" + adminID + "#tabs-2");
			} catch (Exception e) {
				e.printStackTrace();
			}			
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
	}
}
