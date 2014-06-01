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
import domain.User;
import domain.UserReport;
import domain.UserUnit;


/**
 * Servlet implementation class ListInterServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListUserReportsServlet" })
public class ListUserReportsServlet extends HttpServlet {
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
    public ListUserReportsServlet() {
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
				ArrayList<UserReport> pp = (ArrayList<UserReport>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserReport());
				request.setAttribute("pp", pp);
				
				@SuppressWarnings("unchecked")
				ArrayList<UserUnit> a = (ArrayList<UserUnit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserUnitsAux());
				request.setAttribute("a", a);
				
			
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_user.jsp");
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
    		String dateIni 	  = request.getParameter("txtDateIni");
			String dateEnd 	  = request.getParameter("txtDateEnd");
			String name  	  = request.getParameter("userName");
			String u     = request.getParameter("unitId");
			String unitId 	=  null;
			if (!u.equals("-"))
				unitId = u;
			
			String identityCard   = request.getParameter("identityCard");
			String g 	  	  = request.getParameter("gender");
			String gender = null;
			if (!g.equals("-"))
				gender = g;
			
			System.out.println(gender);
			
			
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<UserReport> pp = (ArrayList<UserReport>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserReport(dateIni, dateEnd, name, identityCard, gender, unitId));
				request.setAttribute("pp", pp);
				
				@SuppressWarnings("unchecked")
				ArrayList<UserUnit> a = (ArrayList<UserUnit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserUnitsAux());
				request.setAttribute("a", a);
				
				
				RequestDispatcher rd;			
				request.setAttribute("dateIni", dateIni);
				request.setAttribute("dateEnd", dateEnd);
				request.setAttribute("name", name);
				request.setAttribute("identityCard", identityCard);
				request.setAttribute("unitId", unitId);
				request.setAttribute("gender", gender);
				
				rd = getServletContext().getRequestDispatcher("/reports_user.jsp");
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
