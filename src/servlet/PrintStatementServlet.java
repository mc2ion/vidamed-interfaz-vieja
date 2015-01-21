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
import domain.Admission;
import domain.Cost;
import domain.Protocol;
import domain.User;



/**
 * Servlet implementation class PrintStatementServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/PrintStatementServlet" })
public class PrintStatementServlet extends HttpServlet {
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
    public PrintStatementServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			Long admissionID = Long.parseLong(request.getParameter("id"));
			Admission admission;
			ArrayList<Protocol> protocols;
			String estimation;
			ArrayList<Cost> costs;
			
			try {				
				admission = (Admission)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmission(admissionID));
				request.setAttribute("admission", admission);
				
				estimation = admission.getEstimationID().toString();
				
				protocols = (ArrayList<Protocol>)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(estimation));
				request.setAttribute("protocols", protocols);
				
				costs = (ArrayList<Cost>)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetDetailedAdmissionCosts(admissionID));				
				request.setAttribute("costs", costs);
				
				RequestDispatcher rd;				   
				rd = getServletContext().getRequestDispatcher("/printStatement.jsp");			
				rd.forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
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
		
		doGet(request,response);
	}
}
