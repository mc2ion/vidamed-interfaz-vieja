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
import domain.MedicalAdviceType;
import domain.PermissionsList;
import domain.User;

/**
 * Servlet implementation class AddPatientAdditionalServiceServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AddPatientAdditionalServiceServlet" })
public class AddPatientAdditionalServiceServlet extends HttpServlet {
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
    public AddPatientAdditionalServiceServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd;
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.additionalServices);
		if(userE != null && perm ){
			try {
				String id = request.getParameter("id");
				String name   = request.getParameter("name");
				
				request.setAttribute("adminId", id);
				request.setAttribute("name", name);
				
				@SuppressWarnings("unchecked")
				ArrayList<MedicalAdviceType> services = (ArrayList<MedicalAdviceType>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdditionalServices());
			
				request.setAttribute("services", services);
				
				rd = getServletContext().getRequestDispatcher("/addPatientAdditionalService.jsp");			
				rd.forward(request, response);
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.additionalServices);
		RequestDispatcher rd;
		if(userE != null && perm ){
			try{
				String admin 		= request.getParameter("admissionId");
				String name 		= request.getParameter("name");
				String serviceId		= request.getParameter("serviceId");
				String amount 		= request.getParameter("amount");
				
				Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientAdditionalService(Long.valueOf(admin), Long.valueOf(serviceId), amount));
				
				String text = "El servicio fue agregado exitosamente";
				if (result == 0)
					text =	"Hubo un problema al agregar el servicio. Por favor, intente nuevamente.";
				
				session.setAttribute("text", text);
				response.sendRedirect(request.getContextPath() + "/ListAdditionalServicesByAdmissionServlet?id=" + admin + "&name=" + name);
		
			}catch(Exception e){}
	
			}else {
				if (userE == null){
					request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); rd = getServletContext().getRequestDispatcher("/index.jsp");
					rd.forward(request, response);
				}else{
					rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
					rd.forward(request, response);
				}
			}
	}
}

