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
		<title>Ver Corte de Cuenta</title>
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
				<ul>
            		<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
            	</ul>	
		    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
		<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Corte de cuenta del(la) paciente Ana Rojas:</h2>   
	        	<br>
				<p>
			   	<b>Caja:</b> Administracion<br><br>
			    <b>Fecha Apertura:</b> 20/07/2013<br><br>
			    <b>Hora de apertura:</b> 9:30am<br><br>
			    <b>Cajero:</b> Ana Roja<br><br>
			    <b>Monto Inicio:</b> Bs. 100<br><br>
			    <b>Monto Cobrado:</b> Bs. 0<br><br>
			    <b>Monto Pagado:</b> Bs. 0<br><br>
			   
			    <br><br>
			    </p>
				<div id="botonera" >
					<form action="PrintCashBoxServlet">
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