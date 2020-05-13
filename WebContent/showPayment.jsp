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
		<title>Ver Detalle Relación de Pago</title>
		<link rel="stylesheet" href="/resources/demos/style.css" />
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Detalle Pago realizado a Ana Rojas:</h2>   
	        	<br>
				<p>
			   	<b>Especialista:</b> Ana Rojas<br><br>
			    <b>N° de factura:</b> F-24410<br><br>
			    <b>Fecha de la factura:</b> 20/08/2013<br><br>
			    <b>Monto inicial:</b> Bs. 6220,00<br><br>
			    <b>Deducciones realizadas:</b> Bs. 1220,00<br><br>
			    <b>Descuentos aplicados:</b> Bs. 0,00<br><br>
			    <b>Monto a cobrar:</b> Bs. 5000,00<br><br>
			    <b>Cargo desempeñado:</b> Cirujano Ayudante<br><br><br>
			    <b>Pago Realizado el Día:</b> 20/09/2013 <br><br>
			    
			    <br><br>
			    </p>
				<div id="botonera" >
					<form action="PrintPaymentServlet">
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</form>
				</div>
			</div>
		</div>
	</body>
</html>