package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.Permission;
import domain.PermissionModule;



/**
 * Servlet implementation class CreateUserServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateUserServlet" })
public class CreateUserServlet extends HttpServlet {
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
    public CreateUserServlet() {
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
				HashMap<Long, String> userUnits = (HashMap<Long, String>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserUnits());
				ArrayList<PermissionModule> permissionModules = (ArrayList<PermissionModule>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPermissionModules());
				HashMap<Long, ArrayList<Permission>> permissions = new HashMap<Long, ArrayList<Permission>>();
				for (int i = 0; i< permissionModules.size(); i++) {
					Long moduleID = permissionModules.get(i).getPermissionModuleID();
					ArrayList<Permission> ps = (ArrayList<Permission>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPermissions(moduleID));
					permissions.put(moduleID, ps);
				}
				request.setAttribute("userUnits", userUnits);
				request.setAttribute("permissionModules", permissionModules);
				request.setAttribute("permissions", permissions);
				rd = getServletContext().getRequestDispatcher("/createUser.jsp");			
				rd.forward(request, response);
			}
			else {
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
				String password = request.getParameter("txtPassword");
				
				Long userID = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddUser(identityCard, firstName, lastName, birthday, gender, address, email, userUnitID, startDate, position, salary, userName, password));
				
				for (int i = 0; i<4; i++) {
					String type = request.getParameter("txtType" + i); 
					String phoneNumber = request.getParameter("txtPhoneNumber" + i); 
					if (phoneNumber != null && !phoneNumber.trim().equals("")) {
						CommandExecutor.getInstance().executeDatabaseCommand(new command.AddUserPhoneNumber(userID, type, phoneNumber));
					}
				}
				
				String[] permissions = request.getParameterValues("permissions");
				if (permissions != null) {
					for (int i = 0; i<permissions.length; i++) {
						CommandExecutor.getInstance().executeDatabaseCommand(new command.AddUserPermission(userID, Long.parseLong(permissions[i])));
					}
				}
				rd = getServletContext().getRequestDispatcher("/ListUsersServlet");			
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
