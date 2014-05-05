package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.BedLocation;



/**
 * Servlet implementation class SearchBedsServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/SearchBedsServlet" })
public class SearchBedsServlet extends HttpServlet {
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
    public SearchBedsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher rd;
		String function 	= request.getParameter("function");
		String admissionId 	= request.getParameter("id");
		System.out.println("ad " + admissionId);
		try {
			@SuppressWarnings("unchecked")
			ArrayList<BedLocation> lList = (ArrayList<BedLocation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.SearchLocations());
			request.setAttribute("locations", lList);
			request.setAttribute("admissionId", admissionId);
			if (function != null)
				rd = getServletContext().getRequestDispatcher("/searchBed.jsp?function=" + function);	
			else
				rd = getServletContext().getRequestDispatcher("/searchBed.jsp");	
			rd.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Long bedId 	 	 = Long.valueOf(request.getParameter("bed"));
		Long admissionId = Long.valueOf(request.getParameter("admissionId"));
		
		try {
			Integer result  = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditLocation(admissionId, bedId));
			System.out.println("result " + result);
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//doGet(request, response);
	}
}
