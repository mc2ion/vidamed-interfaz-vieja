<%@page import="domain.Service"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	

	@SuppressWarnings("unchecked")
	ArrayList<Service> services = (ArrayList<Service>)request.getAttribute("services");
		
	String servId 	= (String) request.getAttribute("servId");
	String adminId 	= (String) request.getAttribute("adminId");
	String patName 	= (String) request.getAttribute("name");
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Agregar servicio</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>	
		<script type="text/javascript" src="./js/functions.js"></script>
		<script>
		$( document ).ready(function() {
			$( ".target" ).change(function() {
				if ($(this).val() != "-"){
					$('.file-div').show();
				}
				else{
					$('.file-div').hide();
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
		    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Agregar Servicio:</h2> <br><br>
	        	<p>Escoja el servicio que desee agregar</p><br>
	        	<form action="AddPatientServiceServlet" method="post" enctype="multipart/form-data" >
				<input type="hidden" name="admissionId" value="<%= adminId %>"/>
				<input type="hidden" name="servId" value="<%= servId %>"/>
				<input type="hidden" name="name" value="<%= patName %>"/>
				<fieldset>
	        		<label>Servicio: </label>
					<select name="service" class="target" required title="Debe seleccionar un valor para el campo 'Servicio'">	
						<option value=""> Seleccionar </option>
						<% for (int i = 0; i < services.size(); i++){ 
						%>
							<option value="<%= services.get(i).getServiceID() %>"><%= services.get(i).getName() %></option>
						<% } %>
					</select><br/><br/>
					<div class="file-div" style="display:none">
						<label>Cargar archivo:</label>
						<input type="file" name="file"/>
					</div>
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