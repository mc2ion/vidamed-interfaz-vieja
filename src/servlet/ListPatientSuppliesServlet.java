
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
import domain.PatientSupply;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListPatientSuppliesServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListPatientSuppliesServlet" })
public class ListPatientSuppliesServlet extends HttpServlet {
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
    public ListPatientSuppliesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.pharmacyPatients);
		if(userE != null && perm ){
			try {
				Long id = Long.parseLong(request.getParameter("id"));
				String name = request.getParameter("name");
				String sec = request.getParameter("sec");
				ArrayList<PatientSupply> supplies = (ArrayList<PatientSupply>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientSuppliesByAdmission(id));
				request.setAttribute("patName", name);
				request.setAttribute("supplies", supplies);
				request.setAttribute("adminId", String.valueOf(id));
				request.setAttribute("sec", sec);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/patientSupplies.jsp");
				rd.forward(request, response);
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
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
