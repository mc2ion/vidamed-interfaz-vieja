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
import domain.Unit;

/**
 * Servlet implementation class AddPatientMedicalAdviceServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AddPatientMedicalAdviceServlet" })
public class AddPatientMedicalAdviceServlet extends HttpServlet {
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
    public AddPatientMedicalAdviceServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd;
		try {
			String id = request.getParameter("id");
			String name   = request.getParameter("name");
			
			request.setAttribute("adminId", id);
			request.setAttribute("name", name);
			
			@SuppressWarnings("unchecked")
			ArrayList<Unit> units = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
		
			request.setAttribute("units", units);
			
			rd = getServletContext().getRequestDispatcher("/addPatientAdvice.jsp");			
			rd.forward(request, response);
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		try{
			String admin 		= request.getParameter("admissionId");
			String name 		= request.getParameter("name");
			String unitId		= request.getParameter("unitId");
			String specialist   = request.getParameter("state");
			String amount 		= request.getParameter("amount");
			
			Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientMedicalAdvice(Long.valueOf(admin), Long.valueOf(unitId), Long.valueOf(specialist), amount));
			
			String text = "La consulta fue agregada exitosamente";
			if (result == 0)
				text =	"Hubo un problema al agregar la consulta. Por favor, intente nuevamente.";
			
			session.setAttribute("text", text);
			response.sendRedirect(request.getContextPath() + "/ListPatientMedicalAdvicesByAdmissionServlet?id=" + admin + "&name=" + name);
	
		}catch(Exception e){
			
			
		}
		
	}
}
