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
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListBanksAccountsServlet">Ver Cuentas</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
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
						<option value="E-">Pagaré</option>
						<option value="E-">Cuenta Efectivo</option>
					</select> <br><br>
					<label for="name">Número de Cuenta:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
					<label for="name">Banco:</label>
					<select name="txtCedId" id="txtCedId">	
						<option value="-" selected="selected">Seleccionar</option>
						<option value="V-">Clínica Vidamed</option>
						<option value="E-">ABN-AMRO Bank</option>
						<option value="V-">Banesco</option>
						<option value="E-">Banfoandes</option>
						<option value="V-">Bolívar</option>
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
					<form action="ListBanksAccountsServlet">
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