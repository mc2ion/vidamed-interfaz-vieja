package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;



/**
 * Servlet implementation class EditAdmissionStatusServlet
 */
@WebServlet(description = "servlet to edit admission's status", urlPatterns = { "/EditAdmissionStatusServlet" })
public class EditAdmissionStatusServlet extends HttpServlet {
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
    public EditAdmissionStatusServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		try{
			Long id 		= Long.valueOf(request.getParameter("userID"));
			Long status  	= Long.valueOf(request.getParameter("status"));
			int result 		= (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditAdmissionStatus(status, id));
			if (result == 1)
				session.setAttribute("info","El estado de la admisión fue editada exitosamente");
			else
				session.setAttribute("info","Se ha presentado un error al editar el estado de la admisión. Por favor, intente nuevamente.");
			response.sendRedirect(request.getContextPath() + "/ListAdmissionsServlet");
		}catch(Exception e){
			System.out.print("error " + e.getMessage());
		}
		
	}
}
