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
import domain.Permission;
import domain.PermissionModule;
import domain.User;
import domain.UserPermission;
import domain.UserPhoneNumber;



/**
 * Servlet implementation class EditUserServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditUserServlet" })
public class EditUserServlet extends HttpServlet {
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
    public EditUserServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			String action = request.getParameter("sbmtButton");
			Long userID = Long.parseLong(request.getParameter("userID"));
			RequestDispatcher rd;
			if (action == null || action.trim().equals("")) {
				User user = (User) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUser(userID));
				ArrayList<UserPermission> auxPermissions = (ArrayList<UserPermission>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserPermissions(userID));
				HashMap<Long, UserPermission> userPermissions = new HashMap<Long, UserPermission>();
				for (int i = 0; i<auxPermissions.size(); i++) {
					userPermissions.put(auxPermissions.get(i).getPermissionID(), auxPermissions.get(i));
				}
				HashMap<Long, String> userUnits = (HashMap<Long, String>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserUnits());;
				ArrayList<UserPhoneNumber> userPhoneNumbers = (ArrayList<UserPhoneNumber>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserPhoneNumbers(userID));
				ArrayList<PermissionModule> permissionModules = (ArrayList<PermissionModule>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPermissionModules());
				HashMap<Long, ArrayList<Permission>> permissions = new HashMap<Long, ArrayList<Permission>>();
				for (int i = 0; i< permissionModules.size(); i++) {
					Long moduleID = permissionModules.get(i).getPermissionModuleID();
					ArrayList<Permission> ps = (ArrayList<Permission>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPermissions(moduleID));
					permissions.put(moduleID, ps);
				}
				request.setAttribute("user", user);
				request.setAttribute("userPermissions", userPermissions);
				request.setAttribute("userPhoneNumbers", userPhoneNumbers);
				request.setAttribute("userUnits", userUnits);
				request.setAttribute("permissionModules", permissionModules);
				request.setAttribute("permissions", permissions);
				
				rd = getServletContext().getRequestDispatcher("/editUser.jsp");			
				rd.forward(request, response);
			}
			else {
				HttpSession session = request.getSession(false);
				String text_good = "El usuario fue editado exitosamente.";
				String text_bad = "Se ha presentado un error al editar el usuario. Por favor, intente nuevamente.";
				String identityCard = request.getParameter("txtCedId") + request.getParameter("txtCedIdNum");
				String firstName = request.getParameter("txtFirstName");
				String lastName = request.getParameter("txtLastName");
				String birthday = request.getParameter("txtDateIni");
				String gender = request.getParameter("txtGen");
				String address = request.getParameter("txtAddress");
				String email = request.getParameter("txtEmail");
				Long userUnitID = Long.parseLong(request.getParameter("txtUnitId"));
				String startDate = request.getParameter("txtDateIni2");
				String position = request.getParameter("txtPosition");
				Double salary = Double.parseDouble(request.getParameter("txtSalary"));
				String userName = request.getParameter("txtUserName");
				boolean phoneNumberError = false;
				boolean permissionError = false;
				
				int result = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditUser(userID, identityCard, firstName, lastName, birthday, gender, address, email, userUnitID, startDate, position, salary, userName));
				if (result == 1) {
					for (int i = 0; i<4; i++) {					
						String phoneNumberID = request.getParameter("txtPhoneId" + i);
						String type = request.getParameter("txtType" + i); 
						String phoneNumber = request.getParameter("txtPhoneNumber" + i); 
						if (phoneNumberID == null || phoneNumberID.trim().equals("")) {
							if (phoneNumber != null && !phoneNumber.trim().equals("")) {
								Long pnID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddUserPhoneNumber(userID, type, phoneNumber));
								if (pnID == null && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al editar uno o más números telefónicos del usuario. Por favor, intente nuevamente.";
								}
							}
						}
						else {
							if (phoneNumber != null && !phoneNumber.trim().equals("")) {
								Long pnID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditUserPhoneNumber(Long.parseLong(phoneNumberID), type, phoneNumber));
								if (pnID == null && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al editar uno o más números telefónicos del usuario. Por favor, intente nuevamente.";
								}
							}
							else {
								int resp = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveUserPhoneNumber(Long.parseLong(phoneNumberID)));
								if (resp == 0 && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al editar uno o más números telefónicos del usuario. Por favor, intente nuevamente.";
								}
							}
						}
					}

					ArrayList<UserPermission> auxPermissions = (ArrayList<UserPermission>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserPermissions(userID));
					HashMap<Long, UserPermission> userPermissions = new HashMap<Long, UserPermission>();
					for (int i = 0; i<auxPermissions.size(); i++) {
						userPermissions.put(auxPermissions.get(i).getPermissionID(), auxPermissions.get(i));
					}
					String[] permissions = request.getParameterValues("permissions");
					if (permissions != null) {
						for (int i = 0; i<permissions.length; i++) {
							if (userPermissions.containsKey(Long.parseLong(permissions[i]))) {
								userPermissions.remove(Long.parseLong(permissions[i]));
							}
							else {
								int resp = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddUserPermission(userID, Long.parseLong(permissions[i])));
								if (resp == 0 && !permissionError) {
									permissionError = true;
									text_good += " Se ha presentado un error al editar uno o más permisos del usuario. Por favor, intente nuevamente.";
								}
							}
						}
					}
					Iterator<Long> it = userPermissions.keySet() == null ? new ArrayList<Long>().iterator() : userPermissions.keySet().iterator();
					while (it.hasNext()) {
						Long permissionID = it.next();
						int resp = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveUserPermission(userID, permissionID));
						if (resp == 0 && !permissionError) {
							permissionError = true;
							text_good += " Se ha presentado un error al editar uno o más permisos del usuario. Por favor, intente nuevamente.";
						}
					}
					session.setAttribute("info",text_good);
				}
				else {
					session.setAttribute("info",text_bad);
				}
				
				response.sendRedirect(request.getContextPath() + "/ListUsersServlet");
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
