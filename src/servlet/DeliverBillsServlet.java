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
 * Servlet implementation class DeliverBillsServlet
 */
@WebServlet(description = "servlet to deliver bills", urlPatterns = { "/DeliverBillsServlet" })
public class DeliverBillsServlet extends HttpServlet {
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
    public DeliverBillsServlet() {
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
				int error = 0;
				String[] values = request.getParameterValues("sendFact");
				String date = request.getParameter("date");
				
				for (int i = 0; i < values.length; i++){
					System.out.println(values[i]);
					String[] val = values[i].split("_");
					Long userID	 = Long.parseLong(val[0]);
					Integer hasMultiple = Integer.parseInt(val[1]);
					Integer mainResponsible = Integer.parseInt(val[2]);
					Long admissionID = Long.parseLong(val[3]);
					Long paymentResponsibleID = Long.parseLong(val[4]);
					int result	 = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.SendBill(userID, date, hasMultiple, mainResponsible, admissionID, paymentResponsibleID));
					
					if (result != 1)  error = 1;
				}
				if (error == 0){
					session.setAttribute("info", "Se registraron los envíos exitosamente.");
				} else {
					session.setAttribute("info","Hubo un problema el registrar uno de los envíos. Por favor, intente más tarde");
				}
				
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
