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
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.BedLocation;
import domain.User;



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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			RequestDispatcher rd;
			String function 	= request.getParameter("function");
			String admissionId 	= request.getParameter("id");
			String bedName 		= request.getParameter("bN");
			String locationName	= request.getParameter("lN");
			
			try {
				@SuppressWarnings("unchecked")
				ArrayList<BedLocation> lList = (ArrayList<BedLocation>) CommandExecutor.getInstance().executeDatabaseCommand(new command.SearchLocations());
				
				request.setAttribute("locations", lList);
				request.setAttribute("admissionId", admissionId);
				request.setAttribute("bedName", bedName);
				request.setAttribute("locName", locationName);
				request.setAttribute("function", function);
				rd = getServletContext().getRequestDispatcher("/searchBed.jsp");	
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
			Long bedId 	 	 = Long.valueOf(request.getParameter("bed"));
			Long admissionId = Long.valueOf(request.getParameter("admissionId"));
			String function 	= request.getParameter("function");
			
			try{
				Integer result  = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.EditLocation(admissionId, bedId));
				
				String text = "La ubicación del paciente fue actualizada exitosamente.";
				if (result == 0)
					text =	"Hubo un problema al actualizar la ubicación del paciente. Por favor, intente nuevamente.";
				
				session.setAttribute("text", text);
				
				if (function != null){
					if (function.equals("editMedicalTreatment"))
						response.sendRedirect(request.getContextPath() + "/EditMedicalTreatmentServlet?id=" + admissionId);
					else if (function.equals("editEmergency"))
						response.sendRedirect(request.getContextPath() + "/EditEmergencyServlet?id=" + admissionId);
					else if (function.equals("editHospitalization"))
						response.sendRedirect(request.getContextPath() + "/EditHospitalizationServlet?id=" + admissionId);
						
				}
				
			} catch (NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
		//doGet(request, response);
	}
}
