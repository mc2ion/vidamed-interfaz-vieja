package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.Specialist;
import domain.SpecialistUnit;
import domain.Unit;


/**
 * Servlet implementation class ListDoctorsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListSpecialistsServlet" })
public class ListSpecialistsServlet extends HttpServlet {
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
    public ListSpecialistsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<Specialist> specialists = (ArrayList<Specialist>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSpecialists());
			
			HashMap<Long, ArrayList<Unit>> specialistUnits = new HashMap<Long, ArrayList<Unit>>();
			for (int i = 0; i<specialists.size(); i++) {
				Long specialistID = specialists.get(i).getId();
				ArrayList<SpecialistUnit> aux = (ArrayList<SpecialistUnit>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSpecialistUnits(specialistID));
				ArrayList<Unit> units = new ArrayList<Unit>();
				for (int j = 0; j<aux.size(); j++) {
					Long unitID = aux.get(j).getUnitID();
					Unit u = (Unit) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUnit(unitID));
					units.add(u);
				}
				specialistUnits.put(specialists.get(i).getId(), units);
			}
			
			request.setAttribute("specialists", specialists);
			request.setAttribute("specialistUnits", specialistUnits);
			
			RequestDispatcher rd;			
			rd = getServletContext().getRequestDispatcher("/specialists.jsp");
			rd.forward(request, response);
		} 
		catch (Exception e) {
			throw new ServletException(e);
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
