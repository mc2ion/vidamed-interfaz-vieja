<%@page import="servlet.EditUserPasswordServlet"%>
<%@ page import="command.CommandExecutor" %>
<%@ page import="domain.User" %>
<%  
	try {
		User u = (User) CommandExecutor.getInstance().executeDatabaseCommand(new command.GetUserCurrentPassword(Long.parseLong(request.getParameter("userID"))));  
	    String isValid = "";
	    String encryptPassword = EditUserPasswordServlet.getEncryptPassword(request.getParameter("password"));
	    System.out.println(encryptPassword);
    	if (encryptPassword.equals(u.getPassword())) {
	    	isValid = "valid";
    	}
    	else {
	    	isValid = "invalid";
    	}
    	response.setContentType("text/plain");  
    	response.setCharacterEncoding("UTF-8"); 
    	response.getWriter().write(isValid);
	}
	catch (Exception e) {
		response.setContentType("text/plain");  
    	response.setCharacterEncoding("UTF-8"); 
    	response.getWriter().write("invalid"); 
	}
%>