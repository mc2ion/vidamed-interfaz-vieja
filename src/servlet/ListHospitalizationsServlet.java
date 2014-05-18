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
import domain.DischargeType;
import domain.Hospitalization;
import domain.User;


/**
 * Servlet implementation class ListHospitalizationsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListHospitalizationsServlet" })
public class ListHospitalizationsServlet extends HttpServlet {
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
    public ListHospitalizationsServlet() {
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
			try{
				@SuppressWarnings("unchecked")
				ArrayList<Hospitalization> hosp = (ArrayList<Hospitalization>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetHospitalizations());
				request.setAttribute("hospitalizations", hosp);
				@SuppressWarnings("unchecked")
				ArrayList<DischargeType> disc = (ArrayList<DischargeType>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetDischargeTypes());
				request.setAttribute("discharges", disc);
				rd = getServletContext().getRequestDispatcher("/hospitalization.jsp");
				rd.forward(request, response);
			}catch(Exception e){
				
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
