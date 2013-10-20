<!DOCTYPE html>
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
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>
			 	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Detalle solicitud descuento:</h2>   
	        	<br>
				<p class="p-align">
			   	<b>Paciente:</b> Ana Rojas<br><br>
			    <b>Monto total de la factura:</b>Bs. 35562,00<br><br>
			    <b>Descuento Solicitado:</b>Bs. 1000,00<br><br>
			    <b>Protocolo a realizar:</b>Histerectomía<br><br>
			    <b>Justificación:</b> Se solicita este descuento ya que la paciente es hija del doctor Pablo Rojas, quien será quien realice la operación.<br><br>
			    <b>Fecha Solicitud:</b> 17/06/2013<br><br>
			    <br><br>
			    </p>
				<div id="botonera" >
					<form action="#">
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