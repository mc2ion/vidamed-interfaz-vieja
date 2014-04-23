package servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sun.misc.BASE64Encoder;
import command.CommandExecutor;



/**
 * Servlet implementation class EditUserPasswordServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditUserPasswordServlet" })
public class EditUserPasswordServlet extends HttpServlet {
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
    public EditUserPasswordServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			String action = request.getParameter("txtPassword");
			if (action == null || action.trim().equals("")) {
				Long userID = Long.parseLong(request.getParameter("userID"));
				request.setAttribute("userID", userID);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/editUserPassword.jsp");			
				rd.forward(request, response);
			}
			else {
				HttpSession session = request.getSession(false);
				String text_good = "La contraseña fue cambiada exitosamente.";
				String text_bad = "Se ha presentado un error al cambiar la contraseña. Por favor, intente nuevamente.";
				Long userID = Long.parseLong(request.getParameter("userID"));
				String password = request.getParameter("txtPassword");
				String encryptPassword = getEncryptPassword(password);
				
				int result = (Integer)CommandExecutor.getInstance().executeDatabaseCommand(new command.EditUserPassword(userID, encryptPassword));
				if (result == 1) {
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
