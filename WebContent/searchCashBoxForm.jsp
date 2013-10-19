<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Imprimir Cierre de Caja</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />	
		<script>
		  $(function() {
		    $( "#txtCloseDate" ).datepicker({
		      showOn: "button",
		      buttonImage: "images/calendar.png",
		      buttonImageOnly: true
		    });
		  });
		  
		  $(function() {
			    $( "#txtOpenDate" ).datepicker({
			      showOn: "button",
			      buttonImage: "images/calendar.png",
			      buttonImageOnly: true
			    });
			  });
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
	            	<li class="menuitem"><a href="bank.jsp">Ver Cajas</a></li>
            		<li class="menuitem"><a href="createCashBox.jsp">Crear Caja</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Buscar Cajas para impresión de cierre:</h2>
				<br>
				<fieldset>
					<label for="caja">Caja:</label>
					<select name="txtCashBox" id="txtCashBox">
						<option>Todas</option>
						<option>Principal</option>
						<option>Imagen</option>
						<option>Radiología</option>
						<option>Laboratorio</option>
					</select><br><br> 
					<label for="cajero">Cajero:</label>
					<select name="txtCashier" id="txtCashier">
						<option>Ani Lugo</option>
						<option>Pedro García</option>
						<option>Juan Pérez</option>
						<option>Ana María Luna</option>
					</select><br><br> 
					<label for="cierre">N° de Cierre:</label>
					<input type="text" name="txtNumC" id="txtNumC" style="width:100px;"/> <br><br>
					<label for="fechaApert">Fecha de Apertura:</label>
					<input type="text" name="txtOpenDate" id="txtOpenDate" style="width:150px;"/> <br><br>
					<label for="fechaCierre">Fecha de Cierre:</label>
					<input type="text" name="txtCloseDate" id="txtCloseDate" style="width:150px;"/> <br><br>
				</fieldset>
				<div id="botonera">
					<form action="searchCashBox.jsp">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Consultar" />
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