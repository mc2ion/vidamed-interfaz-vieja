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
import domain.BedLocation;
import domain.Emergency;
import domain.PermissionsList;
import domain.Protocol;
import domain.Unit;
import domain.User;



/**
 * Servlet implementation class EditEmergencyServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditEmergencyServlet" })
public class EditEmergencyServlet extends HttpServlet {
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
    public EditEmergencyServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.emergency);
		if(userE != null && perm ){
			try {
				Long id = Long.valueOf(request.getParameter("id"));
				String ac = request.getParameter("ac");
				RequestDispatcher rd;
				Emergency emergency = (Emergency) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEmergency(id));
				request.setAttribute("emergency", emergency);
				
				//Lista de camas
				@SuppressWarnings("unchecked")
				ArrayList<BedLocation> lList = (ArrayList<BedLocation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.SearchLocations());
				request.setAttribute("locations", lList);
				
				@SuppressWarnings("unchecked")
				ArrayList<Unit> lLis = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				request.setAttribute("units", lLis);
				
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> protocols = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(String.valueOf(emergency.getEstimationId())));
				request.setAttribute("protocols", protocols);
				
				request.setAttribute("action", ac);
				
				rd = getServletContext().getRequestDispatcher("/editEmergency.jsp");			
				rd.forward(request, response);
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.emergency);
		if(userE != null && perm ){
			try {
				Long bedId 	 	 = Long.valueOf(request.getParameter("bed"));
				Long admissionId = Long.valueOf(request.getParameter("admissionId"));
				Long specId 	 	 = Long.valueOf(request.getParameter("specialist"));
				Long unitId 	 	 = Long.valueOf(request.getParameter("unitId"));
				
				Integer result  = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditLocation(admissionId, bedId));
				result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditEstimationSpecialist(admissionId, specId, unitId));
				
				String text = "La emergencia fue actualizada exitosamente.";
				if (result == 0)
					text =	"Hubo un problema al actualizar la emergencia. Por favor, intente nuevamente.";
				
				session.setAttribute("info", text);
				response.sendRedirect(request.getContextPath() + "/ListEmergenciesServlet");
			}catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}	
			
	}
}
