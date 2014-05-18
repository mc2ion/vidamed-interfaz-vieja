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
 * Servlet implementation class ApplyDiscountServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ApplyDiscountServlet" })
public class ApplyDiscountServlet extends HttpServlet {
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
    public ApplyDiscountServlet() {
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
		User user = (User)session.getAttribute("user");
		if(user != null){
			try {
				Long 	id 				= Long.valueOf(request.getParameter("userId"));
				String 	type 			= request.getParameter("type");
				String 	amount 			= request.getParameter("amount");
				String 	justification 	= request.getParameter("justification");
				
				System.out.println(" " + id + " " + type + " " + amount + " " + justification);
				
				int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.ApplyDiscount(id, type, amount, justification));
				if (result == 1)
					session.setAttribute("info", "El descuento fue aceptado exitosamente!.");
				else
					session.setAttribute("info", "Hubo un error al aceptar el descuento. Por favor, intente nuevamente.");
	
				response.sendRedirect(request.getContextPath() + "/ListCreditNotesReviewServlet");
				
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		}
		else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
	}
}
