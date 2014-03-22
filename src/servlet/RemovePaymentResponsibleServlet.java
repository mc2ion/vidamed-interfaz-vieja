package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandExecutor;



/**
 * Servlet implementation class RemovePaymentResponsibleServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/RemovePaymentResponsibleServlet" })
public class RemovePaymentResponsibleServlet extends HttpServlet {
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
    public RemovePaymentResponsibleServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			Long rId = Long.parseLong(request.getParameter("rId"));
			System.out.println("id " + rId );
			Integer result = (Integer) CommandExecutor.getInstance().executeDatabaseCommand(new command.RemovePaymentResposible(rId));
			request.setAttribute("result", result);
			response.sendRedirect(request.getContextPath() + "/ListPaymentResponsiblesServlet");
			
		}
		catch (Exception e) {
			throw new ServletException(e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}
}
