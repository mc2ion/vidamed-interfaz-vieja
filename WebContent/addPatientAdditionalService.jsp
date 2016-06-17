<%@page import="domain.AdditionalService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
		
	@SuppressWarnings("unchecked")
	ArrayList<AdditionalService> services = (ArrayList<AdditionalService>)request.getAttribute("services");
		
	String adminId 	= (String) request.getAttribute("adminId");
	String patName 	= (String) request.getAttribute("name");
	
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Agregar Servicio Adicional</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>	
		<script type="text/javascript" src="./js/functions.js"></script>
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
        	<div id="content" style="position:absolute;">	
	        	<h2>Agregar Servicio Adicional:</h2> <br><br>
	        	<p>Por favor, escoja el servicio e indique el monto correspondiente.</p><br>
	        	<form action="AddPatientAdditionalServiceServlet" method="post" >
				<input type="hidden" name="admissionId" value="<%= adminId %>"/>
				<input type="hidden" name="name" value="<%= patName %>"/>
				<fieldset>
					<label>Tipo de Servicio: </label>
					<select name="serviceId" id="serviceId" required title="Debe seleccionar un valor en el campo 'Tipo de Servicio'">
						<option value=""> Seleccionar </option>
						<% for (int i = 0; i < services.size(); i++){ 
						%>
							<option value="<%= services.get(i).getAdditionalServiceID() %>"><%= services.get(i).getBussinessRuleMicroName() + " - " + services.get(i).getAdditionalServiceName() %></option>
						<% } %>
					</select>
					<br/><br/>
					<label>Monto:</label>
					<input type="text" pattern="^[0-9]+(\.[0-9]+)?$" name="amount" style="width:60px;" required title="El campo 'Monto' debe ser numérico y no puede ser dejado en blanco" />
					<br/><br/>
				</fieldset>
				<br/>
				 <div id="botonera" style="margin-top: -3px;">
					<div id="botonP">
							<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
							<input type="button" style="margin-left: 15px;" class="button" value="Cancelar" onClick="javascript:history.back();" />		
					</div>	
				</div>
				</form>
			</div>
		</div>
	</body>
</html>