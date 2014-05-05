<%@page import="domain.PendingEstimationDiscount"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	PendingEstimationDiscount discount = (PendingEstimationDiscount) request.getAttribute("discount");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Detalle solicitud descuento</title>
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
			 	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Detalle solicitud descuento:</h2>   
	        	<br>
				<p class="p-align">
			   	<b>Paciente:</b> <%= discount.getFirstName() + " " + discount.getLastName() %><br><br>
			    <b>Monto total de la factura:</b>Bs. <%= discount.getTotal() %><br><br>
			    <b>Descuento Solicitado:</b>Bs. <%= discount.getAmount() %><br><br>
			    <b>Justificación:</b><%= discount.getJustification() %><br><br>
			    <b>Fecha Solicitud:</b> <%= discount.getRequestDate() %><br><br>
			    <br><br>
			    </p>
				<div id="botonera" >
					<form action="DiscountActionServlet" method="post">
						<input type="hidden" name="id" value="<%= discount.getDiscountID() %>"/>
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="submit"  class="buttonGreen"  name="sbmtButton" value="Aceptar" />
						</div>	
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="submit"  class="buttonRed"  name="sbmtButton" value="Rechazar" />
						</div><br>
						<div id="botonV"  style="margin-left: 40px; margin-top: 20px;">
							<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</form>
				</div>
			</div>
		</div>
	</body>
</html>