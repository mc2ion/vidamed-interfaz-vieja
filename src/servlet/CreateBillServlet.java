package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;



/**
 * Servlet implementation class CreateBillServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateBillServlet" })
public class CreateBillServlet extends HttpServlet {
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
    public CreateBillServlet() {
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
		try {
			Long 	id 				= Long.valueOf(request.getParameter("userId"));
			Long 	userId 			= Long.valueOf(request.getParameter("userReviewId"));
			
			HttpSession session = request.getSession(false);
			
			int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.CreateBill(id, userId));
			if (result == 1)
				session.setAttribute("info", "La factura fue generada exitosamente!.");
			else
				session.setAttribute("info", "Hubo un error al generar la factura. Por favor, intente nuevamente.");

			response.sendRedirect(request.getContextPath() + "/ListCreditNotesReviewServlet");
			
		} 
		catch (Exception e) {
			throw new ServletException(e);
		}
	}
}