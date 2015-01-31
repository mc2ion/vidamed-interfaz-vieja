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
import domain.Admission;
import domain.Estimation;
import domain.User;



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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			try {
				Long userID = Long.parseLong(request.getParameter("userID"));
				String gastos = request.getParameter("gastos");
				
				if(gastos.equalsIgnoreCase("T")){
					int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.HospitalizePatient(userID));
					
					if (result == 1)
						session.setAttribute("info","El cliente fue hospitalizado exitosamente.");
					else
						session.setAttribute("info","Hubo un problema al hospitalizar al paciente. Por favor, intente nuevamente.");
					
					response.sendRedirect("./ListEmergenciesServlet");
				} else if (gastos.equalsIgnoreCase("F")){
					Admission a = (Admission) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmission(userID));
					CommandExecutor.getInstance().executeDatabaseCommand(new command.SetDischarge(userID, 1L));
					@SuppressWarnings("unchecked")
					ArrayList<Estimation> p = (ArrayList<Estimation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientEstimations(Long.valueOf(a.getPatientID())));
					System.out.println("patientID - "+a.getPatientID()+" - txtCedNumber - "+a.getIdentityCard()+" - txtName - "+a.getFirstName()+" - txtLastName - "+a.getLastName());
					request.setAttribute("estimations", p);
					request.setAttribute("patientID", String.valueOf(a.getPatientID()));
					request.setAttribute("txtCedNumber", a.getIdentityCard());
					request.setAttribute("txtName", a.getFirstName());
					request.setAttribute("txtLastName", a.getLastName());
					
					RequestDispatcher rd;			
					rd = getServletContext().getRequestDispatcher("/selectPatientEstimation.jsp");
					rd.forward(request, response);
				}
			}
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
	}
}
