package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.PendingAdmissionDischarges;


/**
 * Servlet implementation class ListAdmissionDischargesServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListAdmissionDischargesServlet" })
public class ListAdmissionDischargesServlet extends HttpServlet {
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
    public ListAdmissionDischargesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			@SuppressWarnings("unchecked")
			ArrayList<PendingAdmissionDischarges> admissions = (ArrayList<PendingAdmissionDischarges>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPendingAdmissionDischarges());
			request.setAttribute("admissions", admissions);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/pendingAdmissionDischarges.jsp");
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
