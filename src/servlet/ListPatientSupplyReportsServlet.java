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
import domain.PatientSupply;
import domain.PermissionsList;
import domain.SupplyArea;
import domain.SupplyForm;
import domain.User;


/**
 * Servlet implementation class ListPatientSupplyReportsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListPatientSupplyReportsServlet" })
public class ListPatientSupplyReportsServlet extends HttpServlet {
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
    public ListPatientSupplyReportsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		if(userE != null && perm ){
			try {
				@SuppressWarnings("unchecked")
				ArrayList<PatientSupply> pp = (ArrayList<PatientSupply>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientSupplyReport());
				
				@SuppressWarnings("unchecked")
				ArrayList<SupplyForm> u = (ArrayList<SupplyForm>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyForms());

				@SuppressWarnings("unchecked")
				ArrayList<SupplyArea> a = (ArrayList<SupplyArea>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyAreas());

				
				request.setAttribute("pp", pp);
				request.setAttribute("u", u);
				request.setAttribute("a", a);
				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_patient_supply.jsp");
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
		
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		
		if(userE != null && perm ){
    		String sForm 	  = request.getParameter("supplyForm");
    		String supplyF = null;
    		if (!sForm.equals("-"))
				supplyF = sForm;
    		String sArea 	  = request.getParameter("supplyArea");
    		String supplyArea = null;
    		if (!sArea.equals("-"))
				supplyArea = sArea;
    		
    		String type     = request.getParameter("type");
			String typeId   = null;
			if (!type.equals("-"))
					typeId = type;
			String identityCard  	 = request.getParameter("identityCard");
			String admissionId 	 	 = request.getParameter("admissionId");
			String estimationId 	 = request.getParameter("estimationId");
			String g 	  	  		 = request.getParameter("gender");
			String gender = null;
			if (!g.equals("-"))
				gender = g;
			
			String adult 	  	  = request.getParameter("isAdult");
			String isAdult = null;
			if (!adult.equals("-"))
				isAdult = adult;
			
			
			String regulated     = request.getParameter("isRegulated");
			String isRegulated   = null;
			if (!regulated.equals("-"))
					isRegulated = regulated;
			
			String dateIni = request.getParameter("txtDateIni");
			String dateEnd = request.getParameter("txtDateEnd");
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<PatientSupply> pp = (ArrayList<PatientSupply>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientSupplyReport(admissionId, estimationId, 
						identityCard, gender, isAdult, supplyF, null, supplyArea, typeId, null, null, dateIni, dateEnd, isRegulated));
				
				@SuppressWarnings("unchecked")
				ArrayList<SupplyForm> u = (ArrayList<SupplyForm>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyForms());

				@SuppressWarnings("unchecked")
				ArrayList<SupplyArea> a = (ArrayList<SupplyArea>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyAreas());

				
				request.setAttribute("pp", pp);
				request.setAttribute("u", u);
				request.setAttribute("a", a);
				
				request.setAttribute("supplyF", supplyF);
				request.setAttribute("supplyArea", supplyArea);
				request.setAttribute("type", typeId);
				request.setAttribute("isRegulated", isRegulated);
				request.setAttribute("identityCard", identityCard);
				request.setAttribute("gender", gender);
				request.setAttribute("isAdult", isAdult);
				request.setAttribute("admisionId", admissionId);
				request.setAttribute("estimationId", estimationId);
				request.setAttribute("dateEnd", dateEnd);
				request.setAttribute("dateIni", dateIni);
				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_patient_supply.jsp");
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
}
