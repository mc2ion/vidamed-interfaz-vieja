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
import domain.PermissionsList;
import domain.Protocol;
import domain.User;

/**
 * Servlet implementation class RemoveProtocolervlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/RemoveEstimationProtocolServlet" })
public class RemoveEstimationProtocolServlet extends HttpServlet {
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
    public RemoveEstimationProtocolServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm){
			try {
				String estimationId = request.getParameter("estimationId");
				String protocolId 	= request.getParameter("protocolId");
				
				int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveEstimationProtocol(estimationId, protocolId));
				
				String text_good = "El protocolo fue eliminado exitosamente";
				String text_bad = "Se ha presentado un error al eliminar el protocolo. Por favor, intente nuevamente.";
				if (result == 1) {
					request.setAttribute("info",text_good);
					CommandExecutor.getInstance().executeDatabaseCommand(new command.GenerateEstimationRates(estimationId));
				}
				else {
					request.setAttribute("info",text_bad);
				}
				
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> pt = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocols());
				request.setAttribute("pt", pt);
				request.setAttribute("spID", String.valueOf(estimationId));
				
				@SuppressWarnings("unchecked")
				ArrayList<Protocol> lp = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(estimationId));
				request.setAttribute("lp", lp);
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/editEstimationProtocol.jsp");			
				rd.forward(request, response);
	
			}
			catch (Exception e) {
				throw new ServletException(e);
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
}
