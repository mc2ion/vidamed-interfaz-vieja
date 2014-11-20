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
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListBanksAccountsServlet">Ver Cuentas</a></li>
	            	<li class="menuitem"><a href="ListAccountMovementsServlet">Ver Movimientos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
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
					<form action="ListAccountMovementsServlet">
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