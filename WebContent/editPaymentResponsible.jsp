<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Responsable de Pago</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />		
		<script type="text/javascript">
		
		function displayDiv(combo) {
			sel = combo.options[combo.selectedIndex].value;
			div1 = document.getElementById('genModel');
			div2 = document.getElementById('espModel');
			
			if(sel == 1){
				div1.style.display = "block";
				div2.style.display = "none";
			} else if (sel == 2){
				div1.style.display = "none";
				div2.style.display = "block";				
			} else {
				div1.style.display = "none";
				div2.style.display = "none";				
			}
		}
		
		function displaySubDiv(combo, i) {
			sel = combo.options[combo.selectedIndex].value;
			div2 = document.getElementById('genDesc'+i);
			div3 = document.getElementById('genAum'+i);
			
			if(sel == 2){
				div2.style.display = "block";
				div3.style.display = "none";
			} else if (sel == 3){
				div2.style.display = "none";
				div3.style.display = "block";				
			} else {
				div2.style.display = "none";
				div3.style.display = "none";				
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
	            	<li class="menuitem"><a href="paymentResponsibles.jsp">Ver Responsables</a></li>
            		<li class="menuitem"><a href="createPaymentResponsible.jsp">Crear Responsable</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute; overflow-y: scroll;">	
	        	<h2>Editar Responsable de Pago:</h2>
				<br>
				<fieldset>
					<label for="name">Nombre:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="MAPFRE La Seguridad"/> <br><br>
					<label for="name">Regla de Negocio:</label>
					<select name="selBusinessRule" id="selBusinessRule" onchange="displayDiv(this);">
						<option value="0">Seleccione...</option>
						<option value="1" selected>General</option>
						<option value="2">Específica (Por Micros)</option>
					</select> <br><br>
					<div id="genModel" style="display:block;">
						<label for="name">Modelo de Negocio:</label>
						<select name="selBusinessModel" id="selBusinessModel" onchange="displaySubDiv(this, 1);">
							<option value="0">Seleccione...</option>
							<option value="1" selected>Baremo</option>
							<option value="2">Baremo - Descuento</option>
							<option value="3">Baremo + Aumento</option>
						</select> <br><br>
						<div id="genDesc1" style="display:none;">
							<label for="name">Porcentaje de Descuento:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="3" size="3" /> <br><br>
						</div>
						<div id="genAum1" style="display:none;">
							<label for="name">Porcentaje de Aumento:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="3" size="3" /> <br><br>
						</div>
					</div>
					<div id="espModel" style="display:none;">
						<h3>Hospitalización</h3>
						<label for="name">Modelo de Negocio:</label>
						<select name="selBusinessModel" id="selBusinessModel" onchange="displaySubDiv(this, 2);">
							<option value="0" selected>Seleccione...</option>
							<option value="1">Baremo</option>
							<option value="2">Baremo - Descuento</option>
							<option value="3">Baremo + Aumento</option>
						</select> <br><br>
						<div id="genDesc2" style="display:none;">
							<label for="name">Porcentaje de Descuento:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="3" size="3" /><br><br>
						</div>
						<div id="genAum2" style="display:none;">
							<label for="name">Porcentaje de Aumento:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="3" size="3" /> <br><br>
						</div>
						<h3>Gastos en Quirófano</h3>
						<label for="name">Modelo de Negocio:</label>
						<select name="selBusinessModel" id="selBusinessModel" onchange="displaySubDiv(this, 3);">
							<option value="0" selected>Seleccione...</option>
							<option value="1">Baremo</option>
							<option value="2">Baremo - Descuento</option>
							<option value="3">Baremo + Aumento</option>
						</select> <br><br>
						<div id="genDesc3" style="display:none;">
							<label for="name">Porcentaje de Descuento:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="3" size="3" /><br><br>
						</div>
						<div id="genAum3" style="display:none;">
							<label for="name">Porcentaje de Aumento:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="3" size="3" /> <br><br>
						</div>
						<h3>Servicios Médicos</h3><label for="name">Modelo de Negocio:</label>
						<select name="selBusinessModel" id="selBusinessModel" onchange="displaySubDiv(this, 4);">
							<option value="0" selected>Seleccione...</option>
							<option value="1">Baremo</option>
							<option value="2">Baremo - Descuento</option>
							<option value="3">Baremo + Aumento</option>
						</select> <br><br>
						<div id="genDesc4" style="display:none;">
							<label for="name">Porcentaje de Descuento:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="3" size="3" /> <br><br>
						</div>
						<div id="genAum4" style="display:none;">
							<label for="name">Porcentaje de Aumento:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="3" size="3" /> <br><br>
						</div>
						<h3>Honorarios Profesionales</h3>
						<label for="name">Modelo de Negocio:</label>
						<select name="selBusinessModel" id="selBusinessModel" onchange="displaySubDiv(this, 5);">
							<option value="0" selected>Seleccione...</option>
							<option value="1">Baremo</option>
							<option value="2">Baremo - Descuento</option>
							<option value="3">Baremo + Aumento</option>
						</select> <br><br>
						<div id="genDesc5" style="display:none;">
							<label for="name">Porcentaje de Descuento:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="3" size="3" /> <br><br>
						</div>
						<div id="genAum5" style="display:none;">
							<label for="name">Porcentaje de Aumento:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="3" size="3" /><br><br>
						</div>
					</div>
				</fieldset>
				<div id="botonera">
					<form action="paymentResponsibles.jsp">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
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