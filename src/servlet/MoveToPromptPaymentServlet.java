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
 * Servlet implementation class MoveToPromptPaymentServlet
 */
@WebServlet(description = "servlet to remove admission", urlPatterns = { "/MoveToPromptPaymentServlet" })
public class MoveToPromptPaymentServlet extends HttpServlet {
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
    public MoveToPromptPaymentServlet() {
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
				Long userID	 	 = Long.parseLong(request.getParameter("userId"));
				Long variableID	 = Long.parseLong(request.getParameter("variableId"));
				
				int result	 = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.MoveToPromptPayment(userID, variableID));
				if (result == 1)
					session.setAttribute("text", "La factura fue movida a pronto pago exitosamente.");
				else
					session.setAttribute("text","Hubo un problema al mover la factura a pronto pago. Por favor, intente más tarde");
				
				response.sendRedirect("./ListBillingsHServlet");
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
