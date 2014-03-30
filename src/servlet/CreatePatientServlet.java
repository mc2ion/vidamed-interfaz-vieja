package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;



/**
 * Servlet implementation class CreatePatientServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreatePatientServlet" })
public class CreatePatientServlet extends HttpServlet {
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
    public CreatePatientServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
				System.out.println("isAdult " + isAdult);
				
				String identityCard = request.getParameter("txtCedId") + request.getParameter("txtCedIdNum");
				String firstName	 = request.getParameter("txtFirstName");
				String lastName 	 = request.getParameter("txtLastName");
				String birthday  	 = request.getParameter("txtDateIni");
				String gender 		 = request.getParameter("txtGen");
				String address 		 = request.getParameter("txtAddress");
				String email 		 = request.getParameter("txtEmail");
				String function  	 = request.getParameter("function");
				
				System.out.println("ced " + identityCard + " "+ firstName + " " + lastName + " " + birthday + " " + gender + " " +  address + " " + email + " " + function );
				
				Long userID = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatient(identityCard, isAdult, firstName, lastName, birthday, gender, address, email));
				
				for (int i = 0; i < 2; i++) {
					String type = request.getParameter("txtType" + i); 
					String phoneNumber = request.getParameter("txtPhoneNumber" + i); 
					if (phoneNumber != null && !phoneNumber.trim().equals("")) {
						System.out.println("phone " + type + " "+ phoneNumber);
						
						CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientPhoneNumber(userID, type, phoneNumber));
					}
				}
				// Ir a la seccion de la cual venia el usuario y pasar la informacion del usuario
				if (function.equals("estimation")){
					rd = getServletContext().getRequestDispatcher("/CreateEstimationServlet");			
					rd.forward(request, response);
				}
			}
		}catch(Exception e ){
			System.out.print(e.getMessage());
		}
	}
}
