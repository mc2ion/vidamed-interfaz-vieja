<%@page import="domain.User"%>
<%@page import="domain.ExchangeRate"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	String info_text = "";
	String info = (String) session.getAttribute("info");
	if (info != null ){
		info_text = info;
	}
	session.removeAttribute("info");
	
	ExchangeRate er = (ExchangeRate) request.getAttribute("er");
	String subtitle = "Editar tasa:";
	String button = "Modificar";
	String modalTitle = "Editar Tasa";
	String question = "¿Estás seguro que deseas editar el valor de la tasa de cambio?";
	
	if(er.getExchangeRateID() == null) {
		subtitle = "Agregar tasa:";
		button = "Agregar";
		modalTitle = "Agregar Tasa";
		question = "¿Estás seguro que deseas agregar una tasa de cambio al sistema?";
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
		<script type="text/javascript">
		var value;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
		});
		
		function loadVars() {
			var $myForm = $('#addER');

			if(! $myForm[0].checkValidity()) {
			  // If the form is invalid, submit it. The form won't actually submit;
			  // this will just cause the browser to display the native HTML5 error messages.
				$('<input type="submit">').hide().appendTo($myForm).click().remove();
			} else {
				value = $("#txtValue").val();
				$('#trigger').click();	
			}
		};
		
		function setV(f){
			f.elements['value'].value = value;
			return true;
		}
		</script>
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
				<br>
				<div class="info-text"><%= info_text %></div>
				<br>
				<br>
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
				    ">Vigente desde <%= er.getCreatedDate() %></div>
				    <div>
				    	<div style="
						    font-size: 3em;
						    color: rgba(67, 70, 70, 0.75);
						    text-align: center;
						    font-weight: bold;
						"><%= er.getValue() %></div>
						<div style="
						    color: rgba(67, 70, 70, 0.75);
						    font-size: 1.125em;
						    font-weight: bold;
						">Actualizado por <%= er.getCreatedUserName() %></div>
				    </div>
			    <% } %>
		    	</div>
				<br><br>
				<h3><%= subtitle %></h3>
				<br><br>
				<form id="addER">
					<fieldset>
						<label for="name">Monto en bolívares:</label>
						<input type="number" name="txtValue" id="txtValue" maxlength="50" size="5" title="Debe colocar el monto de la tasa de cambio." step="0.01" required /> <br><br>
					</fieldset>
					<div id="botonera">	
							<a id="trigger" rel="leanModal" href="#deleteUnit" style="visibility: hidden;"></a> 	
							<a id="botonP" class="button" style="display: inline; margin-right: 30px;"
								onclick="return loadVars();">
								<%= button %>
							</a> 
							<div id="botonV" style="display: inline;">
									<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
							</div>	
					</div><br>
				</form>
			</div>
		</div>
		<div id="deleteUnit">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" ><%= modalTitle %></h3>
				<br><br>
				<span><%= question %></span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="AddExchangeRateServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="value" class="good_input" name="value"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>