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
 * Servlet implementation class ShowProtocolEstimationDetailServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ShowProtocolEstimationDetailServlet" })
public class ShowProtocolEstimationDetailServlet extends HttpServlet {
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
    public ShowProtocolEstimationDetailServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		if(userE != null && perm ){
			String protocolID = request.getParameter("protocolID");
			String estimationID = request.getParameter("estimationID");
			String fnc = request.getParameter("fnc");
			
			ArrayList<ProtocolScale> est;
			try {
				est = (ArrayList<ProtocolScale>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetFinalEstimationProtocolScale(estimationID, protocolID));
				request.setAttribute("est",est);
				
				ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
				request.setAttribute("bm", bm);
				
				RequestDispatcher rd;
				System.out.println(fnc.equalsIgnoreCase("emergency"));
				if(fnc != null && fnc.equalsIgnoreCase("emergency")){
					rd = getServletContext().getRequestDispatcher("/showProtocolEmergencyDetail.jsp");
					rd.forward(request, response);
				} if(fnc != null && fnc.equalsIgnoreCase("hospitalization")){
					rd = getServletContext().getRequestDispatcher("/showProtocolHospitalizationDetail.jsp");
					rd.forward(request, response);
				} else {
					rd = getServletContext().getRequestDispatcher("/showProtocolEstimationDetail.jsp");	
					rd.forward(request, response);
				}
				rd.forward(request, response);
				
			} catch (Exception e) {
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
		
		doGet(request, response);
	}
}
