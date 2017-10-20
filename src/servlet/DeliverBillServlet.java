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
 * Servlet implementation class DeliverBillServlet
 */
@WebServlet(description = "servlet to deliver bill", urlPatterns = { "/DeliverBillServlet" })
public class DeliverBillServlet extends HttpServlet {

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
    public DeliverBillServlet() {
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
				Long userID	 = Long.parseLong(request.getParameter("userId"));
				Integer hasMultiple = Integer.parseInt(request.getParameter("hasMultiple"));
				Integer mainResponsible = Integer.parseInt(request.getParameter("mainResponsible"));
				Long admissionID = Long.parseLong(request.getParameter("admissionId"));
				Long paymentResponsibleID = Long.parseLong(request.getParameter("paymentResponsibleId"));
				String date = request.getParameter("date");
				int result	 = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.SendBill(userID, date, hasMultiple, mainResponsible, admissionID, paymentResponsibleID));
				if (result == 1)
					session.setAttribute("text", "Se registró el envío exitosamente.");
				else
					session.setAttribute("text","Hubo un problema el registrar el envío. Por favor, intente más tarde");
				
				response.sendRedirect("./ListAccountsServlet");
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
