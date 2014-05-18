package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.Unit;
import domain.User;



/**
 * Servlet implementation class SearchDoctorServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/SearchDoctorServlet" })
public class SearchDoctorServlet extends HttpServlet {
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
    public SearchDoctorServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			RequestDispatcher rd;
			String function 	= request.getParameter("function");
			String admissionId 	= request.getParameter("id");
			String doctorName	= request.getParameter("dN");
			
			try {
				@SuppressWarnings("unchecked")
				ArrayList<Unit> lList = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				
				request.setAttribute("units", lList);
				request.setAttribute("admissionId", admissionId);
				request.setAttribute("docName", doctorName);
				request.setAttribute("function", function);
				rd = getServletContext().getRequestDispatcher("/searchDoctor.jsp");	
				rd.forward(request, response);
			} catch (Exception e) {
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
		if(userE != null){
			Long specId 	 	 = Long.valueOf(request.getParameter("state"));
			Long admissionId 	 = Long.valueOf(request.getParameter("adminId"));
			Long unitId 	 	 = Long.valueOf(request.getParameter("unitId"));
			String function 	 = request.getParameter("function");
			System.out.println("function" + function);
			
			Integer result;
			try {
				result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditEstimationSpecialist(admissionId, specId, unitId));
				
				String text = "El especialista de paciente fue actualizado exitosamente.";
				if (result == 0)
					text =	"Hubo un problema al actualizar el especialista del paciente. Por favor, intente nuevamente.";
				
				session.setAttribute("text", text);
				
				if (function != null){
					if (function.equals("editMedicalTreatment"))
						response.sendRedirect(request.getContextPath() + "/EditMedicalTreatmentServlet?id=" + admissionId);
					else if (function.equals("editEmergency"))
						response.sendRedirect(request.getContextPath() + "/EditEmergencyServlet?id=" + admissionId);
					else if (function.equals("editHospitalization"))
						response.sendRedirect(request.getContextPath() + "/EditHospitalizationServlet?id=" + admissionId);
						
				}
			} catch (NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}		
		
	}
}
