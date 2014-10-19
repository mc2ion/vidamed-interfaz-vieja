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
import domain.BedLocation;
import domain.User;



/**
 * Servlet implementation class SearchAdmissionBedsServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/SearchAdmissionBedsServlet" })
public class SearchAdmissionBedsServlet extends HttpServlet {
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
    public SearchAdmissionBedsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			RequestDispatcher rd;
			try {
				
				String id 					= request.getParameter("id");
				String bedId				= request.getParameter("bId");
				
				@SuppressWarnings("unchecked")
				ArrayList<BedLocation> lList = (ArrayList<BedLocation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.SearchLocations());
				
				request.setAttribute("txtCedNumber", id);
				request.setAttribute("locations", lList);
				request.setAttribute("bedId", bedId);
				
				rd = getServletContext().getRequestDispatcher("/searchAdmissionBed.jsp");	
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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			String bedId 	 	 	= request.getParameter("bed");
			//String txtCedNumber 	= request.getParameter("txtCedNumber");
			String oldBedId			= request.getParameter("bedId");
			try{
				request.setAttribute("bedId", bedId);
				/* Si oldBedId es diferente de nulo, colocar como desocupada esa cama */
				if (oldBedId != null && !oldBedId.equals("null")){
					Long id = Long.valueOf(oldBedId);
					CommandExecutor.getInstance().executeDatabaseCommand(new command.SetBedOccupation(id, 0));
				}
				
				request.setAttribute("function", "searchBed");
				
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/AdmitPatientServlet");
				rd.forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); 
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
		//doGet(request, response);
	}
}
