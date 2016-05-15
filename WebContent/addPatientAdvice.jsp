<%@page import="domain.Unit"%>
<%@page import="domain.MedicalAdviceType"%>
<%@page import="sun.management.counter.Units"%>
<%@page import="domain.SupplyArea"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	

	@SuppressWarnings("unchecked")
	ArrayList<Unit> sArea = (ArrayList<Unit>)request.getAttribute("units");
	
	@SuppressWarnings("unchecked")
	ArrayList<MedicalAdviceType> types = (ArrayList<MedicalAdviceType>)request.getAttribute("types");
		
	String adminId 	= (String) request.getAttribute("adminId");
	String patName 	= (String) request.getAttribute("name");
	
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Agregar Consulta</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>	
		<script type="text/javascript" src="./js/functions.js"></script>
		<script>
		$( document ).ready(function() {
			$( ".target" ).change(function() {
				index = $(this).val();
				if (index != ""){
					$('.sum-div').show();
					$.ajax({
						type: "GET",
						url: "GetSpecialistServlet",
						data: {unit: index },
						success: function(data){
							$("#state").html(data)
						}
					});
				}else{
					$('.sum-div').hide();
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
		    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Agregar Servicio:</h2> <br><br>
	        	<p>Por favor, escoja el servicio, la unidad y el médico correspondiente.</p><br>
	        	<form action="AddPatientMedicalAdviceServlet" method="post" >
				<input type="hidden" name="admissionId" value="<%= adminId %>"/>
				<input type="hidden" name="name" value="<%= patName %>"/>
				<fieldset>
					<label>Tipo de Servicio: </label>
					<select name="typeId" id="typeId" required title="Debe seleccionar un valor en el campo 'Tipo de Servicio'">
						<option value=""> Seleccionar </option>
						<% for (int i = 0; i < types.size(); i++){ 
						%>
							<option value="<%= types.get(i).getMedicalAdviceTypeID() %>"><%= types.get(i).getName() %></option>
						<% } %>
					</select>
					<br/><br/>
	        		<label>Unidad: </label>
					<select name="unitId" id="unitId" class="target" required title="Debe seleccionar un valor en el campo 'Unidad'">	
						<option value=""> Seleccionar </option>
						<% for (int i = 0; i < sArea.size(); i++){ 
						%>
							<option value="<%= sArea.get(i).getUnitID() %>"><%= sArea.get(i).getName() %></option>
						<% } %>
					</select>
					<br/><br/>
					<p style="display: none;" class="sum-div">
						<label for="pname">Especialista:</label>
						<select name="state" id="state" required title="Debe seleccionar un valor en el campo 'Especialista'">
							<option value="">Seleccionar</option>
						</select><br/><br/>
						<label>Honorario Médico:</label>
						<input type="text" pattern="^[0-9]+(\.[0-9]+)?$" name="amount" style="width:60px;" required title="El campo 'Honorario Médico' debe ser numérico y no puede ser dejado en blanco" />
					</p>   
					
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