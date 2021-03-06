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
import domain.PatientMedicalAdvice;
import domain.PermissionsList;
import domain.Specialist;
import domain.Unit;
import domain.User;
/**
 * Servlet implementation class EditPatientMedicalAdviceServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditPatientMedicalAdviceServlet" })
public class EditPatientMedicalAdviceServlet extends HttpServlet {
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
    public EditPatientMedicalAdviceServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.interc);
		if(userE != null && perm ){
			RequestDispatcher rd;
			try {
				String id				= request.getParameter("id");
				String name   			= request.getParameter("name");
				String medicalAdviceId	= request.getParameter("pmId");
				
				request.setAttribute("adminId", id);
				request.setAttribute("name", name);
				
				PatientMedicalAdvice pm = (PatientMedicalAdvice) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientMedicalAdvice(Long.valueOf(medicalAdviceId)));
			
				@SuppressWarnings("unchecked")
				ArrayList<Unit> units = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				
				@SuppressWarnings("unchecked")
				ArrayList<MedicalAdviceType> types = (ArrayList<MedicalAdviceType>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetMedicalAdviceTypes());
			
				request.setAttribute("units", units);
				request.setAttribute("types", types);
				request.setAttribute("pm", pm);
				
				//Get spacialist by unitId
				@SuppressWarnings("unchecked")
				ArrayList<Specialist> specialists = (ArrayList<Specialist>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSpecialistsByUnit(pm.getUnitID()));
				request.setAttribute("specialists", specialists);
				
				rd = getServletContext().getRequestDispatcher("/editPatientAdvice.jsp");			
				rd.forward(request, response);
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.interc);
		if(userE != null && perm ){
			
			try{
				String admin = request.getParameter("admissionId");
				String name  = request.getParameter("name");
				String pmId  = request.getParameter("pmId");
				
				String typeId		= request.getParameter("typeId");
				String unitId		= request.getParameter("unitId");
				String specialist   = request.getParameter("state");
				String amount 		= request.getParameter("amount");
				
				Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPatientMedicalAdvice(Long.valueOf(unitId), Long.valueOf(specialist), amount, Long.valueOf(pmId), Integer.valueOf(typeId)));
				
				String text = "El servicio fue editado exitosamente";
				if (result == 0)
					text =	"Hubo un problema al editar el servicio. Por favor, intente nuevamente.";
				
				session.setAttribute("text", text);
				response.sendRedirect(request.getContextPath() + "/ListPatientMedicalAdvicesByAdmissionServlet?id=" + admin + "&name=" + name);
		
			}catch(Exception e){
				System.out.println("error" + e.getMessage());
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
}
