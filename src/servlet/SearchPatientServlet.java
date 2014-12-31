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

import org.json.JSONArray;

import command.CommandExecutor;
import domain.Patient;
import domain.User;



/**
 * Servlet implementation class SearchPatientServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/SearchPatientServlet" })
public class SearchPatientServlet extends HttpServlet {
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
    public SearchPatientServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//RequestDispatcher rd;
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			String patientType  = request.getParameter("patientType");
			String cedType 		= request.getParameter("txtCedId"); 
			String cedNum 		= request.getParameter("txtCedIdNum"); 
			String identityCard = cedType + cedNum;
			String estimationNumber = request.getParameter("estimation");
			
			// Si tengo el numero de presupuesto busco por el.
			if (estimationNumber != null && estimationNumber != ""){
				Patient patient  = null;
				try {
					patient = (Patient) CommandExecutor.getInstance().executeDatabaseCommand(new command.SearchNumEstimation(estimationNumber));
					
					if (patient == null){
						response.setContentType("text/plain");  
						response.setCharacterEncoding("UTF-8"); 
						response.getWriter().write("not found"); 
					}else{
						response.setContentType("text/plain");  
						response.setCharacterEncoding("UTF-8"); 
						String resp = patient.getPatientID() + "/" + patient.getIdentityCard() + "/" + patient.getFirstName() + "/" + patient.getLastName() +
										  patient.getEstimationID() + "/" + patient.getPaymentResponsibleId() + "/" + patient.getResponsibleName();
						response.getWriter().write(resp); 
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}else{
					try {
						@SuppressWarnings("unchecked")
						ArrayList<Patient> p = (ArrayList<Patient>) CommandExecutor.getInstance().executeDatabaseCommand(new command.SearchPatient(identityCard, patientType));
					if (p == null || p.size() == 0){
						response.setContentType("text/plain");  
						response.setCharacterEncoding("UTF-8"); 
						response.getWriter().write("not found"); 
					}else{
						response.setContentType("text/plain");  
						response.setCharacterEncoding("UTF-8"); 
						String json = (new JSONArray(p)).toString();
						response.getWriter().write(json); 
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
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
		
		doGet(request, response);
	}
}
