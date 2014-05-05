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
		<title>Ver Honorario Médico</title>
		<link rel="stylesheet" href="/resources/demos/style.css" />
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>
				<ul>
					<li class="menuitem"><a href="ListBanksServlet">Ver Cajas</a></li>
            		<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
            	</ul>	
		    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Detalle Honorario:</h2>   
	        	<br>
				<p>
			   	<b>Especialista:</b> Juan Pérez<br><br>
			    <b>N° de factura:</b> F-24410<br><br>
			    <b>Fecha de la factura:</b> 05/10/2013<br><br>
			    <b>Monto inicial:</b> Bs. 6220,00<br><br>
			    <b>Deducciones realizadas:</b> Bs. 1220,00<br><br>
			    <b>Descuentos aplicados:</b> Bs. 0,00<br><br>
			    <b>Monto a cobrar:</b> Bs. 5000,00<br><br>
			    <b>Cargo desempeñado:</b> Cirujano Ayudante<br><br>
			    <br><br>
			    </p>
				<div id="botonera" >
					<form action="#">
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</form>
				</div>
			</div>
		</div>
	</body>
</html>