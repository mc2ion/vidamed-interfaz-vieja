package servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sun.misc.BASE64Encoder;
import command.CommandExecutor;
import domain.Permission;
import domain.PermissionModule;
import domain.User;



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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
		
			try {
				String action = request.getParameter("txtFirstName");
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
					String text_good = "El usuario fue creado exitosamente.";
					String text_bad = "Se ha presentado un error al crear el usuario. Por favor, intente nuevamente.";
					String text_ident = "La cédula introducida ya está registrada.";
					String text_user = "El nombre de usuario escogido ya existe. Por favor, intente nuevamente con un nuevo usuario.";
					
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
					String encryptPassword = getEncryptPassword(password);
					boolean phoneNumberError = false;
					boolean permissionError = false;
					
					Long userID = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddUser(identityCard, firstName, lastName, birthday, gender, address, email, userUnitID, startDate, position, salary, userName, encryptPassword));
					if (userID == -1)
						session.setAttribute("info",text_ident);
					else if (userID == -2)
						session.setAttribute("info",text_user);
					else if (userID != null) {
						for (int i = 0; i<4; i++) {
							String type = request.getParameter("txtType" + i); 
							String phoneNumber = request.getParameter("txtPhoneNumber" + i); 
							if (phoneNumber != null && !phoneNumber.trim().equals("")) {
								Long phoneNumberID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddUserPhoneNumber(userID, type, phoneNumber));
								if (phoneNumberID == null && !phoneNumberError) {
									phoneNumberError = true;
									text_good += " Se ha presentado un error al asociar uno o más números telefónicos al usuario. Por favor, intente nuevamente.";
								}
							}
						}
	
						String[] permissions = request.getParameterValues("permissions");
						if (permissions != null) {
							for (int i = 0; i<permissions.length; i++) {
								int result = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddUserPermission(userID, Long.parseLong(permissions[i])));
								if (result == 0 && !permissionError) {
									permissionError = true;
									text_good += " Se ha presentado un error al asociar uno o más permisos al usuario. Por favor, intente nuevamente.";
								}
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
	
	
	/**
	 * 
	 * @param password
	 * @return
	 */
	public static String getEncryptPassword(String password){
		MessageDigest md;

		try {

			md = MessageDigest.getInstance("SHA");
			String clearPassword = password;
			md.update(clearPassword.getBytes("UTF-8"));
	        byte[] digestedPassword = md.digest();
		    String hash = (new BASE64Encoder()).encode(digestedPassword);
		    return hash;

		} catch (NoSuchAlgorithmException e) {

			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return null;
	}
}
