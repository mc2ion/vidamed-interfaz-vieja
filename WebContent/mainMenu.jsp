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
	<title>Menú Principal</title>
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
			<h2>Bienvenido al Sistema Hospitalario de Vidamed </h2>
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			<h3>Menú Superior</h3>
			<p>En el menú superior encontrarás los enlaces para dirigirte al Home o salir del sistema; así como también las opciones propias de cada sección (del menú lateral izquierdo).</p>
			<p>&nbsp;</p>
			<h3>Menú Lateral Izquierdo</h3>
			<p>En el menú lateral izquierdo encontrarás las diversas áreas de Vidamed que tu usuario puede administrar. Ingresa al área de tu interés y realiza los ajustes que desees desde cualquier lugar gracias a las ventajas de la web.</p>
			<p>&nbsp;</p>
			<div id="footer"></div>
      	</div>
   </div>	
</body>
</html>