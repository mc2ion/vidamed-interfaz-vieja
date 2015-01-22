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
import domain.MedicalTreatment;
import domain.PermissionsList;
import domain.Protocol;
import domain.User;



/**
 * Servlet implementation class ShowMedicalTreatmentServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ShowMedicalTreatmentServlet" })
public class ShowMedicalTreatmentServlet extends HttpServlet {
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
    public ShowMedicalTreatmentServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.medicalTPacient);
		if(userE != null && perm ){
			Long id = Long.valueOf(request.getParameter("id"));
			RequestDispatcher rd;
			try {
				MedicalTreatment med = (MedicalTreatment) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetMedicalTreatment(id));
				request.setAttribute("medical", med);
			
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> protocols = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(String.valueOf(med.getEstimationId())));
				request.setAttribute("protocols", protocols);
				rd = getServletContext().getRequestDispatcher("/showMedicalTreatment.jsp");			
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
