<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Cuenta por Pagar</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>		
		<!--JS Datapicker-->
		<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
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
			
			$(function(){
				$.datepicker.setDefaults($.datepicker.regional['es']);
				$('#txtDateIni2').datepicker({
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
                <li><a href="pendingAdmissionDischarges.jsp">Altas Admisi�n<span class="badge yellow">3</span></a></li>
		 		<li><a href="pendingCreditNotes.jsp">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="pendingCreditNotesReview.jsp">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="pendingInvoices.jsp">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="pendingRequest.jsp">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="pendingPharmacyDischarges.jsp">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="billing.jsp">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="mainMenu.jsp">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="accounts.jsp">Ver Cuentas</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Editar Cuenta por Pagar:</h2>
	        	<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Informaci�n Cuenta</a></li>
					    <li><a href="#tabs-2">Informaci�n Pago</a></li>
					    <li><a href="#tabs-3">Informaci�n Adicional</a></li>
			  		</ul>
			  		<div id="tabs-1">
						<fieldset>
							<label for="name">Documento a Pagar:</label>
							<select name="txtGen" id="txtGen">	
								<option value="-" >Seleccionar</option>
								<option value="F">Anticipo</option>
								<option value="F" selected="selected">Factura</option>
								<option value="F">Giros</option>
								<option value="F">Honorarios</option>
								<option value="F">Liquidaci�n</option>
								<option value="F">Nota de Cr�dito</option>
								<option value="F">Otros</option>
								<option value="F">Reintegros</option>
							</select> <br><br>
							<label for="name">Factura:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="F-7629"/> <br><br>
							<label for="name">N�mero Control:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="1725778"/> <br><br>
							<label for="name">Proveedor:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Anthony Bernal"/> 
							<a href="createSupplier.jsp?function=editAccountPayable"> <input type="submit"  class="button"  name="sbmtButton" value="Nuevo..." /></a><br><br>
							<label for="name">Fecha Facturaci�n:</label>
							<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" value="18/07/2013" /> <br><br>
							<label for="name">Fecha Vencimiento:</label>
							<input type="text" name="txtDateIni2" id="txtDateIni2" maxlength="50" size="10" value="20/09/2013" />
						</fieldset>						
						<div id="botonera">
							<form action="accounts.jsp" style="display: inline; ">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Editar" />
								</div>
							</form>	
							<form action="accounts.jsp#tabs-2" style="display: inline; ">
								<div id="botonV" style="display: inline; margin-right: 30px;" >
										<input type="submit" class="button" value="Regresar" />		
								</div>
							</form>	
						</div><br>
			  		</div>			  		
			  		<div id="tabs-2">
						<fieldset>
							<label for="name">Base Imponible:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Bs. 13392,85"/> <br><br>
							<label for="name">IVA:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Bs. 1607,15"/> <br><br>
							<label for="name">Monto Exento IVA:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="-"/> <br><br>
							<label for="name">Total Factura:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Bs. 15000"/> <br><br>
							<label for="name">Retenci�n IVA:</label> 
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="-"/> <br><br>
							<label for="name">Monto a Pagar:</label> 
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Bs. 15000"/>
						</fieldset>						
						<div id="botonera">
							<form action="accounts.jsp" style="display: inline; ">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Editar" />
								</div>
							</form>	
							<form action="accounts.jsp#tabs-2" style="display: inline; ">
								<div id="botonV" style="display: inline; margin-right: 30px;" >
										<input type="submit" class="button" value="Regresar" />		
								</div>
							</form>	
						</div><br>
			  		</div>
			  		<div id="tabs-3">
						<fieldset>
							<label for="name">Empresa:</label>
							<select name="txtGen" id="txtGen">	
								<option value="-" >Seleccionar</option>
								<option value="F" selected="selected">Centro M�dico Quir�rgico Vidamed</option>
								<option value="F">Centro Materno del Este</option>
								<option value="F">Servicios M�dicos Redmed, C.A.</option>
							</select> <br><br>
							<label for="name">Unidad de Negocio:</label>
							<select name="txtGen" id="txtGen">	
								<option value="-" >Seleccionar</option>
								<option value="F">Hospitalizaci�n Vidamed</option>
								<option value="F">Laboratorio Cl�nico</option>
								<option value="F">Rayos X Vidamed</option>
								<option value="F">Emergencia Vidamed</option>
								<option value="F">Ecosonograf�a Vidamed</option>
								<option value="F">Consulta Externa Vidamed</option>
								<option value="F" selected="selected">Compras e Inventario</option>
								<option value="F">Administraci�n</option>
							</select> <br><br>
							<label for="name">Clasificaci�n:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Urgente"/> <br><br>
							<label for="name">Tipo Proveedor:</label>
							<select name="txtGen" id="txtGen">	
								<option value="-" >Seleccionar</option>
								<option value="F" selected="selected">Proveedores</option>
								<option value="F">Honorarios</option>
								<option value="F">Pacientes</option>
								<option value="F">Seguros</option>
								<option value="F">Personal</option>
								<option value="F">Cliente Venta</option>
							</select> <br><br>
							<label for="name">Beneficiario Pago:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Vidamed C.A"/> <br><br>
							<label for="name">Notas de la Cuenta:</label>
							<textarea name="txtDescription" id="txtDescription" rows="2" cols="50"></textarea>
						</fieldset>		
						<div id="botonera">
							<form action="accounts.jsp" style="display: inline; ">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Editar" />
								</div>
							</form>	
							<form action="accounts.jsp#tabs-2" style="display: inline; ">
								<div id="botonV" style="display: inline; margin-right: 30px;" >
										<input type="submit" class="button" value="Regresar" />		
								</div>
							</form>	
						</div><br>
			  		</div>
			  	</div><br>
			</div>
		</div>
	</body>
</html>