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
import domain.AnesthesiaType;
import domain.PermissionsList;
import domain.Protocol;
import domain.Unit;
import domain.User;



/**
 * Servlet implementation class EditProtocolServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditProtocolServlet" })
public class EditProtocolServlet extends HttpServlet {
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
    public EditProtocolServlet() {
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
			String id = request.getParameter("id");
			try {				
				RequestDispatcher rd;
				
				//Obtener anesthesia type
				@SuppressWarnings("unchecked")
				ArrayList<AnesthesiaType> a = (ArrayList<AnesthesiaType>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAnesthesiaTypes());
				@SuppressWarnings("unchecked")
				ArrayList<Unit> u = (ArrayList<Unit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				
				Protocol p = (Protocol) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocol(id));
				
				request.setAttribute("anesthesiaTypes", a);
				request.setAttribute("units", u);
				request.setAttribute("protocol", p);

				rd = getServletContext().getRequestDispatcher("/editProtocol.jsp");			
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
		String[] inputs = {"txtName", "txtDescription", "txtSimilar", "typeOfProtocol", "gender", "txtORHours", "txtDays", "anesthesia", "unit"};
		String[] params = new String[9];
		
		for(int i=0; i< inputs.length; i++ ){
			params[i] = (String) request.getParameter(inputs[i]);
		}
		
		String protocolID = request.getParameter("protocolID");
		String type = request.getParameter("type");
		System.out.println(protocolID);
		Long newProtocol = null;
		try {
			String text_good = "";
			if (type != null && type.equals("d")){
				newProtocol = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddProtocol(params[0], params[1], params[3],
						params[4], params[5], params[6], params[7], params[8]));
				//Duplicates supplies and services
				CommandExecutor.getInstance().executeDatabaseCommand(new command.DuplicateProtocolMandatoryScale(protocolID, newProtocol));
				CommandExecutor.getInstance().executeDatabaseCommand(new command.DuplicateProtocolSupplies(protocolID, newProtocol));
				protocolID = String.valueOf(newProtocol);
				
			}else{
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditProtocol(params[0], params[1], params[3],
						params[4], params[5], params[6], params[7], protocolID, params[8]));
			}
			System.out.println(newProtocol);
			
			if (protocolID == null) {
				text_good += " Se ha presentado un error al editar el protocolo. Por favor, intente nuevamente.";
				session.setAttribute("info",text_good);
				response.sendRedirect(request.getContextPath() + "/CreateProtocolServlet");
				return;
			}else{
				response.sendRedirect(request.getContextPath() + "/CreateMicroProtocolServlet?id=" + protocolID);
				return;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}


