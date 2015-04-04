<%@page import="domain.PendingAccounts"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	PendingAccounts p = (PendingAccounts) request.getAttribute("pendingAccount");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Cuenta Pendiente</title>
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
        	<div id="content" style="position:absolute;">	
	        	<h2>Detalle Cuenta Pendiente:</h2>   
	        	<br>
				<p>
			   	<b style='display: inline-block; width:175px;'>N° de factura:</b> <%= p.getBillID() %><br><br>
			    <b style='display: inline-block; width:175px;'>Fecha de la factura:</b> <%= p.getGenerationDate()%><br><br>
			    <b style='display: inline-block; width:175px;'>Responsable de Pago:</b> <%= p.getPaymentResposible().getName()%><br><br>
			    <b style='display: inline-block; width:175px;'>Monto:</b> Bs. <%= p.getTotal() %><br><br>
			    <b style='display: inline-block; width:175px;'>Descuento:</b> Bs. <%= (p.getTotalWithDiscount() != null) ?  p.getTotalWithDiscount()  : 0 %><br><br>
			    <b style='display: inline-block; width:175px;'>Pagado:</b> Bs. <%= (p.getTotalPaid() != null) ?  p.getTotalPaid()  : 0 %> <br><br>
			    <br><br>
			    </p>
				<div id="botonera" >
					<div id="botonV" style="display: inline;">
							<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
					</div>	
				</div>
			</div>
		</div>
	</body>
</html>