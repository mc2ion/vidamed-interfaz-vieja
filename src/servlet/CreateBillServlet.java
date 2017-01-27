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
 * Servlet implementation class CreateBillServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreateBillServlet" })
public class CreateBillServlet extends HttpServlet {
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
    public CreateBillServlet() {
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
		if(userE != null){try {
				Long 	id 				= Long.valueOf(request.getParameter("userId"));
				Long 	userId 			= Long.valueOf(request.getParameter("userReviewId"));
				Long	admissionID		= Long.valueOf(request.getParameter("admiId"));
				
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
				int result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.SetAdmissionData(admissionID, keyNumber, coverageAmount, guaranteeLetter, hasMultiple));
				
				result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.CreateBill(id, userId));
				if (result == 1)
					session.setAttribute("info", "La factura fue generada exitosamente!.");
				else
					session.setAttribute("info", "Hubo un error al generar la factura. Por favor, intente nuevamente.");
	
				response.sendRedirect(request.getContextPath() + "/ListCreditNotesReviewServlet");
				
			} 
			catch (Exception e) {
				throw new ServletException(e);
			}
		}else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
	}
}
