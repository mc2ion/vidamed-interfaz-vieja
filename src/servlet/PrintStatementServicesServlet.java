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
import domain.BussinessMicro;
import domain.Protocol;
import domain.Service;
import domain.User;



/**
 * Servlet implementation class PrintStatementServicesServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/PrintStatementServicesServlet" })
public class PrintStatementServicesServlet extends HttpServlet {
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
    public PrintStatementServicesServlet() {
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
			Long admissionID = Long.parseLong(request.getParameter("userID"));
			System.out.println(admissionID);
			Admission admission;
			ArrayList<Protocol> protocols;
			String estimation;
			ArrayList<Service> costs;
			
			try {				
				admission = (Admission)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmission(admissionID));
				request.setAttribute("admission", admission);
				
				estimation = admission.getEstimationID().toString();
				
				protocols = (ArrayList<Protocol>)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(estimation));
				request.setAttribute("protocols", protocols);
				
				costs = (ArrayList<Service>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetServicesAdmissionCosts(admissionID));				
				request.setAttribute("costs", costs);
				
				ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
				request.setAttribute("bm", bm);				
				
				RequestDispatcher rd;				   
				rd = getServletContext().getRequestDispatcher("/printStatementServices.jsp");			
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