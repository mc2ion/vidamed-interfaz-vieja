<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Registrar Pago</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />		
		<script>
		function findPatient(){
			div1 = document.getElementById('patient');
			div1.style.display = "block";
		}
		
		function displayPaymentFields(combo) {
			sel = combo.options[combo.selectedIndex].value;
			bank = document.getElementById('bank');
			check = document.getElementById('check');
			sellPoint = document.getElementById('sellPoint');
			insurance = document.getElementById('insurance');
			
			if(sel == 1 || sel == 0){
				bank.style.display = "none";
				check.style.display = "none";
				sellPoint.style.display = "none";
				insurance.style.display = "none";
			} else if(sel == 2 || sel == 3){
				bank.style.display = "block";
				check.style.display = "none";
				sellPoint.style.display = "block";
				insurance.style.display = "none";
			} else if(sel == 4){
				bank.style.display = "block";
				check.style.display = "block";
				sellPoint.style.display = "none";
				insurance.style.display = "none";
			} else if(sel == 5){
				bank.style.display = "none";
				check.style.display = "none";
				sellPoint.style.display = "none";
				insurance.style.display = "block";
			}
		}
		</script>
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
	            	<li class="menuitem"><a href="bank.jsp">Ver Cajas</a></li>
            		<li class="menuitem"><a href="createCashBox.jsp">Crear Caja</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Registrar Pago:</h2>
				<br>
				<fieldset>
					<label for="name">C�dula Paciente:</label>
					<select id="cedId" name="cedId">
						<option value="V-" >V</option>
						<option value="E-" >E</option>
					</select> &nbsp;<input id="cedNumber" type="text" style="width: 135px;">
		        	<a id="go" rel="leanModal"  href="#" style="color: #f7941e; font-weight: bold;">
						<img alt="logo" src="./images/detail.png" onclick="findPatient();"  height="16" width="16" title="Buscar Paciente" />
					</a><br><br>
					<div id="patient" style="display:none;">
						<label for="name">N� de Presupuesto:</label>
						<input type="text" value="1001" style="width: 135px;"> <br><br>
						<label for="name">Responsable de Pago:</label>
						<select>
							<option value="0">Seleccionar</option>
							<option value="5">Particular</option>
							<option value="4">Mapfre La Seguridad</option>
							<option value="3">Seguros La Previsora</option>
						</select> <br><br>
					</div>
					<label for="name">Tipo:</label>
					<select style="width:111px;">
						<option value="0">Seleccionar</option>
						<option value="1">Abono</option>
						<option value="2">Pago</option>
						<option value="3">Reintegro</option>
					</select> <br><br>
					<label for="name">Forma:</label>
					<select onchange="displayPaymentFields(this);">
						<option value="0">Seleccionar</option>
						<option value="4">Cheque</option>
						<option value="1">Efectivo</option>
						<option value="5">Orden Pago</option>
						<option value="3">Tarjeta Cr�dito</option>
						<option value="2">Tarjeta D�bito</option>
					</select> <br><br>
					<div id="bank" style="display:none;">
						<label for="name">Banco:</label>
						<select>
							<option value="0">Seleccionar</option>
							<option value="5">Banco Bicentenario</option>
							<option value="4">Banco Mercantil</option>
							<option value="3">Banco Provincial</option>
							<option value="1">Banco Venezuela</option>
							<option value="2">Banesco</option>
						</select> <br><br>
					</div>
					<div id="check" style="display:none;">
						<label for="name">N� de Cheque:</label>
						<input type="text" value="" style="width: 135px;"> <br><br>
					</div>
					<div id="sellPoint" style="display:none;">
						<label for="name">Punto de Venta:</label>
						<select>
							<option value="0">Seleccionar</option>
							<option value="5">Banesco</option>
							<option value="4">Banco Mercantil</option>
							<option value="3">Banco Activo</option>
						</select> <br><br>
						<label for="name">N� de Aprobaci�n:</label>
						<input type="text" value="" style="width: 135px;"> <br><br>
					</div>
					<div id="insurance" style="display:none;">
						<label for="name">Compa��a de Seguro:</label>
						<select>
							<option value="0">Seleccionar</option>
							<option value="5">Mapfre La Seguridad</option>
							<option value="4">Mercantil Seguros</option>
							<option value="3">Banesco Seguros</option>
						</select> <br><br>
					</div>
					<label for="name">Monto:</label>
					<input type="text" value="" style="width: 135px;"> <br><br>
				</fieldset>
				<div id="botonera">
					<form action="bank.jsp">
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