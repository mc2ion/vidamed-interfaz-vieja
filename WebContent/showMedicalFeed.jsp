<%@page import="domain.PendingMedicalFee"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	

	PendingMedicalFee pp = (PendingMedicalFee) request.getAttribute("pp");
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
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Detalle Honorario:</h2>   
	        	<br>
				<p>
				<%
					String eName  = pp.getSpecialist().getFirstName() + " " + pp.getSpecialist().getLastName();
					String status = "Cobrado";
					if (pp.getBillWasPaid() == 0)
						status = "Pendiente";
					String statusH = "Cobrado";
					if (pp.getFeeWasPaid() == 0)
						statusH = "Pendiente";
				%>
			   	<b>Especialista:</b> <%= eName %><br><br>
			    <b>N° de factura:</b> <%= pp.getBillID() %><br><br>
			    <b>Monto:</b> Bs. <%= pp.getAmount() %><br><br>
			    <b>Estatus del pago del seguro:</b> <%= status %><br><br>
			    <b>Fecha del pago de la factura:</b> <%= pp.getBillDate() %><br><br>
			    <b>Estatus del pago del honorario:</b> <%= statusH %><br><br>
			    <% if (pp.getFeeWasPaid() == 1){ %>
			    	<b>Fecha del pago del honorario:</b> <%= pp.getPaymentDate() %><br><br>
			    <% } %>
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