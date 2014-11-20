<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Sección no permitida</title>
</head>
<body>
	<div id="container">
		<div id="header">
            
        </div>  
      	<jsp:include page="./upperMenu.jsp" />        
		<div id="menu">
			
			<div class="menuitemHome"><a href="#">Home</a></div>	
			<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>   	
       <jsp:include page="./menu.jsp" />    
		<div id="content">  
			Disculpe, usted no tiene permisos para ingresar a esta sección. En caso de que sea necesario que usted ingrese a la sección
			póngase en contacto con un superior para añadirle los permisos correspondientes.
			<div id="footer"></div>
      	</div>
   </div>	
</body>
</html>