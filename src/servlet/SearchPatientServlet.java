package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.Patient;



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
		
		String patientType  = request.getParameter("patientType");
		String cedType 		= request.getParameter("txtCedId"); 
		String cedNum 		= request.getParameter("txtCedIdNum"); 
		String identityCard = cedType + cedNum;
		
		Patient p = null;
		try {
			p = (Patient) CommandExecutor.getInstance().executeDatabaseCommand(new command.SearchPatient(identityCard, patientType));
			
			if (p == null){
				response.setContentType("text/plain");  
				response.setCharacterEncoding("UTF-8"); 
				response.getWriter().write("not found"); 
			}else{
				response.setContentType("text/plain");  
				response.setCharacterEncoding("UTF-8"); 
				String patient = p.getPatientID() + "/" + p.getIdentityCard() + "/" + p.getFirstName() + "/" + p.getLastName();
				response.getWriter().write(patient); 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
