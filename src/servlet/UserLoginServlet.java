package servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sun.misc.BASE64Encoder;
import command.CommandExecutor;
import domain.User;
import domain.UserPermission;


/**
 * Servlet implementation class UserLoginServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/UserLoginServlet" })
public class UserLoginServlet extends HttpServlet {
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
    public UserLoginServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("user");
		
		RequestDispatcher rd;
		   
		if(user != null){
			rd = getServletContext().getRequestDispatcher("/mainMenu.jsp");			
			rd.forward(request, response);
		} else {
			rd = getServletContext().getRequestDispatcher("/index.jsp");			
			rd.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name = request.getParameter("username");
			String password = request.getParameter("password");
			String encryptPassword = getEncryptPassword(password);
			User user = (User) CommandExecutor.getInstance().executeDatabaseCommand(new command.UserExists(name, encryptPassword));
			RequestDispatcher rd;
			
			if(user != null){
				ArrayList<UserPermission> userPermissions = (ArrayList<UserPermission>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserPermissions(user.getUserID()));
				HttpSession session = request.getSession(true);
				session.setAttribute("user", user);
				session.setAttribute("userPermissions", userPermissions);
				rd = getServletContext().getRequestDispatcher("/mainMenu.jsp");			
				rd.forward(request, response);
			} else {
				request.setAttribute("error", "La información de nombre de usuario y/o contraseña introducida no es correcta o el usuario no existe.");
				rd = getServletContext().getRequestDispatcher("/index.jsp");			
				rd.forward(request, response);
			}
			
		} catch (Exception e) {
			throw new ServletException(e);
		}
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
