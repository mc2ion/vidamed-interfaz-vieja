<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Movimiento</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>		
		<!--JS Datapicker-->
		<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<script type="text/javascript">
			$(function(){
				$.datepicker.setDefaults($.datepicker.regional['es']);
				$('#txtDateIni').datepicker({
					showOn: "button",
					buttonImage: "images/calendar.png",
					buttonImageOnly: true,
					buttonText: "Seleccione una fecha",
					dateFormat:'dd/mm/yyyy',
					changeMonth: true,
				    changeYear: true
				});
			} );
		</script>
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
	            	<li class="menuitem"><a href="bankaccounts.jsp">Ver Cuentas</a></li>
	            	<li class="menuitem"><a href="accountMovements.jsp">Ver Movimientos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
				 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Crear Movimiento:</h2>
				<br>
				<fieldset>
					<label for="name">Fecha:</label>
					<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="5"/> <br><br>
					<label for="name">Tipo de Movimiento:</label>
					<select name="txtCedId" id="txtCedId">	
						<option value="-" selected="selected">Seleccionar</option>
						<option value="V-">Depósito</option>
						<option value="E-">Orden de Pago</option>
						<option value="V-">Nota de Crédito</option>
						<option value="E-">Pago a Proveedores</option>
						<option value="V-">Pago Honorarios Médicos</option>
					</select> <br><br>
					<label for="name">Descripción:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>		
					<label for="name">Monto:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>					
				</fieldset>
				<div id="botonera">
					<form action="accountMovements.jsp">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
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