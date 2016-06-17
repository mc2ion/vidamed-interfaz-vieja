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
import domain.AdditionalService;
import domain.PatientAdditionalService;
import domain.PermissionsList;
import domain.User;
/**
 * Servlet implementation class EditPatientAdditionalServiceServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditPatientAdditionalServiceServlet" })
public class EditPatientAdditionalServiceServlet extends HttpServlet {
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
    public EditPatientAdditionalServiceServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.additionalServices);
		if(userE != null && perm ){
			RequestDispatcher rd;
			try {
				String id				= request.getParameter("id");
				String name   			= request.getParameter("name");
				String additionalServiceId	= request.getParameter("pmId");
				
				request.setAttribute("adminId", id);
				request.setAttribute("name", name);
				
				PatientAdditionalService pm = (PatientAdditionalService) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientAdditionalService(Long.valueOf(additionalServiceId)));
							
				@SuppressWarnings("unchecked")
				ArrayList<AdditionalService> services = (ArrayList<AdditionalService>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdditionalServices());
			
				request.setAttribute("services", services);
				request.setAttribute("pm", pm);
				
				rd = getServletContext().getRequestDispatcher("/editPatientAdditionalService.jsp");			
				rd.forward(request, response);
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.additionalServices);
		if(userE != null && perm ){
			
			try{
				String admin = request.getParameter("admissionId");
				String name  = request.getParameter("name");
				String pmId  = request.getParameter("pmId");
				
				String serviceId		= request.getParameter("serviceId");
				String amount 		= request.getParameter("amount");
				
				Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPatientAdditionalService(Long.valueOf(serviceId), amount, Long.valueOf(pmId)));
				
				String text = "El servicio fue editado exitosamente";
				if (result == 0)
					text =	"Hubo un problema al editar el servicio. Por favor, intente nuevamente.";
				
				session.setAttribute("text", text);
				response.sendRedirect(request.getContextPath() + "/ListAdditionalServicesByAdmissionServlet?id=" + admin + "&name=" + name);
		
			}catch(Exception e){
				System.out.println("error" + e.getMessage());
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
}
