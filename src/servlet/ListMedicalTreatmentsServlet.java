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
import domain.DischargeType;
import domain.MedicalTreatment;


/**
 * Servlet implementation class ListMedicalTreatmentsServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListMedicalTreatmentsServlet" })
public class ListMedicalTreatmentsServlet extends HttpServlet {
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
    public ListMedicalTreatmentsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			@SuppressWarnings("unchecked")
			ArrayList<MedicalTreatment> medical = (ArrayList<MedicalTreatment>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetMedicalTreatments());
			request.setAttribute("medical", medical);
			@SuppressWarnings("unchecked")
			ArrayList<DischargeType> disc = (ArrayList<DischargeType>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetDischargeTypes());
			request.setAttribute("discharges", disc);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/medicalTreatment.jsp");
			rd.forward(request, response);
		}catch(Exception e){
			
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
