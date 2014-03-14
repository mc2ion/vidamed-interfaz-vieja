package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
				Long userID = Long.parseLong(request.getParameter("userID"));
				String password = request.getParameter("txtPassword");
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditUserPassword(userID, password));
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/ListUsersServlet");			
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
