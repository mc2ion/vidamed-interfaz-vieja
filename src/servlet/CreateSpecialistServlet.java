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
import domain.Unit;



/**
 * Servlet implementation class CreateDoctorServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateSpecialistServlet" })
public class CreateSpecialistServlet extends HttpServlet {
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
    public CreateSpecialistServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			String action = request.getParameter("sbmtButton");
			RequestDispatcher rd;
			if (action == null || action.trim().equals("")) {
				ArrayList<Unit> units = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				HttpSession session = request.getSession(true);
				session.setAttribute("units", units);
				rd = getServletContext().getRequestDispatcher("/createSpecialist.jsp");			
				rd.forward(request, response);
			}
			else {
				String identityCard = request.getParameter("txtCedId") + request.getParameter("txtCedIdNum");
				String firstName = request.getParameter("txtFirstName");
				String lastName = request.getParameter("txtLastName");
				String birthday = request.getParameter("txtDateIni");
				String gender = request.getParameter("txtGen");
				String rif = request.getParameter("txtRifNum");
				String address = request.getParameter("txtAddress");
				String email = request.getParameter("txtEmail");
				
				Long specialistID = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSpecialist(identityCard, firstName, lastName, birthday, gender, rif, address, email));
				
				for (int i = 0; i<4; i++) {
					String type = request.getParameter("txtType" + i); 
					String phoneNumber = request.getParameter("txtPhoneNumber" + i); 
					if (phoneNumber != null && !phoneNumber.trim().equals("")) {
						CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSpecialistPhoneNumber(specialistID, type, phoneNumber));
					}
				}
				
				String[] units = request.getParameterValues("my-select[]");
				for (int i = 0; i<units.length; i++) {
					CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSpecialistUnit(specialistID, Long.parseLong(units[i])));
				}
				
				rd = getServletContext().getRequestDispatcher("/ListSpecialistsServlet");			
				rd.forward(request, response);
			}			
		} 
		catch (Exception e) {
			throw new ServletException(e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
