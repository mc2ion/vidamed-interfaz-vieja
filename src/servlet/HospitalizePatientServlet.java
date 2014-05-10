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
 * Servlet implementation class HospitalizePatientServlet
 */
@WebServlet(description = "servlet to remove admission", urlPatterns = { "/HospitalizePatientServlet" })
public class HospitalizePatientServlet extends HttpServlet {
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
    public HospitalizePatientServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		try {
			Long userID	 = Long.parseLong(request.getParameter("userID"));
			//String gastos	= request.getParameter("gastos");
			//Falta hacer los traslados de gastos
			
				int result	 = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.HospitalizePatient(userID));
			if (result == 1)
				session.setAttribute("info","El cliente fue hospitalizado exitosamente.");
			else
				session.setAttribute("info","Hubo un problema al hospitalizar al paciente. Por favor, intente nuevamente.");
			response.sendRedirect("./ListEmergenciesServlet");
		}
		catch (Exception e) {
			throw new ServletException(e);
		}
	}
}
