<%@page import="domain.PatientSupply"%>
<%@page import="domain.Service"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	PatientSupply pSupply = (PatientSupply) request.getAttribute("pSupply");
	
	
	String adminId 	= (String) request.getAttribute("adminId");
	String patName 	= (String) request.getAttribute("name");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar suministro</title>
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
	        	<h2>Editar Suministro:</h2> <br><br>
	        	<form action="EditPatientSupplyServlet" method="post">
				<input type="hidden" name="admissionId" value="<%= adminId %>"/>
				<input type="hidden" name="name" value="<%= patName %>"/>
				<input type="hidden" name="spId" value="<%= pSupply.getPatientSupplyID() %>"/>
				<fieldset>
	        		<label>Suministro: </label>
					<span><%= pSupply.getSupplyName() %></span><br/><br/>
					<label>Presentación: </label>
					<span><%= (pSupply.getSupplyForm() != null) ? pSupply.getSupplyForm(): "-" %></span><br/><br/>
					<label>Cantidad: </label>
					<input type="text" value="<%= pSupply.getAmount()%>" name="amount" style="width:60px;" required title="El campo 'Cantidad' debe ser numérico y no puede ser dejado en blanco" /><br/><br/>
					
				</fieldset>
				<br/>
				 <div id="botonera" style="margin-top: -3px;">
					<div id="botonP">
							<input type="submit"  class="button"  name="sbmtButton" value="Aceptar" />
							<input type="button" style="margin-left: 15px;" class="button" value="Cancelar" onClick="javascript:history.back();" />		
					</div>	
				</div>
				</form>
			</div>
		</div>
	</body>
</html>