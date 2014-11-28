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
import domain.AnesthesiaType;
import domain.PermissionsList;
import domain.User;



/**
 * Servlet implementation class CreateProtocolServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateProtocolServlet" })
public class CreateProtocolServlet extends HttpServlet {
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
    public CreateProtocolServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.paymentResponsible);		
		
		if(userE != null && perm ){
			
			try {				
				RequestDispatcher rd;
				
				//Obtener anesthesia type
				@SuppressWarnings("unchecked")
				ArrayList<AnesthesiaType> a = (ArrayList<AnesthesiaType>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAnesthesiaTypes());
				
				request.setAttribute("anesthesiaTypes", a);

				rd = getServletContext().getRequestDispatcher("/createProtocol.jsp");			
				rd.forward(request, response);
			}catch (Exception e) {
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
		
		doGet(request, response);
	}
}
