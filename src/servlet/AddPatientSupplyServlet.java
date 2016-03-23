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
import domain.ProtocolScale;
import domain.Supply;
import domain.SupplyArea;
import domain.SupplyInventory;
import domain.User;

/**
 * Servlet implementation class AddPatientSupplyServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/AddPatientSupplyServlet" })
public class AddPatientSupplyServlet extends HttpServlet {
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
    public AddPatientSupplyServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.pharmacyPatients);
		if(userE != null && perm ){
			RequestDispatcher rd;
			try {
				String id = request.getParameter("id");
				String sec = request.getParameter("sec");
				//String servId = request.getParameter("servId");
				String name   = request.getParameter("name");
				
				//request.setAttribute("servId", servId);
				request.setAttribute("adminId", id);
				request.setAttribute("name", name);
				
				if(sec != null && sec.equalsIgnoreCase("add")){
					Long scaleId = Long.valueOf(request.getParameter("scaleId"));
					Long amount = Long.valueOf(request.getParameter("amount"));
					Long supplyId = Long.valueOf(request.getParameter("spId"));
					Supply supply = (Supply) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupply(supplyId));
					@SuppressWarnings("unchecked")
					ArrayList<SupplyInventory> supplyInventories = (ArrayList<SupplyInventory>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyInventories(supplyId));
				
					request.setAttribute("scaleId", scaleId);
					request.setAttribute("supply", supply);
					request.setAttribute("amount", amount);
					request.setAttribute("supplyInventories", supplyInventories);
				}else if(sec != null && sec.equalsIgnoreCase("replace")){
					Long scaleId = Long.valueOf(request.getParameter("scaleId"));
					Long amount = Long.valueOf(request.getParameter("amount"));
					Long supplyId = Long.valueOf(request.getParameter("spId"));
					Supply supply = (Supply) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupply(supplyId));
					@SuppressWarnings("unchecked")
					ArrayList<SupplyArea> sArea = (ArrayList<SupplyArea>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyAreas());
				
					request.setAttribute("scaleId", scaleId);
					request.setAttribute("supply", supply);
					request.setAttribute("amount", amount);
					request.setAttribute("supplyArea", sArea);
				}else{
					@SuppressWarnings("unchecked")
					ArrayList<SupplyArea> sArea = (ArrayList<SupplyArea>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyAreas());
					@SuppressWarnings("unchecked")
					ArrayList<ProtocolScale> pScale = (ArrayList<ProtocolScale>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyProtocolScales());
				
					request.setAttribute("supplyArea", sArea);
					request.setAttribute("protocolScale", pScale);
				}
								
				request.setAttribute("sec", sec);
				
				rd = getServletContext().getRequestDispatcher("/addPatientSupply.jsp");			
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
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.pharmacyPatients);
		if(userE != null && perm ){
			try{
				String admin = request.getParameter("admissionId");
				String name  = request.getParameter("name");
				String supplyInventory = request.getParameter("inventory");
				String amount  = request.getParameter("amount");
				String sec = request.getParameter("sec");
				Long scaleId = Long.valueOf(request.getParameter("scaleId"));
				Integer result = 0;
				
				if(sec!=null && sec.equalsIgnoreCase("add")){
					Long supplyId = Long.valueOf(request.getParameter("supplyId"));
					CommandExecutor.getInstance().executeDatabaseCommand(new command.ApplyPatientEstimationSupply(Long.valueOf(admin), scaleId, supplyId, Long.valueOf(amount)));
					result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientSupply(Long.valueOf(admin), Long.valueOf(supplyInventory), amount, scaleId));
				}else if(sec!=null && sec.equalsIgnoreCase("replace")){
					Long supplyId = Long.valueOf(request.getParameter("supplyId"));
					String amountReplaced = request.getParameter("amountReplaced");
					CommandExecutor.getInstance().executeDatabaseCommand(new command.ApplyPatientEstimationSupply(Long.valueOf(admin), scaleId, supplyId, Long.valueOf(amount)));
					result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientSupply(Long.valueOf(admin), Long.valueOf(supplyInventory), amountReplaced, scaleId));
				}else{
					result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.AddPatientSupply(Long.valueOf(admin), Long.valueOf(supplyInventory), amount, scaleId));				
				}
				
				String text = "El suministro fue agregado exitosamente";
				if (result == 0)
					text =	"Hubo un problema al agregar el suministro. Por favor, intente nuevamente.";
				
				session.setAttribute("text", text);
				
				if(sec != null && sec.equalsIgnoreCase("d")){
					response.sendRedirect(request.getContextPath() + "/ListPatientSuppliesServlet?id=" + admin + "&name=" + name + "&sec=" + sec);
				}else if(sec != null && (sec.equalsIgnoreCase("add") || sec.equalsIgnoreCase("replace"))){
					response.sendRedirect(request.getContextPath() + "/ListPatientEstimationSuppliesServlet?id=" + admin + "&name=" + name);
				}else {					
					response.sendRedirect(request.getContextPath() + "/ListPatientSuppliesServlet?id=" + admin + "&name=" + name);
				}
		
			}catch(Exception e){
				e.printStackTrace();				
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
