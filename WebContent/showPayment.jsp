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
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	   	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, <%= name %></a></li>
                <li><a href="ListAdmissionDischargesServlet">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
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