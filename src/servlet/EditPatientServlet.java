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
				
				request.setAttribute("phoneNumbers", phoneNumbers);
				request.setAttribute("patient", p);
				
				rd = getServletContext().getRequestDispatcher("/editPatient.jsp");			
				rd.forward(request, response);
			}catch (Exception e) {
				// TODO Auto-generated catch block
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
	/*protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
			if(userE != null){
			String submit = request.getParameter("submit");
			RequestDispatcher rd;
			try{
				if (submit != null && submit.equals("find")){
					String txtCedId 	= request.getParameter("txtCedId");
					String txtCedIdNum 	= request.getParameter("txtCedIdNum");
					String patientType  = request.getParameter("txtPatientType");
					String function  	= request.getParameter("f");
					
					request.setAttribute("cedId", txtCedId);
					request.setAttribute("cedNum", txtCedIdNum);
					request.setAttribute("patientType", patientType);
					request.setAttribute("function", function);
					
					rd = getServletContext().getRequestDispatcher("/createPatient.jsp");			
					rd.forward(request, response);
				}else{
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
					String function	 	 = request.getParameter("function");
					
					Long userID = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatient(identityCard, isAdult, firstName, lastName, birthday, gender, address, email));
					for (int i = 0; i < 2; i++) {
						String type = request.getParameter("txtType" + i); 
						String phoneNumber = request.getParameter("txtPhoneNumber" + i); 
						if (phoneNumber != null && !phoneNumber.trim().equals("")) {
							CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientPhoneNumber(userID, type, phoneNumber));
						}
					}
					// Ir a la seccion de la cual venia el usuario y pasar la informacion del usuario
					System.out.println(function);
					if (function.equals("estimation")){
						System.out.println("aqui");
						request.setAttribute("txtCedNumber", identityCard);
						request.setAttribute("txtName", firstName);
						request.setAttribute("txtLastName", lastName);
						request.setAttribute("patientID", String.valueOf(userID));
						request.setAttribute("function", function);
						RequestDispatcher rd2 = getServletContext().getRequestDispatcher("/CreateEstimationServlet");
						rd2.forward(request,response);
					}else if(function.equals("admision")){
						// Crear presupuesto para el paciente recien creado.
						request.setAttribute("txtCedNumber", identityCard);
						request.setAttribute("txtName", firstName);
						request.setAttribute("txtLastName", lastName);
						request.setAttribute("patientID", String.valueOf(userID));
						request.setAttribute("function", function);
						
						
						User pat = new User();
						pat.setFirstName(firstName);
						pat.setLastName(lastName);
						pat.setIdentityCard(identityCard);
						session.setAttribute("userInfo", pat);
						//llamando a doget para que llame al servlet por el get!
						doGet(request, response);
						//rd = getServletContext().getRequestDispatcher("/CreateEstimationServlet");			
						//rd.forward(request, response);
					}
				}
			}catch(Exception e ){
				System.out.print(e.getMessage());
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
	}*/
}
