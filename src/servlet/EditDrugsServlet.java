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
import domain.ProtocolSupplies;
import domain.Supply;
import domain.User;



/**
 * Servlet implementation class EditDrugsServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditDrugsServlet" })
public class EditDrugsServlet extends HttpServlet {
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
    public EditDrugsServlet() {
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
			
			System.out.println(protocolID + " "+ scaleID);
			
			@SuppressWarnings("unchecked")
			ArrayList<ProtocolSupplies> sps = (ArrayList<ProtocolSupplies>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetProtocolSupplies(protocolID, scaleID));
			request.setAttribute("sps", sps);
			
			@SuppressWarnings("unchecked")
			ArrayList<Supply> sp = (ArrayList<Supply>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAllSuplies());
			request.setAttribute("sp", sp);
			
			rd = getServletContext().getRequestDispatcher("/editDrugs.jsp");			
			rd.forward(request, response);
			}catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
		} else {
			request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
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
		
		try{
			if (deleted != null){
				for (int i = 0; i < deleted.length; i++){
					// Borrar elementos
					CommandExecutor.getInstance().executeDatabaseCommand(new command.RemoveProtocolSupply(protocolID, scaleID, deleted[i]));
				}
			}
			
			for (int i = 1 ; i <= Integer.valueOf(count) ; i++){
				String select = request.getParameter("supply" + i + "-old");
				String amount = request.getParameter("amount" + i + "-old");
					if (select != null){
						Long id = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditProtocolSupply(amount, protocolID, scaleID, select));
						System.out.println(id + " " );	
					}else{
						select = request.getParameter("supply" + i );
						amount = request.getParameter("amount" + i );
						Long id = (Long) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddProtocolSupply(amount, protocolID, scaleID, select));
						System.out.println(id + " " );	
					}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/CreateMicroProtocolServlet?id=" + protocolID);
	}
}