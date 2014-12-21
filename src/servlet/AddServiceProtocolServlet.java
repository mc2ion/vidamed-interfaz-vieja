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
import domain.BussinessMicro;
import domain.PermissionsList;
import domain.ProtocolScale;
import domain.User;

/**
 * Servlet implementation class AddServiceProtocolServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AddServiceProtocolServlet" })
public class AddServiceProtocolServlet extends HttpServlet {
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
    public AddServiceProtocolServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.protocols);
		if(userE != null && perm ){
			RequestDispatcher rd;
			try {
				String id = request.getParameter("id");
				
				//request.setAttribute("servId", servId);
				request.setAttribute("protocolId", id);
				
				@SuppressWarnings("unchecked")
				ArrayList<ProtocolScale> pp = (ArrayList<ProtocolScale>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocolScale(id));
				request.setAttribute("ps", pp);
				
				@SuppressWarnings("unchecked")
				ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
				request.setAttribute("bm", bm);
				
				//System.out.println("a");
				rd = getServletContext().getRequestDispatcher("/addServiceProtocol.jsp");			
				rd.forward(request, response);
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.protocols);
		if(userE != null && perm ){
			try{
				String protocolID = request.getParameter("protocolID");
				
				//Remove all services
				CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveProtocolMandatoryScale(protocolID));
				
				
				//Then add them
				String[] services = request.getParameterValues("my-select[]");
				if (services != null){
					for (int i = 0; i< services.length; i++) {
						CommandExecutor.getInstance().executeDatabaseCommand(new command.AddProtocolMandatoryScale(protocolID, services[i]));
					}
				}
				response.sendRedirect(request.getContextPath() + "/CreateMicroProtocolServlet?id="+ protocolID);
			}catch(Exception e){
			}
		}else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}	
	}
}
