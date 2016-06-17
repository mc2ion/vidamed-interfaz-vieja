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
import domain.PatientAdditionalService;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListAdditionalServicesByAdmissionServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListAdditionalServicesByAdmissionServlet" })
public class ListAdditionalServicesByAdmissionServlet extends HttpServlet {
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
    public ListAdditionalServicesByAdmissionServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.additionalServices);
		if(userE != null && perm ){
		try {
			Long id = Long.parseLong(request.getParameter("id"));
			//Long servId = Long.parseLong(request.getParameter("servId"));
				
			String name = request.getParameter("name");
			ArrayList<PatientAdditionalService> advice = (ArrayList<PatientAdditionalService>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdditionalServicesByAdmission(id));
			request.setAttribute("patName", name);
			request.setAttribute("advice", advice);
			//request.setAttribute("servId", String.valueOf(servId));
			request.setAttribute("adminId", String.valueOf(id));
			
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/patientAdditionalServices.jsp");
			rd.forward(request, response);
		} 
		catch (Exception e) {
			throw new ServletException(e);
		}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}	
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
