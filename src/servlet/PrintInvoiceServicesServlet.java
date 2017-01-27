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
 * Servlet implementation class PrintInvoiceServicesServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/PrintInvoiceServicesServlet" })
public class PrintInvoiceServicesServlet extends HttpServlet {
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
    public PrintInvoiceServicesServlet() {
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
			Long admissionID = Long.parseLong(request.getParameter("admId"));
			System.out.println(admissionID);
			Admission admission;
			ArrayList<Protocol> protocols;
			String estimation;
			ArrayList<Service> costs;
			String factId   = request.getParameter("factId");
			String prefactId   = request.getParameter("prefactId");
			String f 		= request.getParameter("f");
			Long correlativeNumber = null;
			if(request.getParameter("correlativeNumber")!=null && !request.getParameter("correlativeNumber").equalsIgnoreCase("")){
				correlativeNumber = Long.parseLong(request.getParameter("correlativeNumber"));
			}
			
			try {			
				if(correlativeNumber !=null){
					CommandExecutor.getInstance().executeDatabaseCommand(new command.SetCorrelativeNumber(Long.parseLong(factId), correlativeNumber));
				}
				admission = (Admission)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetAdmission(admissionID));
				request.setAttribute("admission", admission);
				
				estimation = admission.getEstimationID().toString();
				
				protocols = (ArrayList<Protocol>)CommandExecutor.getInstance().executeDatabaseCommand(new command.GetEstimationProtocols(estimation));
				request.setAttribute("protocols", protocols);
				
				costs = (ArrayList<Service>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetServicesAdmissionCosts(admissionID));				
				request.setAttribute("costs", costs);
				
				ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
				request.setAttribute("bm", bm);
				
				if(prefactId != null){
					factId = prefactId;
				}
				
				request.setAttribute("factId", factId);
				request.setAttribute("f", f);
				
				
				RequestDispatcher rd;				   
				rd = getServletContext().getRequestDispatcher("/printInvoiceServices.jsp");			
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
