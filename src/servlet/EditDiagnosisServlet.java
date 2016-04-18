package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;

import domain.User;

/**
 * Servlet implementation class EditDiagnosisServlet
 */
@WebServlet(description = "servlet to edit a protocol diagnosis", urlPatterns = { "/EditDiagnosisServlet" })
public class EditDiagnosisServlet extends HttpServlet {

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
    public EditDiagnosisServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			try {
				Long estimationId = Long.parseLong(request.getParameter("eId"));
				Long protocolId = Long.parseLong(request.getParameter("pId"));
				Long emergencyId = Long.parseLong(request.getParameter("aId"));
				String diagnosis = request.getParameter("diagnosis");
				Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditDiagnosis(estimationId, protocolId, diagnosis));
				String text = "El diagnóstico del protocolo fue editado exitosamente.";
				if (result == 0)
					text =	"Hubo un problema al actualizar el diagnóstico del protocolo. Por favor, intente nuevamente.";
				
				session.setAttribute("info", text);
				response.sendRedirect(request.getContextPath() + "/EditEmergencyServlet?id="+emergencyId+"&ac=ep");
				
			}
			catch (Exception e) {
				throw new ServletException(e);
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
		
		doGet(request, response);
	}
}
