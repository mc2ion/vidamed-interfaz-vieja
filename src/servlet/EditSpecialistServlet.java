package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.Specialist;
import domain.SpecialistPhoneNumber;
import domain.SpecialistUnit;
import domain.Unit;



/**
 * Servlet implementation class EditDoctorServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditSpecialistServlet" })
public class EditSpecialistServlet extends HttpServlet {
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
    public EditSpecialistServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			String action = request.getParameter("sbmtButton");
			Long specialistID = Long.parseLong(request.getParameter("specialistID"));
			RequestDispatcher rd;
			if (action == null || action.trim().equals("")) {
				Specialist spec = (Specialist) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSpecialist(specialistID));
				ArrayList<SpecialistUnit> auxUnits = (ArrayList<SpecialistUnit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSpecialistUnits(specialistID));
				HashMap<Long, SpecialistUnit> specialistUnits = new HashMap<Long, SpecialistUnit>();
				for (int i = 0; i<auxUnits.size(); i++) {
					specialistUnits.put(auxUnits.get(i).getUnitID(), auxUnits.get(i));
				}
				ArrayList<SpecialistPhoneNumber> specialistPhoneNumbers = (ArrayList<SpecialistPhoneNumber>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSpecialistPhoneNumbers(specialistID));
				ArrayList<Unit> units = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				request.setAttribute("specialist", spec);
				request.setAttribute("specialistUnits", specialistUnits);
				request.setAttribute("specialistPhoneNumbers", specialistPhoneNumbers);
				request.setAttribute("units", units);
				
				rd = getServletContext().getRequestDispatcher("/editSpecialist.jsp");			
				rd.forward(request, response);
			}
			else {
				HttpSession session = request.getSession(false);
				String text_good = "El especialista fue editado exitosamente.";
				String text_bad = "Se ha presentado un error al editar el especialista. Por favor, intente nuevamente.";
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
				
				int result = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditSpecialist(specialistID, identityCard, firstName, lastName, birthday, gender, rif, address, email));

				if (result == 1) {
					for (int i = 0; i<4; i++) {
						
						String phoneNumberID = request.getParameter("txtPhoneId" + i);
						String type = request.getParameter("txtType" + i); 
						String phoneNumber = request.getParameter("txtPhoneNumber" + i); 
						if (phoneNumberID == null || phoneNumberID.trim().equals("")) {
							if (phoneNumber != null && !phoneNumber.trim().equals("")) {
								Long pnID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSpecialistPhoneNumber(specialistID, type, phoneNumber));
								if (pnID == null && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al editar uno o más números telefónicos del especialista. Por favor, intente nuevamente.";
								}
							}
						}
						else {
							if (phoneNumber != null && !phoneNumber.trim().equals("")) {
								Long pnID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditSpecialistPhoneNumber(Long.parseLong(phoneNumberID), type, phoneNumber));
								if (pnID == null && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al editar uno o más números telefónicos del especialista. Por favor, intente nuevamente.";
								}
							}
							else {
								int resp = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveSpecialistPhoneNumber(Long.parseLong(phoneNumberID)));
								if (resp == 0 && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al editar uno o más números telefónicos del especialista. Por favor, intente nuevamente.";
								}
							}
						}
					}
					
					ArrayList<SpecialistUnit> auxUnits = (ArrayList<SpecialistUnit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSpecialistUnits(specialistID));
					HashMap<Long, SpecialistUnit> specialistUnits = new HashMap<Long, SpecialistUnit>();
					for (int i = 0; i<auxUnits.size(); i++) {
						specialistUnits.put(auxUnits.get(i).getUnitID(), auxUnits.get(i));
					}
					String[] units = request.getParameterValues("my-select[]");
					for (int i = 0; i<units.length; i++) {
						if (specialistUnits.containsKey(Long.parseLong(units[i]))) {
							specialistUnits.remove(Long.parseLong(units[i]));
						}
						else {
							int resp = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddSpecialistUnit(specialistID, Long.parseLong(units[i])));
							if (resp == 0 && !unitError) {
								unitError = true;
								text_good += " Se ha presentado un error al editar una o más unidades del especialista. Por favor, intente nuevamente.";
							}
						}
					}
					Iterator<Long> it = specialistUnits.keySet().iterator();
					while (it.hasNext()) {
						Long unitID = it.next();
						int resp = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveSpecialistUnit(specialistID, unitID));
						if (resp == 0 && !unitError) {
							unitError = true;
							text_good += " Se ha presentado un error al editar una o más unidades del especialista. Por favor, intente nuevamente.";
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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
