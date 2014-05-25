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
import domain.User;



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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			try {
				String action = request.getParameter("txtFirstName");
				RequestDispatcher rd;
				if (action == null || action.trim().equals("")) {
					ArrayList<Unit> units = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
					request.setAttribute("units", units);
					rd = getServletContext().getRequestDispatcher("/createSpecialist.jsp");			
					rd.forward(request, response);
				}
				else {
					String text_good = "El especialista fue creado exitosamente.";
					String text_bad = "Se ha presentado un error al crear el especialista. Por favor, intente nuevamente.";
					String text_ident = "No se ha podido crear al especialista porque la cédula introducida ya está registrada.";
					String text_user = "No se ha podido crear al especialista  porque el rif introducido ya está registrado.";
				
					String identityCard = request.getParameter("txtCedId") + request.getParameter("txtCedIdNum");
					String firstName = request.getParameter("txtFirstName");
					String lastName = request.getParameter("txtLastName");
					String birthday = request.getParameter("txtDateIni");
					String gender = request.getParameter("txtGen");
					String rif = request.getParameter("txtRifNum");
					String address = request.getParameter("txtAddress");
					String email = request.getParameter("txtEmail");
					boolean phoneNumberError = false;
					boolean unitError = false;
					
					Long specialistID = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSpecialist(identityCard, firstName, lastName, birthday, gender, rif, address, email));
					
					if (specialistID == -1)
						session.setAttribute("info",text_ident);
					else if (specialistID == -2)
						session.setAttribute("info",text_user);
					else if (specialistID != null) {
						for (int i = 0; i<4; i++) {
							String type = request.getParameter("txtType" + i); 
							String phoneNumber = request.getParameter("txtPhoneNumber" + i); 
							if (phoneNumber != null && !phoneNumber.trim().equals("")) {
								Long phoneNumberID = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSpecialistPhoneNumber(specialistID, type, phoneNumber));
								if (phoneNumberID == null && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al asociar uno o más números telefónicos al especialista. Por favor, intente nuevamente.";
								}
							}
						}
	
						String[] units = request.getParameterValues("my-select[]");
						for (int i = 0; i<units.length; i++) {
							int result = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSpecialistUnit(specialistID, Long.parseLong(units[i])));
							if (result == 0 && !unitError) {
								unitError = true;
								text_good += " Se ha presentado un error al asociar uno o más unidades al especialista. Por favor, intente nuevamente.";
							}
						}
						session.setAttribute("info",text_good);
					}
					else {
						session.setAttribute("info",text_bad);
					}
					
					response.sendRedirect(request.getContextPath() + "/ListSpecialistsServlet");
				}			
			} 
			catch (Exception e) {
				throw new ServletException(e);
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
