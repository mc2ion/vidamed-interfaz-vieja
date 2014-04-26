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
import domain.PendingCreditNotes;


/**
 * Servlet implementation class ListCreditNotesServlet
 */
@WebServlet(description = "servlet to generate reports", urlPatterns = { "/ListCreditNotesServlet" })
public class ListCreditNotesServlet extends HttpServlet {
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
    public ListCreditNotesServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			@SuppressWarnings("unchecked")
			ArrayList<PendingCreditNotes> creditNotes = (ArrayList<PendingCreditNotes>) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetPendingCreditNotes());
			request.setAttribute("creditNotes", creditNotes);
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/pendingCreditNotes.jsp");
			rd.forward(request, response);
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
