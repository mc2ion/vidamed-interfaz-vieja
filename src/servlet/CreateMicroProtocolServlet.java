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
 * Servlet implementation class CreateMicroProtocolServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateMicroProtocolServlet" })
public class CreateMicroProtocolServlet extends HttpServlet {
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
    public CreateMicroProtocolServlet() {
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
			try {	
				String  id =  request.getParameter("id");
				
				//Get protocol 
				@SuppressWarnings("unchecked")
				ArrayList<ProtocolScale> pp = (ArrayList<ProtocolScale>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocolScale(id));
				request.setAttribute("ps", pp);
				
				@SuppressWarnings("unchecked")
				ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
				request.setAttribute("bm", bm);
				
				RequestDispatcher rd;			
				rd = getServletContext().getRequestDispatcher("/createMicros_Protocol.jsp");
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
		HttpSession session = request.getSession();
		String[] inputs = {"txtName", "txtDescription", "txtSimilar", "typeOfProtocol", "gender", "txtORHours", "txtDays", "anesthesia"};
		String[] params = new String[8];
		
		for(int i=0; i< inputs.length; i++ ){
			params[i] = (String) request.getParameter(inputs[i]);
		}
		
		Long protocolID;
		try {
			protocolID = (Long)CommandExecutor.getInstance().executeDatabaseCommand(new command.AddProtocol(params[0], params[1], params[3],
					params[4], params[5], params[6], params[7]));
			String text_good = "";
			if (protocolID == null) {
				text_good += " Se ha presentado un error al asociar uno o más números telefónicos al usuario. Por favor, intente nuevamente.";
				session.setAttribute("info",text_good);
				response.sendRedirect(request.getContextPath() + "/CreateProtocolServlet");
			}else
				response.sendRedirect(request.getContextPath() + "/CreateMicroProtocolServlet");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		doGet(request, response);
	}
}
