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
		<title>Editar Cuenta por Cobrar</title>
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
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListAccountsServlet">Ver Cuentas</a></li>
	            </ul>
	           <div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Editar Cuenta por Cobrar:</h2>
	        	<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Informaci�n Cuenta</a></li>
					    <li><a href="#tabs-2">Informaci�n Adicional</a></li>
			  		</ul>
			  		<div id="tabs-1">
						<fieldset>
							<label for="name">Factura:</label>
							<input type="text" name="txtFact" id="txtFact" maxlength="50" size="5" value="F-1001"/> <br><br>
							<label for="name">N�mero Control:</label>
							<input type="text" name="txtControl" id="txtControl" maxlength="50" size="5" value="1726289"/> <br><br>
							<label for="name">Responsable Pago:</label>
							<input type="text" name="txtInsurance" id="txtInsurance" maxlength="50" size="5" value="Multinacional de Seguros, C.A"/>
							<a href="CreateInsuranceServlet"><input type="submit"  class="button"  name="sbmtButton" value="Nuevo..." /></a><br><br>
							<label for="name">Monto a Cobrar:</label>
							<input type="text" name="txtMount" id="txtMount" maxlength="50" size="5" value="Bs. 13392,85 "/> <br><br>
							<label for="name">IVA:</label>
							<input type="text" name="txtIva" id="txtIva" maxlength="50" size="5" value="Bs. 1607,15"/> <br><br>
							<label for="name">Fecha Vencimiento:</label>
							<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" value="20/08/2013" />
						</fieldset>						
						<div id="botonera">
							<form action="ListAccountsServlet" style="display: inline; ">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Editar" />
								</div>
							</form>	
							<form action="ListAccountsServlet#tabs-1" style="display: inline; ">
								<div id="botonV" style="display: inline; margin-right: 30px;" >
										<input type="submit" class="button" value="Regresar" />		
								</div>
							</form>	
						</div><br>
			  		</div>
			  		<div id="tabs-2">
						<fieldset>
							<label for="name">Empresa:</label>
							<select name="txtCompany" id="txtCompany">	
								<option value="-" >Seleccionar</option>
								<option value="F" selected="selected" >Centro M�dico Quir�rgico Vidamed</option>
								<option value="F">Centro Materno del Este</option>
								<option value="F">Servicios M�dicos Redmed, C.A.</option>
							</select> <br><br>
							<label for="name">Unidad de Negocio:</label>
							<select name="txtUniNeg" id="txtUniNeg">	
								<option value="-" >Seleccionar</option>
								<option value="F">Hospitalizaci�n Vidamed</option>
								<option value="F">Laboratorio Cl�nico</option>
								<option value="F">Rayos X Vidamed</option>
								<option value="F" selected="selected" >Emergencia Vidamed</option>
								<option value="F">Ecosonograf�a Vidamed</option>
								<option value="F">Consulta Externa Vidamed</option>
								<option value="F">Compras e Inventario</option>
								<option value="F">Administraci�n</option>
							</select> <br><br>
							<label for="name">Clasificaci�n:</label>
							<input type="text" name="txtClas" id="txtClas" maxlength="50" size="5"/> <br><br>
							<label for="name">Tipo Responsable:</label>
							<select name="txtTypeInsurance" id="txtTypeInsurance">	
								<option value="-" >Seleccionar</option>
								<option value="F" selected="selected" >Empresa</option>
								<option value="F">Cliente</option>
								<option value="F">Empleados</option>
								<option value="F">Proveedor</option>
								<option value="F">Cliente Venta</option>
							</select> <br><br>
							<label for="name">Beneficiario Factura:</label>
							<input type="text" name="txtBenf" id="txtBenf" maxlength="50" size="5" value="Centro Quir�rgico Vidamed C.A"/> <br><br>
							<label for="name">Notas de la Cuenta:</label>
							<textarea name="txtNotes" id="txtNotes" rows="2" cols="50"></textarea>
						</fieldset>		
						<div id="botonera">
							<form action="ListAccountsServlet" style="display: inline; ">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Editar" />
								</div>
							</form>	
							<form action="ListAccountsServlet#tabs-1" style="display: inline; ">
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