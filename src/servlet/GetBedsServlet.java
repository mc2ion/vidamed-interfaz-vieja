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
import domain.Bed;

/**
 * Servlet implementation class GetBedsServlet
 */
@WebServlet(description = "servlet to edit x-ray reports", urlPatterns = { "/GetBedsServlet" })
public class GetBedsServlet extends HttpServlet {

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
    public GetBedsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		 response.setContentType("text/html;charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        try {
	        	Long locationId = Long.valueOf(request.getParameter("locationId"));
	            
	            @SuppressWarnings("unchecked")
				ArrayList<Bed> beds = (ArrayList<Bed>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetBeds(locationId));
	            
	            String options = "";
				if (beds != null && beds.size() > 0){
					options += "<option value=\"-\" selected>Seleccionar</option>";
					for (int i = 0; i < beds.size(); i++){
						options += "<option value="+ beds.get(i).getId()+">" + beds.get(i).getName() + "</option>";
					}
				}else
					options  = "No hay camas disponibles";
				
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
