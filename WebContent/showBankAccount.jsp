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
		<title>Ver Cuenta Bancaria</title>
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
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListBanksAccountsServlet">Ver Cuentas</a></li>
	            	<li class="menuitem"><a href="CreateBankAccountServlet">Crear Cuenta</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Cuenta Bancaria:</h2>
				<br>
				<fieldset>
					<label for="name">Tipo de Cuenta:</label> Cuenta de Ahorro <br><br>
					<label for="name">Número de Cuenta:</label> Caja Chica <br><br>
					<label for="name">Banco:</label> Clínica Vidamed <br><br>
					<label for="name">Saldo Disponible:</label> Bs. 1550.00<br><br>
					<label for="name">Saldo Actual:</label> Bs. 1550.00 <br><br>
					<label for="name">Saldo Bloqueado:</label> Bs. 0.00 <br><br>
					<label for="name">Saldo Diferido:</label> Bs. 0.00 <br><br>
				</fieldset>
				<div id="botonera">
					<form action="PrintBankAccountServlet">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" />
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