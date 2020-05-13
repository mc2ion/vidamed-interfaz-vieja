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
	        	<h2>Editar Cuenta por Pagar:</h2>
	        	<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Información Cuenta</a></li>
					    <li><a href="#tabs-2">Información Pago</a></li>
					    <li><a href="#tabs-3">Información Adicional</a></li>
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
								<option value="F">Liquidación</option>
								<option value="F">Nota de Crédito</option>
								<option value="F">Otros</option>
								<option value="F">Reintegros</option>
							</select> <br><br>
							<label for="name">Factura:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="F-7629"/> <br><br>
							<label for="name">Número Control:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="1725778"/> <br><br>
							<label for="name">Proveedor:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Anthony Bernal"/> 
							<a href="CreateSupplierServlet?function=editAccountPayable"> <input type="submit"  class="button"  name="sbmtButton" value="Nuevo..." /></a><br><br>
							<label for="name">Fecha Facturación:</label>
							<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" value="18/07/2013" /> <br><br>
							<label for="name">Fecha Vencimiento:</label>
							<input type="text" name="txtDateIni2" id="txtDateIni2" maxlength="50" size="10" value="20/09/2013" />
						</fieldset>						
						<div id="botonera">
							<form action="ListAccountsServlet" style="display: inline; ">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Editar" />
								</div>
							</form>	
							<form action="ListAccountsServlet#tabs-2" style="display: inline; ">
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
							<label for="name">Retención IVA:</label> 
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="-"/> <br><br>
							<label for="name">Monto a Pagar:</label> 
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Bs. 15000"/>
						</fieldset>						
						<div id="botonera">
							<form action="ListAccountsServlet" style="display: inline; ">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Editar" />
								</div>
							</form>	
							<form action="ListAccountsServlet#tabs-2" style="display: inline; ">
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
								<option value="F" selected="selected">Centro Médico Quirúrgico Vidamed</option>
								<option value="F">Centro Materno del Este</option>
								<option value="F">Servicios Médicos Redmed, C.A.</option>
							</select> <br><br>
							<label for="name">Unidad de Negocio:</label>
							<select name="txtGen" id="txtGen">	
								<option value="-" >Seleccionar</option>
								<option value="F">Hospitalización Vidamed</option>
								<option value="F">Laboratorio Clínico</option>
								<option value="F">Rayos X Vidamed</option>
								<option value="F">Emergencia Vidamed</option>
								<option value="F">Ecosonografía Vidamed</option>
								<option value="F">Consulta Externa Vidamed</option>
								<option value="F" selected="selected">Compras e Inventario</option>
								<option value="F">Administración</option>
							</select> <br><br>
							<label for="name">Clasificación:</label>
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
							<form action="ListAccountsServlet" style="display: inline; ">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Editar" />
								</div>
							</form>	
							<form action="ListAccountsServlet#tabs-2" style="display: inline; ">
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