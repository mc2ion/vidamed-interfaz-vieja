<%@page import="domain.PendingPromptPayment"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	PendingPromptPayment pp = (PendingPromptPayment)request.getAttribute("pp");
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Ver Concilación de Pronto Pago</title>
		<link rel="stylesheet" href="/resources/demos/style.css" />
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>
				<ul>
					<li class="menuitem"><a href="ListBillingsPPServlet">Listado Pronto Pago</a></li>
            	</ul>	
		    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Detalle conciliación:</h2>   
	        	<br>
				<p>
				<%
					String eName  = pp.getSpecialist().getFirstName() + " " + pp.getSpecialist().getLastName();
					String status = "Cobrado";
					if (pp.getBillWasPaid() == 0)
						status = "Pendiente";
				%>
			   	<b>Especialista:</b> <%= eName %><br><br>
			    <b>N° de factura:</b> <%= pp.getBillID() %><br><br>
			    <b>Fecha de la factura:</b> <%= pp.getBillDate() %><br><br>
			    <b>Monto total:</b> Bs. <%= pp.getTotalAmount() %><br><br>
			    <b>Monto deducido por pronto pago:</b> Bs. <%= pp.getDiscountedAmount() %><br><br>
			    <b>Monto a pagar:</b> Bs. <%= pp.getAmount() %><br><br>
			    <b>Estatus del pago:</b> <%= status %><br><br>
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