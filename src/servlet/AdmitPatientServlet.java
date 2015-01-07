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
import domain.AdmissionReasons;
import domain.BedLocation;
import domain.PaymentResponsible;
import domain.User;



/**
 * Servlet implementation class AdmitPatientServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AdmitPatientServlet" })
public class AdmitPatientServlet extends HttpServlet {
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
    public AdmitPatientServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			String admitPatientForm = request.getParameter("function");
			if (admitPatientForm == null)
				admitPatientForm = (String)  request.getAttribute("function");
			
			try {
				//Simulando doGet
				if (admitPatientForm != null && admitPatientForm.equals("admitPatientForm")){
					String txtCedNumber 	= request.getParameter("txtCedNumber");
					String txtName 			= request.getParameter("txtName");
					String txtLastName 		= request.getParameter("txtLastName");
					//String patientID 		= request.getParameter("patientID");
					String estimationID 	= request.getParameter("estimationId");
						
					System.out.println("a " + txtName + " " + txtLastName + " " + txtCedNumber);
					
					ArrayList<AdmissionReasons> ar = (ArrayList<AdmissionReasons>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmissionReasons());
					request.setAttribute("ar", ar);
					
					// Lista de responsable de pagos
					ArrayList<PaymentResponsible> pr = (ArrayList<PaymentResponsible>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibles());
					request.setAttribute("pr", pr);
					
					
					//Lista de camas
					ArrayList<BedLocation> lList = (ArrayList<BedLocation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.SearchLocations());
					request.setAttribute("locations", lList);
					
					
					//Presupuestos por paciente
					/*ArrayList<Estimation> est = (ArrayList<Estimation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientEstimations(Long.valueOf(patientID)));
					request.setAttribute("est", est);*/
					
					User pat = new User();
					pat.setFirstName(txtName);
					pat.setLastName(txtLastName);
					pat.setIdentityCard(txtCedNumber);
					session.setAttribute("pat", pat);
					
					System.out.println(estimationID);
					
					session.setAttribute("estimationId", estimationID);
					RequestDispatcher rd;
					rd = getServletContext().getRequestDispatcher("/admitPatient.jsp");			
					rd.forward(request, response);
				}else {
				
					String bed 				= request.getParameter("bed");
					String reasonAdmission 	= request.getParameter("reasonAdmission");
					String observations 	= request.getParameter("observations");
					String estimationID 	= request.getParameter("estimationId");
					System.out.println("a " + bed + " " + estimationID + " " + reasonAdmission + " " + observations);
					
					
					Long result = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AdmitPatient(estimationID, bed, observations, reasonAdmission));
					String text_good = " La admisión se ha creado exitosamente.";
					if (result == -1 ) {
						text_good += " Se ha presentado un error al crear la admisión. Por favor, intente nuevamente.";
					}
					session.setAttribute("info", text_good);
					response.sendRedirect(request.getContextPath() + "/ListAdmissionsServlet");
			}
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
			
		}else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
		

		
		
		//doGet(request, response);
	}
}
