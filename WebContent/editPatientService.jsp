<%@page import="domain.PatientService"%>
<%@page import="domain.Service"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;

	PatientService pSupply = (PatientService) request.getAttribute("pSupply");
		
	String servId 	= (String) request.getAttribute("servId");
	String adminId 	= (String) request.getAttribute("adminId");
	String patName 	= (String) request.getAttribute("name");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar servicio</title>
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
	        	<h2>Editar Servicio:</h2> <br><br>
	        	<form action="EditPatientServiceServlet" method="post" enctype="multipart/form-data" >
				<input type="hidden" name="admissionId" value="<%= adminId %>"/>
				<input type="hidden" name="servId" value="<%= servId %>"/>
				<input type="hidden" name="name" value="<%= patName %>"/>
				<input type="hidden" name="spId" value="<%= pSupply.getServicePatientID() %>"/>
				<input type="hidden" name="oldFile" value="<%= pSupply.getAssociatedFile() %>"/>
				<fieldset>
	        		<label>Servicio: </label>
					<span><%= pSupply.getServiceName() %></span><br/><br/>
					<label>Cargar archivo:</label>
					<% if (pSupply.getAssociatedFile() == null || pSupply.getAssociatedFile().equals("null") ){ %>
					<span>No hay archivo cargado.</span>
					<% }else{ %>
					<span><%= pSupply.getAssociatedFile()%></span>
					<% } %>
					<input type="file" name="file"/>
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