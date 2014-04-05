package servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.misc.BASE64Encoder;

import command.CommandExecutor;
import domain.User;



/**
 * Servlet implementation class ShowCashBoxServlet
 */
@WebServlet(description = "servlet to log in users", urlPatterns = { "/CloseCashBoxServlet" })
public class CloseCashBoxServlet extends HttpServlet {
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
    public CloseCashBoxServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			String password = request.getParameter("password");
			Long userID = Long.parseLong(request.getParameter("userID"));
			String encryptPassword = getEncryptPassword(password);
			User user = (User) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserCurrentPassword(userID));
			if (user.getPassword().equals(encryptPassword)) {
				Long cashBoxID = Long.parseLong(request.getParameter("cashBoxID"));
				Double amount = Double.parseDouble(request.getParameter("totalAmount"));
				CommandExecutor.getInstance().executeDatabaseCommand(new command.CloseCashBox(cashBoxID, userID, amount));
			}
			else {
				request.setAttribute("error", "La clave introducida no es correcta.");
			}
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/ListCashBoxesServlet");	
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
	
	/**
	 * 
	 * @param password
	 * @return
	 */
	public static String getEncryptPassword(String password){
		MessageDigest md;

		try {

			md = MessageDigest.getInstance("SHA");
			String clearPassword = password;
			md.update(clearPassword.getBytes("UTF-8"));
	        byte[] digestedPassword = md.digest();
		    String hash = (new BASE64Encoder()).encode(digestedPassword);
		    return hash;

		} catch (NoSuchAlgorithmException e) {

			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return null;
	}
}
