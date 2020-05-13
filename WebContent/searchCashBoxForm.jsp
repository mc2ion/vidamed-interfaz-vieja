<%@page import="domain.CashBox"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<User> cashiers = (ArrayList<User>)request.getAttribute("cashiers");
	@SuppressWarnings("unchecked")
	ArrayList<CashBox> cash = (ArrayList<CashBox>)request.getAttribute("cashBoxes");

%>
<!DOCTYPE HTML>
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
		    $( "#txtOpenDate" ).datepicker({
		      showOn: "button",
		      changeMonth: true,
		      buttonImage: "images/calendar.png",
		      buttonImageOnly: true,
			  dateFormat:'dd/mm/yy',
		      onClose: function( selectedDate ) {
		          $( "#txtCloseDate" ).datepicker( "option", "minDate", selectedDate );
		        }
		    });
		  });
		  
		  $(function() {
			    $( "#txtCloseDate" ).datepicker({
			      showOn: "button",
			      changeMonth: true,
			      buttonImage: "images/calendar.png",
			      buttonImageOnly: true,
				  dateFormat:'dd/mm/yy',
			      onClose: function( selectedDate ) {
			          $( "#txtOpenDate" ).datepicker( "option", "maxDate", selectedDate );
			       }
			    });
			  });
		  </script>	
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListCashBoxesServlet">Ver Cajas</a></li>
            		<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Buscar Cajas para impresión de cierre:</h2>
				<br>
				<form action="SearchCashBoxesServlet" method="post">
					<fieldset>
						<label for="caja">Caja:</label>
						<select name="txtCashBox" id="txtCashBox">
							<option value="">Seleccionar</option>
							<% 
								if (cash != null){
									for (int i=0; i< cash.size(); i++){ 
									CashBox c = cash.get(i);
							%>
							<option value="<%= c.getCashBoxID()%>"><%= c.getName() %></option>
							<% } }else{ %>
								<option value="-">No hay cajas disponibles</option>
							<%
								}
							%>
						</select><br><br> 
						<label for="cajero">Cajero:</label>
						<select name="txtCashier" id="txtCashier">
							<option value="">Seleccionar</option>
							<% if (cashiers != null){ 
								for (int i=0; i< cashiers.size(); i++){ 
								User u = cashiers.get(i);
							%>
							<option value="<%= u.getUserID()%>"><%= u.getFirstName() + " "+ u.getLastName() %></option>
							<% }}else{ %>
								<option value="-">No hay cajeros disponibles</option>
							<%
								}
							%> 
						</select><br><br> 
						<label for="fechaApert">Desde:</label>
						<input type="text" name="txtOpenDate" id="txtOpenDate" style="width:150px;"/> <br><br>
						<label for="fechaCierre">Hasta:</label>
						<input type="text" name="txtCloseDate" id="txtCloseDate" style="width:150px;"/> <br><br>
					</fieldset>
					<div id="botonera">
							<div id="botonP" style="display: inline; margin-right: 30px;">
										<input type="submit"  class="button"  name="sbmtButton" value="Consultar" />
							</div>	
							<div id="botonV" style="display: inline;">
									<a href="./ListCashBoxesServlet" class="button">Regresar</a>		
							</div>	
					</div><br>
					</form>
			</div>
		</div>
	</body>
</html>