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
import domain.PermissionsList;
import domain.Protocol;
import domain.User;



/**
 * Servlet implementation class ShowCreditNoteEstimationServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/ShowCreditNoteEstimationServlet" })
public class ShowCreditNoteEstimationServlet extends HttpServlet {
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
    public ShowCreditNoteEstimationServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.creditNotesReview);
		if(userE != null && perm ){
			Long admissionID = Long.parseLong(request.getParameter("id"));
			Admission admission;
			ArrayList<Protocol> protocols;
			String estimation;
			ArrayList<Protocol> costs;
			String factId   = request.getParameter("factId");
			try {				
				admission = (Admission)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmission(admissionID));
				request.setAttribute("admission", admission);
				
				estimation = admission.getEstimationID().toString();
				
				protocols = (ArrayList<Protocol>)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(estimation));
				request.setAttribute("protocols", protocols);
				
				costs = (ArrayList<Protocol>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetDetailedAdmissionCosts(admissionID));				
				request.setAttribute("costs", costs);
				
				ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
				request.setAttribute("bm", bm);
				request.setAttribute("factId", factId);
				
				RequestDispatcher rd;				   
				rd = getServletContext().getRequestDispatcher("/showCreditNoteEstimation.jsp");			
				rd.forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			request.setAttribute("time_out", "Su sesi�n ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
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
