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
import domain.Hospitalization;
import domain.PaymentResponsible;
import domain.PermissionsList;
import domain.Protocol;
import domain.Unit;
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
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.hospitalization);
		if(userE != null && perm ){
			Long id = Long.valueOf(request.getParameter("id"));
			RequestDispatcher rd;
			try {
				Hospitalization hospitalization = (Hospitalization) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetHospitalization(id));
				
				//Lista de responsables
				@SuppressWarnings("unchecked")
				ArrayList<PaymentResponsible> a =  (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command. GetEstimationPaymentResponsibles(id));
				
				request.setAttribute("hospitalization", hospitalization);
				request.setAttribute("paymentR", a);
				
				//Lista de camas
				@SuppressWarnings("unchecked")
				ArrayList<BedLocation> lList = (ArrayList<BedLocation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.SearchLocations());
				request.setAttribute("locations", lList);
				
				@SuppressWarnings("unchecked")
				ArrayList<Unit> lLis = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				request.setAttribute("units", lLis);
				System.out.println(lLis.size());
				
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> protocols = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(String.valueOf(hospitalization.getId())));
				request.setAttribute("protocols", protocols);
				
				rd = getServletContext().getRequestDispatcher("/editHospitalization.jsp");			
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
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.hospitalization);
		if(userE != null && perm ){
			try {
				Long bedId 	 	 	 = Long.valueOf(request.getParameter("bed"));
				Long admissionId 	 = Long.valueOf(request.getParameter("admissionId"));
				Long specId 	 	 = Long.valueOf(request.getParameter("specialist"));
				Long unitId 	 	 = Long.valueOf(request.getParameter("unitId"));
				
				Integer result  = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditLocation(admissionId, bedId));
				result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditEstimationSpecialist(admissionId, specId, unitId));
				
				String text = "La hospitalización fue actualizada exitosamente.";
				if (result == 0)
					text =	"Hubo un problema al actualizar la hospitalización. Por favor, intente nuevamente.";
				
				session.setAttribute("info", text);
				response.sendRedirect(request.getContextPath() + "/ListHospitalizationsServlet");
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
