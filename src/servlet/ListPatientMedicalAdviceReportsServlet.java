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
import domain.PatientMedicalAdvice;
import domain.PermissionsList;
import domain.Unit;
import domain.User;


/**
 * Servlet implementation class ListPatientMedicalAdviceReportsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListPatientMedicalAdviceReportsServlet" })
public class ListPatientMedicalAdviceReportsServlet extends HttpServlet {
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
    public ListPatientMedicalAdviceReportsServlet() {
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
				ArrayList<PatientMedicalAdvice> pp = (ArrayList<PatientMedicalAdvice>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientMedicalAdviceReport());
				
				@SuppressWarnings("unchecked")
				ArrayList<Unit> u = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());

				
				request.setAttribute("pp", pp);
				request.setAttribute("u", u);
				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_patient_medicalAdvice.jsp");
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
			
			String dateIni = request.getParameter("txtDateIni");
			String dateEnd = request.getParameter("txtDateEnd");
			
			String sIdentityCard  	 = request.getParameter("sIdentityCard");
			
			String sRif = request.getParameter("sRif");
			String sg 	  	  		 = request.getParameter("sGender");
			String sGender = null;
			if (!sg.equals("-"))
				sGender = sg;
			
			String unit 	  	  		 = request.getParameter("unitId");
			String unitId = null;
			if (!unit.equals("-"))
				unitId = unit;
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<PatientMedicalAdvice> pp = (ArrayList<PatientMedicalAdvice>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientMedicalAdviceReport(admissionId, estimationId, identityCard, gender, isAdult, unitId, sIdentityCard, sRif, sGender, dateIni, dateEnd));
				
				@SuppressWarnings("unchecked")
				ArrayList<Unit> u = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());

				
				request.setAttribute("pp", pp);
				request.setAttribute("u", u);
				
				request.setAttribute("sIdentityCard", sIdentityCard);
				request.setAttribute("sRif", sRif);
				request.setAttribute("identityCard", identityCard);
				request.setAttribute("gender", gender);
				request.setAttribute("isAdult", isAdult);
				request.setAttribute("admisionId", admissionId);
				request.setAttribute("estimationId", estimationId);
				request.setAttribute("dateEnd", dateEnd);
				request.setAttribute("dateIni", dateIni);
				request.setAttribute("unitId", unitId);
				request.setAttribute("sGender", sGender);
					
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_patient_medicalAdvice.jsp");
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
