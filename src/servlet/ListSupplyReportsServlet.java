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
import domain.Supply;
import domain.SupplyArea;
import domain.SupplyForm;
import domain.User;


/**
 * Servlet implementation class ListSupplyReportsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListSupplyReportsServlet" })
public class ListSupplyReportsServlet extends HttpServlet {
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
    public ListSupplyReportsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		if(userE != null && perm ){
			try {
				@SuppressWarnings("unchecked")
				ArrayList<Supply> pp = (ArrayList<Supply>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyReport());
				
				@SuppressWarnings("unchecked")
				ArrayList<SupplyForm> u = (ArrayList<SupplyForm>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyForms());

				@SuppressWarnings("unchecked")
				ArrayList<SupplyArea> a = (ArrayList<SupplyArea>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyAreas());

				
				request.setAttribute("pp", pp);
				request.setAttribute("u", u);
				request.setAttribute("a", a);
				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_supply.jsp");
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
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		
		if(userE != null && perm ){
    		String sForm 	  = request.getParameter("supplyForm");
    		String supplyF = null;
    		if (!sForm.equals("-"))
				supplyF = sForm;
    		String sArea 	  = request.getParameter("supplyArea");
    		String supplyArea = null;
    		if (!sArea.equals("-"))
				supplyArea = sArea;
    		
    		String name  	  = request.getParameter("name");
			String type     = request.getParameter("type");
			String typeId   = null;
			if (!type.equals("-"))
					typeId = type;
			String activeC   = request.getParameter("activeC");
			String manufacture 	  	  = request.getParameter("manufacture");
			String senior 	  	  = request.getParameter("senior");
			String minior 	  	  = request.getParameter("minior");
			
			String regulated     = request.getParameter("isRegulated");
			String isRegulated   = null;
			if (!regulated.equals("-"))
					isRegulated = regulated;
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<Supply> pp = (ArrayList<Supply>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyReport(supplyF, supplyArea, name, typeId, activeC, manufacture, minior, senior, isRegulated));
				
				@SuppressWarnings("unchecked")
				ArrayList<SupplyForm> u = (ArrayList<SupplyForm>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyForms());

				@SuppressWarnings("unchecked")
				ArrayList<SupplyArea> a = (ArrayList<SupplyArea>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSupplyAreas());

				
				request.setAttribute("pp", pp);
				request.setAttribute("u", u);
				request.setAttribute("a", a);
				
				request.setAttribute("supplyF", supplyF);
				request.setAttribute("supplyArea", supplyArea);
				request.setAttribute("name", name);
				request.setAttribute("type", typeId);
				request.setAttribute("activeC", activeC );
				request.setAttribute("manufacture", manufacture);
				request.setAttribute("senior", senior);
				request.setAttribute("minior", minior);
				request.setAttribute("isRegulated", isRegulated);
				
				
				
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_supply.jsp");
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
