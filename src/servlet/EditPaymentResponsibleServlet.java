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
import domain.BussinessMicro;
import domain.BussinessModels;
import domain.BussinessRules;
import domain.PaymentResponsible;



/**
 * Servlet implementation class EditPaymentResponsibleServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/EditPaymentResponsibleServlet" })
public class EditPaymentResponsibleServlet extends HttpServlet {
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
    public EditPaymentResponsibleServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String idS = request.getParameter("rId");
		Long id = (long) 0;
		if (idS== null){
			idS = (String) request.getAttribute("rId");
			id =  Long.parseLong(idS);
		}else{
			id =  Long.parseLong(idS);
		}
		
		
		try {
			PaymentResponsible resp = (PaymentResponsible) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsible(id));
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
			
			//Obtener las reglas por cada Mirco
			//@SuppressWarnings("unchecked")
			//ArrayList<BussinessResponsibleRule> microRule = (ArrayList<BussinessResponsibleRule>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPaymentResponsibleRule(id));
			
			
			request.setAttribute("info", (String) request.getAttribute("info"));
			request.setAttribute("responsible", resp);
			request.setAttribute("bussinessRules", b);
			request.setAttribute("bussinessModels", m);
			request.setAttribute("bussinessMicros", micro);
			
			rd = getServletContext().getRequestDispatcher("/editPaymentResponsible.jsp");			
			rd.forward(request, response);
		
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Long id = Long.parseLong(request.getParameter("rId"));
		String name = request.getParameter("txtName");
		String oldName = request.getParameter("rName");
		Long businessRuleIdOld = Long.parseLong(request.getParameter("rbrId"));
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
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPaymentResponsible(id, name, selBusinessRule, selBusinessModel, txtPrice));
				request.setAttribute("rId", id);
				request.setAttribute("info", "Sus cambios fueron realizados exitosamente.");
				doGet(request, response);
			} catch (Exception e) {
				System.out.println("error");
				e.printStackTrace();
			}
		}
		/* Caso por micro*/
		else{
			System.out.println("oldName " + oldName);
			// Modifico el payment si cambio el nombre  o la regla de negocio
			if (!oldName.equals(name) || businessRuleIdOld != selBusinessRule){
				try {
					CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPaymentResponsible(id, name, selBusinessRule));
					request.setAttribute("rId", id);
					request.setAttribute("info", "Sus cambios fueron realizados exitosamente.");
					doGet(request, response);
				} catch (Exception e) {
					System.out.println("error");
					e.printStackTrace();
				}
				
			}
			
			selBusinessModelH = Long.parseLong(request.getParameter("selBusinessModel"  + H));
			selBusinessModelG = Long.parseLong(request.getParameter("selBusinessModel" + GQ));
			selBusinessModelS = Long.parseLong(request.getParameter("selBusinessModel" + SM));
			selBusinessModelM = Long.parseLong(request.getParameter("selBusinessModel" + HM));
			
			System.out.println(selBusinessModelH + " " + selBusinessModelG + " " + selBusinessModelS + " " + selBusinessModelM );
			
			/* Caso en el que hay baremos con descuento */
			if (selBusinessModelH > 1){
				txtPriceH = Double.valueOf(request.getParameter("txtPrice" + selBusinessModelH + H));
				System.out.println(txtPriceH);
					
			}	
			if (selBusinessModelG > 1){
				txtPriceG = Double.valueOf(request.getParameter("txtPrice" + selBusinessModelG + GQ));
				System.out.println(txtPriceG);
					
			}
			
			if (selBusinessModelS > 1){
				txtPriceS = Double.valueOf(request.getParameter("txtPrice" + selBusinessModelS + SM));
				System.out.println(txtPriceS);
					
			}
			
			if (selBusinessModelM > 1){
				txtPriceM = Double.valueOf(request.getParameter("txtPrice" + selBusinessModelM + HM ));
				System.out.println(txtPriceM);
					
			}
			
			/* Edito cada una de los micros */
			try {
				//System.out.println("micros " + id + " " + H + " " + selBusinessModelH + " " + txtPriceH);
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPaymentResponsible(id, (long) H, selBusinessModelH, txtPriceH));
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPaymentResponsible(id, (long) GQ, selBusinessModelG, txtPriceG));
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPaymentResponsible(id, (long) SM, selBusinessModelS, txtPriceS));
				CommandExecutor.getInstance().executeDatabaseCommand(new command.EditPaymentResponsible(id, (long) HM, selBusinessModelM, txtPriceM));
				
				request.setAttribute("rId", id);
				request.setAttribute("info", "Sus cambios fueron realizados exitosamente.");
				doGet(request, response);
			} catch (Exception e) {
				System.out.println("error");
				e.printStackTrace();
			}
			
		}
		
		
	}
}
