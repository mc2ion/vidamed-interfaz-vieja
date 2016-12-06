package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import command.CommandExecutor;
import domain.User;



/**
 * Servlet implementation class SetAdmissionDischargeServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/SetAdmissionDischargeServlet" })
public class SetAdmissionDischargeServlet extends HttpServlet {
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
    public SetAdmissionDischargeServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			try {
				Long admissionID = Long.parseLong(request.getParameter("userId"));
				String keyNumber = null;
				
				if(request.getParameter("keyNumber") != null && !request.getParameter("keyNumber").equalsIgnoreCase("")){
					keyNumber = request.getParameter("keyNumber");
				}
				
				Double coverageAmount = null;
				
				if(request.getParameter("coverageAmount") != null && !request.getParameter("coverageAmount").equalsIgnoreCase("")){
					coverageAmount = Double.parseDouble(request.getParameter("coverageAmount"));
				}
				
				String guaranteeLetter = null;
				
				if(request.getParameter("guaranteeLetter") != null && !request.getParameter("guaranteeLetter").equalsIgnoreCase("")){
					guaranteeLetter = request.getParameter("guaranteeLetter");
				}
				
				Integer hasMultiple = 0;
				
				if(request.getParameter("imrp") != null){
					hasMultiple = 1;
					String[] paymentResponsibles = request.getParameterValues("paymentId");
					String[] keyNumbers = request.getParameterValues("additionalKeyNumber");
					String[] coverageAmounts = request.getParameterValues("additionalCoverageAmount");
					String[] guaranteeLetters = request.getParameterValues("additionalGuaranteeLetter");
					
					for(int i = 0; i < paymentResponsibles.length; i++){
						Long apr = (paymentResponsibles[i].equals(""))?null:Long.parseLong(paymentResponsibles[i]);
						String akn = (keyNumbers[i].equals(""))?null:keyNumbers[i];
						Double aca = (coverageAmounts[i].equals(""))?null:Double.parseDouble(coverageAmounts[i]);
						String agl = (guaranteeLetters[i].equals(""))?null:guaranteeLetters[i];
						System.out.println("paymentResponsible:"+apr+", keyNumber:"+akn+", coverageAmount:"+aca+", guaranteeLetter:"+agl);
						CommandExecutor.getInstance().executeDatabaseCommand(new command.AddAdmissionPaymentResponsible(admissionID, apr, akn, aca, agl));
					}
				}
								
				System.out.println("keyNumber:"+keyNumber+", coverageAmount:"+coverageAmount+", guaranteeLetter:"+guaranteeLetter+", hasMultiple:"+hasMultiple);
				Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.SetAdmissionDischarge(admissionID, keyNumber, coverageAmount, guaranteeLetter, hasMultiple));
				String text = "Se ha dado dado de alta exitosamente.";
				if (result == 0)
					text = "Hubo un error al dar de alta. Por favor, intente nuevamente.";
				session.setAttribute("info",text);
				
				response.sendRedirect(request.getContextPath() + "/ListAdmissionDischargesServlet");
			}
			catch (Exception e) {
				throw new ServletException(e);
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
	}
}
