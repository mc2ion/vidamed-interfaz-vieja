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
import domain.BussinessMicro;
import domain.BussinessModels;
import domain.BussinessRules;
import domain.ResponsibleRule;
import domain.User;



/**
 * Servlet implementation class CreatePaymentResponsibleServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CreatePaymentResponsibleServlet" })
public class CreatePaymentResponsibleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static long H = 1;
	private static long GQ = 2;
	private static long SM = 3;
	private static long HM = 4;
	
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
    public CreatePaymentResponsibleServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			try {
				RequestDispatcher rd;
				
				//Obtener bussiness-rule
				@SuppressWarnings("unchecked")
				ArrayList<BussinessRules> b = (ArrayList<BussinessRules>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessRules());
				
				//Obtener los nombres de los modelos
				@SuppressWarnings("unchecked")
				ArrayList<BussinessModels> m = (ArrayList<BussinessModels>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessModels());
				
				//Obtener los micros
				@SuppressWarnings("unchecked")
				ArrayList<BussinessMicro> micro = (ArrayList<BussinessMicro>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBussinessMicros());
				
				request.setAttribute("info", (String) request.getAttribute("info"));
				request.setAttribute("bussinessRules", b);
				request.setAttribute("bussinessModels", m);
				request.setAttribute("bussinessMicros", micro);
				
				rd = getServletContext().getRequestDispatcher("/createPaymentResponsible.jsp");			
				rd.forward(request, response);
			
			}catch (Exception e) {
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
		HttpSession session = request.getSession();
		User userE = (User)session.getAttribute("user");
		if(userE != null){
			String name = request.getParameter("txtName");
			Long selBusinessRule = Long.parseLong(request.getParameter("selBusinessRule"));
			Long selBusinessModel = null, selBusinessModelH = null, selBusinessModelG = null, selBusinessModelS = null, selBusinessModelM = null;
			double txtPrice = 0, txtPriceH = 0, txtPriceG = 0, txtPriceS = 0, txtPriceM = 0;
			/* Caso General */
			if (selBusinessRule == 1){
				selBusinessModel = Long.parseLong(request.getParameter("selBusinessModel"));
				/* Caso en el que hay baremos con descuento */
				if (selBusinessModel != 1){
					txtPrice = Double.valueOf(request.getParameter("txtPrice" + selBusinessModel));
				}	
				
				try {
					CommandExecutor.getInstance().executeDatabaseCommand(new command.CreatePaymentResponsible(name, selBusinessRule, selBusinessModel, txtPrice));
					response.sendRedirect(request.getContextPath() + "/ListPaymentResponsiblesServlet");
				} catch (Exception e) {
					System.out.println("error");
					e.printStackTrace();
				}
			}
			/* Caso por micro*/
			else{
				// Modifico el payment si cambio el nombre  o la regla de negocio
				/*if (!oldName.equals(name) || businessRuleIdOld != selBusinessRule){
					try {
						CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPaymentResponsible(id, name, selBusinessRule));
						request.setAttribute("rId", id);
						request.setAttribute("info", "Sus cambios fueron realizados exitosamente.");
						doGet(request, response);
					} catch (Exception e) {
						System.out.println("error");
						e.printStackTrace();
					}
					
				}*/
				
				selBusinessModelH = Long.parseLong(request.getParameter("selBusinessModel"  + H));
				selBusinessModelG = Long.parseLong(request.getParameter("selBusinessModel" + GQ));
				selBusinessModelS = Long.parseLong(request.getParameter("selBusinessModel" + SM));
				selBusinessModelM = Long.parseLong(request.getParameter("selBusinessModel" + HM));
				
				System.out.println(selBusinessModelH + " " + selBusinessModelG + " " + selBusinessModelS + " " + selBusinessModelM );
				ArrayList<ResponsibleRule> rrList = new ArrayList<ResponsibleRule>();
				
				ResponsibleRule h = new ResponsibleRule();
				ResponsibleRule g = new ResponsibleRule();
				ResponsibleRule s = new ResponsibleRule();
				ResponsibleRule m = new ResponsibleRule();
				
				h.setBussinesRuleMicroId((long) 1);
				h.setBussinessModelId(selBusinessModelH);
				/* Caso en el que hay baremos con descuento */
				if (selBusinessModelH > 1){
					txtPriceH = Double.valueOf(request.getParameter("txtPrice" + selBusinessModelH + H));
					h.setPercentage(txtPriceH);
					System.out.println(txtPriceH);
				}	
				rrList.add(h);
				
				
				g.setBussinesRuleMicroId((long) 2);
				g.setBussinessModelId(selBusinessModelG);
				if (selBusinessModelG > 1){
					txtPriceG = Double.valueOf(request.getParameter("txtPrice" + selBusinessModelG + GQ));
					g.setPercentage(txtPriceG);
					System.out.println(txtPriceG);
						
				}
				rrList.add(g);
				
				s.setBussinesRuleMicroId((long) 3);
				s.setBussinessModelId(selBusinessModelS);
				if (selBusinessModelS > 1){
					txtPriceS = Double.valueOf(request.getParameter("txtPrice" + selBusinessModelS + SM));
					s.setPercentage(txtPriceS);
					System.out.println(txtPriceS);
				}
				rrList.add(s);
				
				
				m.setBussinesRuleMicroId((long) 4);
				m.setBussinessModelId(selBusinessModelM);
				if (selBusinessModelM > 1){
					txtPriceM = Double.valueOf(request.getParameter("txtPrice" + selBusinessModelM + HM ));
					m.setPercentage(txtPriceM);
					System.out.println(txtPriceM);
				}
				rrList.add(m);
				
				/* Edito cada una de los micros */
				try {
					//System.out.println("micros " + id + " " + H + " " + selBusinessModelH + " " + txtPriceH);
					CommandExecutor.getInstance().executeDatabaseCommand(new command.CreatePaymentResponsible(name, selBusinessRule, rrList));
					response.sendRedirect(request.getContextPath() + "/ListPaymentResponsiblesServlet");
					//request.setAttribute("info", "Sus cambios fueron realizados exitosamente.");
					//doGet(request, response);
				} catch (Exception e) {
					System.out.println("error");
					e.printStackTrace();
				}
				
			}
		} else {
			request.setAttribute("time_out", "Su sesión ha expirado. Ingrese nuevamente"); RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}	
	}
}
