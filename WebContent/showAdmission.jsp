<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Ver Admisión</title>
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
	            	<li class="menuitem"><a href="admitPatientForm.jsp">Admitir Paciente</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Admisión:</h2>
				<br>
				<div style="text-align:left;">
				    <div class="leftColum"><b> Cédula: </b></div> V-12345678<br><br>
				   	<div class="leftColum"> <b> Nombre: </b></div> Ana Rojas<br><br>
				   	<div class="leftColum"> <b> Responsable del Pago: </b></div> Multinacional de Seguros, C.A.<br><br>
				    <div class="leftColum"><b> Motivo de Admisión: </b></div> Dolor abdominal<br><br>
				    <div class="leftColum"><b>Ubicación: </b></div> Emergencias<br><br>
				    <div class="leftColum"><b>N° Presupuesto:  </b></div>1001
				    <a href="showEstimation.jsp?function=showAdmission" style="color: transparent" >
						<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
					</a>
				    <br><br>
			    </div>
				<div id="botonera">
					<form action="printadmission.jsp">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</form>
				</div><br>
			</div>
		</div>
	</body>
</html>