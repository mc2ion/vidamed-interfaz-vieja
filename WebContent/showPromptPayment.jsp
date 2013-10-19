<!DOCTYPE html>
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
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	   	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="pendingAdmissionDischarges.jsp">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="pendingCreditNotes.jsp">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="pendingCreditNotesReview.jsp">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="pendingInvoices.jsp">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="pendingRequest.jsp">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="pendingPharmacyDischarges.jsp">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="billing.jsp">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="mainMenu.jsp">Home</a></div>
				<ul>
					<li class="menuitem"><a href="bank.jsp">Ver Cajas</a></li>
            		<li class="menuitem"><a href="createCashBox.jsp">Crear Caja</a></li>
            	</ul>	
		    	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Detalle conciliación:</h2>   
	        	<br>
				<p>
			   	<b>Especialista:</b> Juan Pérez<br><br>
			    <b>N° de factura:</b> F-24410<br><br>
			    <b>Fecha de la factura:</b> 05/10/2013<br><br>
			    <b>Monto total:</b> Bs. 6000,00<br><br>
			    <b>Monto deducido por pronto pago:</b> Bs. 1000,00<br><br>
			    <b>Monto a pagar:</b> Bs. 5000,00<br><br>
			    <b>Cargo desempeñado:</b> Cirujano Ayudante<br><br>
			    <b>Estatus del pago:</b> Sin realizar<br><br>
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