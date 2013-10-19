package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class UserLoginServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/UserLoginServlet" })
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/*public void init() throws ServletException {
		super.init();
		try {
			CommandExecutor.getInstance();
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}*/
       
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

		RequestDispatcher rd;
		   
		rd = getServletContext().getRequestDispatcher("/mainMenu.jsp");			
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try{
	//		String name = request.getParameter("txtName");
	//		String password = request.getParameter("txtPassword");
			RequestDispatcher rd;
			
			rd = getServletContext().getRequestDispatcher("/mainMenu.jsp");			
			rd.forward(request, response);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
