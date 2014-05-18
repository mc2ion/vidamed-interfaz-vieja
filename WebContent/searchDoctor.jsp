<%@page import="domain.Unit"%>
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
		
	String admissionId 	= (String) request.getAttribute("admissionId");
	String docName 		= (String) request.getAttribute("docName");
	String function		= (String) request.getAttribute("function");
	
	System.out.println(admissionId);
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
				if (index != "-"){
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
		    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Seleccionar Especialista:</h2><br>
				<div style="color:red">IMPORTANTE: Al hacer click en "Aceptar" cambiará definitivamente el especialista del paciente.</div><br/><br/>
				<p>Por favor, escoga la unidad correspondiente y el médico correspondiente.</p><br>
	        	<form action="SearchDoctorServlet" method="post" >
				<input type="hidden" name="adminId" value="<%= admissionId %>">
				<input type="hidden" name="function" value="<%= function %>">
				<fieldset>
	        		<label>Unidad: </label>
					<select name="unitId" id="unitId" class="target">	
						<option value="-"> Seleccionar </option>
						<% for (int i = 0; i < sArea.size(); i++){ 
						%>
							<option value="<%= sArea.get(i).getUnitID() %>"><%= sArea.get(i).getName() %></option>
						<% } %>
					</select>
					<br/><br/>
					<p style="display: none;" class="sum-div">
						<label for="pname">Especialista:</label>
						<select name="state" id="state">
							<option value="-">Seleccionar</option>
						</select><br/><br/>
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