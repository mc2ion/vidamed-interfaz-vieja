<%@page import="domain.User"%>
<%@page import="domain.ExchangeRate"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	ExchangeRate er = (ExchangeRate) request.getAttribute("er");
	String subtitle = "Editar tasa:";
	String button = "Modificar";
	
	if(er.getExchangeRateID() == null) {
		subtitle = "Agregar tasa:";
		button = "Agregar";
	}
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Tasa de Cambio</title>
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
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Tasa de Cambio</h2>
				<br><br>
				<div style="
				    background: rgba(0, 153, 255, 0.2);
				    height: 150px;
				    border-radius: 5px;
				    display: flex;
				    align-items: center;
				    flex-direction: column;
				    padding: 0 20px;
				    justify-content: center;
				">
					<% if(er.getExchangeRateID() == null) { %>
				    <div style="
				    color: rgb(67, 70, 70);
				    font-size: 1.25em;
				    font-weight: bold;
				">Aún no se ha agregado una tasa de cambio vigente.</div>
				<% } else { %>
				    <div style="
				    color: rgba(67, 70, 70, 0.75);
				    font-size: 1.125em;
				    font-weight: bold;
				    margin-right: 0;
				    ">Vigente desde 12/09/2020 08:13 AM</div>
				    <div>
				    	<div style="
						    font-size: 3em;
						    color: rgba(67, 70, 70, 0.75);
						    text-align: center;
						    font-weight: bold;
						">370.032,61</div>
						<div style="
						    color: rgba(67, 70, 70, 0.75);
						    font-size: 1.125em;
						    font-weight: bold;
						">Actualizado por Sql Master</div>
				    </div>
			    <% } %>
		    	</div>
				<br><br>
				<h3><%= subtitle %></h3>
				<br><br>
				<form action="AddExchangeRateServlet">
				<fieldset>
					<label for="name">Monto en bolívares:</label>
					<input type="number" name="txtValue" id="txtValue" maxlength="50" size="5" title="Debe colocar el monto de la tasa de cambio." required /> <br><br>
				</fieldset>
				<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="<%= button %>" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
				</div><br>
				</form>
			</div>
		</div>
	</body>
</html>