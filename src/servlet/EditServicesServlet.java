package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.ProtocolService;
import domain.Supply;
import domain.User;



/**
 * Servlet implementation class EditServicesServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditServicesServlet" })
public class EditServicesServlet extends HttpServlet {
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
    public EditServicesServlet() {
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
			String protocolID = (String) request.getParameter("protocolID");
			String scaleID = (String) request.getParameter("id");
			Long serviceTypeID = Long.valueOf(request.getParameter("serviceTypeID"));
			
			System.out.println(protocolID + " "+ scaleID);
			
			@SuppressWarnings("unchecked")
			ArrayList<ProtocolService> sps = (ArrayList<ProtocolService>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocolServices(protocolID, scaleID, serviceTypeID));
			request.setAttribute("sps", sps);
			
			@SuppressWarnings("unchecked")
			ArrayList<Supply> sp = (ArrayList<Supply>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetServicesByType(serviceTypeID));
			request.setAttribute("sp", sp);
			
			rd = getServletContext().getRequestDispatcher("/editServices.jsp");			
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
		String[] deleted = (String[]) request.getParameterValues("deleted");
		String actives = (String) request.getParameter("actives");
		
		List<String> actStr = Arrays.asList(actives.split(","));
		try{
			if (deleted != null){
				for (int i = 0; i < deleted.length; i++){
					// Borrar elementos
					CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveProtocolService(protocolID, scaleID, deleted[i]));
				}
			}
			
			for (int i = 1 ; i <= Integer.valueOf(count) ; i++){
				String index = actStr.get(i-1);
				String select = request.getParameter("supply" + index + "-old");
				String amount = request.getParameter("amount" + index + "-old");
				//System.out.println(select + " " + amount );	
					if (select != null){
						Long id = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditProtocolService(amount, protocolID, scaleID, select));
						System.out.println(id + " " );	
					}else{ 
						System.out.println(index);	
						select = request.getParameter("supply" + index );
						amount = request.getParameter("amount" + index );
						System.out.println(select + " " + amount );	
				
						Long id = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddProtocolService(amount, protocolID, scaleID, select));
						System.out.println(id + " " );	
					}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/CreateMicroProtocolServlet?id=" + protocolID);
	}
}
