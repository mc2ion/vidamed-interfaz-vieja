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

import domain.Patient;
import domain.PatientPhoneNumber;
import domain.PermissionsList;
import domain.User;

/**
 * Servlet implementation class EditPatientServlet
 */
@WebServlet(description = "servlet to edit a patient", urlPatterns = { "/EditPatientServlet" })
public class EditPatientServlet extends HttpServlet {

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
    public EditPatientServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.patient);		
		
		if(userE != null && perm ){
			Long id = Long.parseLong(request.getParameter("rId"));
			try {				
				RequestDispatcher rd;				
				@SuppressWarnings("unchecked")
				ArrayList<PatientPhoneNumber> phoneNumbers = (ArrayList<PatientPhoneNumber>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientPhoneNumbers(id));
				Patient p = (Patient) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatient(id));
				System.out.println("+++ phoneNumbers:"+phoneNumbers.size());
				request.setAttribute("phoneNumbers", phoneNumbers);
				request.setAttribute("patient", p);
				
				rd = getServletContext().getRequestDispatcher("/editPatient.jsp");			
				rd.forward(request, response);
			}catch (Exception e) {
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
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.patient);	
		
		if(userE != null && perm ){
			Long patientID = Long.parseLong(request.getParameter("patientID"));
			try{
				String text_good = "El paciente fue editado exitosamente.";
				String text_bad = "Se ha presentado un error al editar el paciente. Por favor, intente nuevamente.";
				String text_ident = "No se ha podido editar al paciente porque la cédula introducida ya está registrada.";
				String isAdultS = request.getParameter("isAdult");
				int isAdult = 0;
				
				if (isAdultS != null){
					isAdult = Integer.valueOf(isAdultS);
				}
				
				String identityCard = request.getParameter("txtCedId") + request.getParameter("txtCedIdNum");
				String firstName	 = request.getParameter("txtFirstName");
				String lastName 	 = request.getParameter("txtLastName");
				String birthday  	 = request.getParameter("txtDateIni");
				String gender 		 = request.getParameter("txtGen");
				String address 		 = request.getParameter("txtAddress");
				String email 		 = request.getParameter("txtEmail");	
				boolean phoneNumberError = false;
				int result = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPatient(identityCard, isAdult, firstName, lastName, birthday, gender, address, email, patientID));
				
				if (result == -1)
					session.setAttribute("info",text_ident);
				else if (result != -2){
					for (int i = 0; i<2; i++) {						
						String phoneNumberID = request.getParameter("txtPhoneId" + i);
						String type = request.getParameter("txtType" + i); 
						String phoneNumber = request.getParameter("txtPhoneNumber" + i); 
						
						if (phoneNumberID == null || phoneNumberID.trim().equals("")) {
							if (phoneNumber != null && !phoneNumber.trim().equals("")) {
								Long pnID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientPhoneNumber(patientID, type, phoneNumber));
								if (pnID == null && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al editar uno o más números telefónicos del paciente. Por favor, intente nuevamente.";
								}
							}
						}
						else {
							if (phoneNumber != null && !phoneNumber.trim().equals("")) {
								Long pnID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPatientPhoneNumber(Long.parseLong(phoneNumberID), type, phoneNumber));
								if (pnID == null && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al editar uno o más números telefónicos del paciente. Por favor, intente nuevamente.";
								}
							}
							else {
								int resp = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.RemovePatientPhoneNumber(Long.parseLong(phoneNumberID)));
								if (resp == 0 && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al editar uno o más números telefónicos del especialista. Por favor, intente nuevamente.";
								}
							}
						}
					}					
					session.setAttribute("info",text_good);
				} else {
					session.setAttribute("info",text_bad);
				}
				
				response.sendRedirect(request.getContextPath() + "/ListPatientsServlet");
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
