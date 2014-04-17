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
import domain.Admission;
import domain.AdmissionStatus;


/**
 * Servlet implementation class ListAdmissionsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListAdmissionsServlet" })
public class ListAdmissionsServlet extends HttpServlet {
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
    public ListAdmissionsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			@SuppressWarnings("unchecked")
			ArrayList<Admission> admissions = (ArrayList<Admission>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmissions());
			request.setAttribute("admissions", admissions);
			@SuppressWarnings("unchecked")
			ArrayList<AdmissionStatus> admissionStatus = (ArrayList<AdmissionStatus>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmissionStatuses());
			request.setAttribute("status", admissionStatus);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/admission.jsp");
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
