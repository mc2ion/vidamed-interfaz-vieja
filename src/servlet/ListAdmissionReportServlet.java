
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
import domain.AdmissionReasons;
import domain.DischargeType;
import domain.PermissionsList;
import domain.User;


/**
 * Servlet implementation class ListAdmissionReportServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListAdmissionReportServlet" })
public class ListAdmissionReportServlet extends HttpServlet {
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
    public ListAdmissionReportServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		if(userE != null && perm ){
			try {
				ArrayList<Admission> pp = (ArrayList<Admission>) CommandExecutor.getInstance().executeDatabaseCommand(
												new command.GetAdmissionReport());
				
				ArrayList<DischargeType> dt = (ArrayList<DischargeType>) CommandExecutor.getInstance().executeDatabaseCommand(
						new command.GetDischargeTypes());
				
				ArrayList<AdmissionReasons> ar = (ArrayList<AdmissionReasons>) CommandExecutor.getInstance().executeDatabaseCommand(
						new command.GetAdmissionReasons());

				request.setAttribute("pp", pp);
				request.setAttribute("dt", dt);
				request.setAttribute("ar", ar);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_admission.jsp");
				rd.forward(request, response);
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}	
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		
		
		boolean perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		
		if(userE != null && perm ){
			String admisionId 		= (String)request.getParameter("admissionid");
			String estimationId 	= (String)request.getParameter("estimationid");
			String r 				= (String) request.getParameter("reasonid");
			String reasonid 		= null;
			if (!r.equals("-"))
				reasonid = r;
			
			String admissionfrom 	= (String)request.getParameter("admissionfrom");
			String admissionto 		= (String)request.getParameter("admissionto");
			String d			 	= (String)request.getParameter("dischargetypeid");
			String dischargetypeid = null;
			if (!d.equals("-"))
				dischargetypeid = d;
			String dischargefrom	= (String)request.getParameter("dischargefrom");
			String dischargeto 		= (String)request.getParameter("dischargeto");
			
			
			try {
				
				@SuppressWarnings("unchecked")
				ArrayList<Admission> pp = (ArrayList<Admission>) CommandExecutor.getInstance().executeDatabaseCommand(
						new command.GetAdmissionReport(admisionId, estimationId, reasonid, admissionfrom, admissionto, dischargetypeid, dischargefrom, dischargeto));
				
				request.setAttribute("admisionId", admisionId);
				request.setAttribute("estimationId", estimationId);
				request.setAttribute("reasonid", reasonid);
				request.setAttribute("admissionfrom", admissionfrom);
				request.setAttribute("admissionto", admissionto);
				request.setAttribute("dischargetypeid", dischargetypeid);
				request.setAttribute("dischargefrom", dischargefrom);
				request.setAttribute("dischargeto", dischargeto);
				
				@SuppressWarnings("unchecked")
				ArrayList<DischargeType> dt = (ArrayList<DischargeType>) CommandExecutor.getInstance().executeDatabaseCommand(
						new command.GetDischargeTypes());
				
				@SuppressWarnings("unchecked")
				ArrayList<AdmissionReasons> ar = (ArrayList<AdmissionReasons>) CommandExecutor.getInstance().executeDatabaseCommand(
						new command.GetAdmissionReasons());

				request.setAttribute("pp", pp);
				request.setAttribute("dt", dt);
				request.setAttribute("ar", ar);
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/reports_admission.jsp");
				rd.forward(request, response);
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			if (userE == null){
				request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}else{
				RequestDispatcher rd = getServletContext().getRequestDispatcher("/sectionDenied.jsp");
				rd.forward(request, response);
			}
		}	
	}
}
