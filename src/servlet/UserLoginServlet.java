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
		try{
			String name = request.getParameter("username");
			String password = request.getParameter("password");
			//String encryptPassword = getEncryptPassword(password);
			User user = (User) CommandExecutor.getInstance().executeDatabaseCommand(new command.UserExists(name, password));
			RequestDispatcher rd;
			
			if(user != null){
				ArrayList<UserPermission> userPermissions = (ArrayList<UserPermission>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserPermissions(user.getUserID()));
				HttpSession session = request.getSession(true);
				session.setAttribute("user", user);
				session.setAttribute("userPermissions", userPermissions);
				//request.setAttribute("user", user);
				System.out.println("user" + user);
				rd = getServletContext().getRequestDispatcher("/mainMenu.jsp");			

				rd.forward(request, response);
			} else {
				request.setAttribute("error", "La información de nombre de usuario o contraseña introducida no es correcta.");
				rd = getServletContext().getRequestDispatcher("/index.jsp");			
				rd.forward(request, response);
			}
			
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
