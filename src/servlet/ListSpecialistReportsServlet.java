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

import sun.management.counter.Units;
import command.CommandExecutor;
import domain.PermissionsList;
import domain.Specialist;
import domain.User;


/**
 * Servlet implementation class ListSpecialistReportsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListSpecialistReportsServlet" })
public class ListSpecialistReportsServlet extends HttpServlet {
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
    public ListSpecialistReportsServlet() {
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
				ArrayList<Specialist> pp = (ArrayList<Specialist>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSpecialistReport());
				@SuppressWarnings("unchecked")
				ArrayList<Units> u = (ArrayList<Units>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				
				request.setAttribute("pp", pp);
				request.setAttribute("u", u);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_specialist.jsp");
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
    		String rif 	  = request.getParameter("rif");
			String lastname 	  = request.getParameter("eLastname");
			String name  	  = request.getParameter("eName");
			String unit     = request.getParameter("unit");
			String unitId   = null;
			if (!unit.equals("-"))
					unitId = unit;
			String identityCard   = request.getParameter("identityCard");
			String g 	  	  = request.getParameter("gender");
			String gender = null;
			if (!g.equals("-"))
				gender = g;
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<Specialist> pp = (ArrayList<Specialist>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSpecialistReport(name, lastname, gender, identityCard, rif, unitId));
				request.setAttribute("pp", pp);
				
				@SuppressWarnings("unchecked")
				ArrayList<Units> u = (ArrayList<Units>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnits());
				request.setAttribute("u", u);
				
				RequestDispatcher rd;			
				request.setAttribute("name", name);
				request.setAttribute("lastname", lastname);
				request.setAttribute("rif", rif);
				request.setAttribute("identityCard", identityCard);
				request.setAttribute("unitId", unitId);
				request.setAttribute("gender", gender);
				
				rd = getServletContext().getRequestDispatcher("/reports_specialist.jsp");
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
