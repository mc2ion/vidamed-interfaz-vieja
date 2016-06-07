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
import domain.Service;
import domain.User;



/**
 * Servlet implementation class AddServicesServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AddServicesServlet" })
public class AddServicesServlet extends HttpServlet {
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
    public AddServicesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		if(user != null){
			try{
			RequestDispatcher rd;
			// Obtener nombre del protocolScaleId
			//String id = (String) request.getParameter("id");
			Long serviceTypeID = Long.valueOf(request.getParameter("serviceTypeID"));
			
			@SuppressWarnings("unchecked")
			ArrayList<Service> sp = (ArrayList<Service>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetServicesByType(serviceTypeID));
			request.setAttribute("sp", sp);
			
			rd = getServletContext().getRequestDispatcher("/addServices.jsp");			
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
		String protocolID = (String) request.getParameter("protocolID");
		String scaleID = (String) request.getParameter("scaleID");
		String count = (String) request.getParameter("count");
		for (int i = 1 ; i <= Integer.valueOf(count) ; i++){
				String select = request.getParameter("supply" + i);
				String amount = request.getParameter("amount" + i);
				try{
					Long id = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddProtocolService(amount, protocolID, scaleID, select));
					System.out.println(id + " " );	
				}catch(Exception e) {
					e.printStackTrace();
				}
		}
		response.sendRedirect(request.getContextPath() + "/CreateMicroProtocolServlet?id=" + protocolID);
	}
}
