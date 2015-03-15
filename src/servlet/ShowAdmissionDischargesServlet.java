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
import domain.Hospitalization;
import domain.PatientService;
import domain.PermissionsList;
import domain.Protocol;
import domain.User;



/**
 * Servlet implementation class ShowHospitalizationServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ShowAdmissionDischargesServlet" })
public class ShowAdmissionDischargesServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static final Long bloodBankService = 1L;
	private static final Long ecosonographyService = 2L;
	private static final Long labService = 3L;
	private static final Long xRayService = 4L;
	
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
    public ShowAdmissionDischargesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.admissionDischarge);
		if(userE != null && perm ){
			Long id = Long.valueOf(request.getParameter("id"));
			RequestDispatcher rd;
			try {
				Hospitalization hosp = (Hospitalization) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetHospitalization(id));
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> protocols = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(String.valueOf(hosp.getEstimationId())));
				@SuppressWarnings("unchecked")
				ArrayList<PatientService> xRayServices = (ArrayList<PatientService>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientServicesByAdmission(id, xRayService));
				@SuppressWarnings("unchecked")
				ArrayList<PatientService> bloodBankServices = (ArrayList<PatientService>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientServicesByAdmission(id, bloodBankService));
				@SuppressWarnings("unchecked")
				ArrayList<PatientService> ecosonographyServices = (ArrayList<PatientService>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientServicesByAdmission(id, ecosonographyService));
				@SuppressWarnings("unchecked")
				ArrayList<PatientService> labServices = (ArrayList<PatientService>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientServicesByAdmission(id, labService));
				
				request.setAttribute("hospitalization", hosp);
				request.setAttribute("protocols", protocols);
				request.setAttribute("xRayServices", xRayServices);
				request.setAttribute("bloodBankServices", bloodBankServices);
				request.setAttribute("ecosonographyServices", ecosonographyServices);
				request.setAttribute("labServices", labServices);
				
				rd = getServletContext().getRequestDispatcher("/showAdmissionDischarges.jsp");			
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
		
		doGet(request, response);
	}
}
