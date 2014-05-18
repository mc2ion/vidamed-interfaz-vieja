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
import domain.SupplyArea;
import domain.User;

/**
 * Servlet implementation class AddPatientSupplyServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AddPatientSupplyServlet" })
public class AddPatientSupplyServlet extends HttpServlet {
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
    public AddPatientSupplyServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		if(user != null){RequestDispatcher rd;
			try {
				String id = request.getParameter("id");
				//String servId = request.getParameter("servId");
				String name   = request.getParameter("name");
				
				//request.setAttribute("servId", servId);
				request.setAttribute("adminId", id);
				request.setAttribute("name", name);
				
				@SuppressWarnings("unchecked")
				ArrayList<SupplyArea> sArea = (ArrayList<SupplyArea>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyAreas());
			
				request.setAttribute("supplyArea", sArea);
				
				rd = getServletContext().getRequestDispatcher("/addPatientSupply.jsp");			
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
		HttpSession session = request.getSession(false);
		
		try{
			String admin = request.getParameter("admissionId");
			String name  = request.getParameter("name");
			String supply  = request.getParameter("state");
			String amount  = request.getParameter("amount");
			
			Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientSupply(Long.valueOf(admin), Long.valueOf(supply), amount));
			
			String text = "El servicio fue agregado exitosamente";
			if (result == 0)
				text =	"Hubo un problema al agregar al servicio. Por favor, intente nuevamente.";
			
			session.setAttribute("text", text);
			response.sendRedirect(request.getContextPath() + "/ListPatientSuppliesServlet?id=" + admin + "&name=" + name);
	
		}catch(Exception e){
			
			
		}
	}
}
