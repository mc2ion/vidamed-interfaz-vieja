<%@page import="domain.SupplyArea"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	

	@SuppressWarnings("unchecked")
	ArrayList<SupplyArea> sArea = (ArrayList<SupplyArea>)request.getAttribute("supplyArea");
		
	String adminId 	= (String) request.getAttribute("adminId");
	String patName 	= (String) request.getAttribute("name");
	String sec = (String) request.getAttribute("sec");
	
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
				index = $(this).val();
				if (index != "-"){
					$('.sum-div').show();
					$.ajax({
						type: "GET",
						url: "GetSuppliesServlet",
						data: {category: index },
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
	        	<h2>Agregar Suministro:</h2> <br><br>
	        	<p>Por favor, escoga el área del suministro y haga clic en "Siguiente".</p><br>
	        	<form action="AddPatientSupplyServlet" method="post" >
				<input type="hidden" name="admissionId" value="<%= adminId %>"/>
				<input type="hidden" name="name" value="<%= patName %>"/>
				<input type="hidden" name="sec" value="<%= sec %>"/>
				<fieldset>
	        		<label>Área del suministro: </label>
					<select name="supplyArea" id="supplyArea" class="target" required title="Debe seleccionar un valor en el campo 'Área del Suministro'">	
						<option value=""> Seleccionar </option>
						<% for (int i = 0; i < sArea.size(); i++){ 
						%>
							<option value="<%= sArea.get(i).getSupplyAreaID() %>"><%= sArea.get(i).getName() %></option>
						<% } %>
					</select>
					<br/><br/>
					<p style="display: none;" class="sum-div">
						<label for="pname">Suministro:</label>
						<select name="state" id="state" required title="Debe seleccionar un valor en el campo 'Suministro'">
							<option value="">Seleccionar</option>
						</select><br/><br/>
						<label>Cantidad:</label>
						<input type="number" name="amount" style="width:60px;" required title="El campo 'cantidad' debe ser numérico y no puede ser dejado en blanco" />
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