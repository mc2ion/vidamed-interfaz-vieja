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
import domain.PatientSupply;
/**
 * Servlet implementation class EditPatientSupplyServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditPatientSupplyServlet" })
public class EditPatientSupplyServlet extends HttpServlet {
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
    public EditPatientSupplyServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher rd;
		try {
			String id				= request.getParameter("id");
			String name   			= request.getParameter("name");
			String supplyPatientId	= request.getParameter("spId");
			
			request.setAttribute("adminId", id);
			request.setAttribute("name", name);
			
			PatientSupply pSupply = (PatientSupply) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPatientSupply(Long.valueOf(supplyPatientId)));
		
			request.setAttribute("pSupply", pSupply);
			rd = getServletContext().getRequestDispatcher("/editPatientSupply.jsp");			
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
			String admin = request.getParameter("admissionId");
			String name  = request.getParameter("name");
			String spId  = request.getParameter("spId");
			String amount  = request.getParameter("amount");
			System.out.println("a" + admin + name + spId + amount);
			
			Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPatientSupply(Long.valueOf(spId), amount));
			
			String text = "El suministro fue editado exitosamente";
			if (result == 0)
				text =	"Hubo un problema al editar el suministro. Por favor, intente nuevamente.";
			
			session.setAttribute("text", text);
			response.sendRedirect(request.getContextPath() + "/ListPatientSuppliesServlet?id=" + admin + "&name=" + name);
	
		}catch(Exception e){
			System.out.println("error" + e.getMessage());
		}
	}
}
