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
 * Servlet implementation class ForwardCreditNoteServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ForwardCreditNoteServlet" })
public class ForwardCreditNoteServlet extends HttpServlet {
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
    public ForwardCreditNoteServlet() {
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
			Long 	id 				= Long.valueOf(request.getParameter("userId"));
		
			int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.ForwardCreditNote(id));
			if (result == 1)
				session.setAttribute("info", "La prefactura fue reenviada exitosamente!.");
			else
				session.setAttribute("info", "Hubo un error al reenviar la prefactura. Por favor, intente nuevamente.");

			response.sendRedirect(request.getContextPath() + "/ListCreditNotesReviewServlet");
			
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
