package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;
import domain.Specialist;

/**
 * Servlet implementation class GetSpecialistServlet
 */
@WebServlet(description = "servlet to edit x-ray reports", urlPatterns = { "/GetSpecialistServlet" })
public class GetSpecialistServlet extends HttpServlet {

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
    public GetSpecialistServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		 response.setContentType("text/html;charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        try {
	            Long unit = Long.valueOf(request.getParameter("unit"));
	            @SuppressWarnings("unchecked")
				ArrayList<Specialist> specialists = (ArrayList<Specialist>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetSpecialistsByUnit(unit));
	            String options = "";
	            if (specialists.size() > 0){
					options = "<option value=\"\">Seleccionar</option>";
					for (int i = 0; i < specialists.size(); i++){
		            	String name = specialists.get(i).getFirstName() + " "+specialists.get(i).getLastName() ;
						options += "<option value="+ specialists.get(i).getId()+">" + name + "</option>";
					}
				}else
					options = "<option value=\"\">No hay especialistas </div>";
				
	            out.print(options);
	        }  catch (Exception ex) {
	            out.print("Error getting product name..." + ex.toString());
	        }
	        finally {
	            out.close();
	        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
