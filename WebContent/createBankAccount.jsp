<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Cuenta</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
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
	            	<li class="menuitem"><a href="bankaccounts.jsp">Ver Cuentas</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Crear Cuenta:</h2>
				<br>
				<fieldset>
					<label for="name">Tipo de Cuenta:</label>
					<select name="txtCedId" id="txtCedId">	
						<option value="-" selected="selected">Seleccionar</option>
						<option value="V-">Cuenta de Ahorro</option>
						<option value="E-">Recibo de Pago</option>
						<option value="V-">Cuenta Corriente</option>
						<option value="E-">Chequera</option>
						<option value="V-">Cuenta Saldo Fijo</option>
						<option value="E-">Pagar�</option>
						<option value="E-">Cuenta Efectivo</option>
					</select> <br><br>
					<label for="name">N�mero de Cuenta:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
					<label for="name">Banco:</label>
					<select name="txtCedId" id="txtCedId">	
						<option value="-" selected="selected">Seleccionar</option>
						<option value="V-">Cl�nica Vidamed</option>
						<option value="E-">ABN-AMRO Bank</option>
						<option value="V-">Banesco</option>
						<option value="E-">Banfoandes</option>
						<option value="V-">Bol�var</option>
						<option value="E-">Banco Canarias de Venezuela</option>
						<option value="E-">Banco Caracas</option>
					</select> <br><br>
					<label for="name">Saldo Disponible:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
					<label for="name">Saldo Actual:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
					<label for="name">Saldo Bloqueado:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
					<label for="name">Saldo Diferido:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
				</fieldset>
				<div id="botonera">
					<form action="bankaccounts.jsp">
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