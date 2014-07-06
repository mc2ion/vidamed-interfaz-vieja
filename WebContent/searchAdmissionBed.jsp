<%@page import="domain.BedLocation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	

	@SuppressWarnings("unchecked")
	ArrayList<BedLocation> locations = (ArrayList<BedLocation>) request.getAttribute("locations");
	
	String identityCard = (String) request.getAttribute("txtCedNumber");
	String bedId 		= (String) request.getAttribute("bedId");
	
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Escoger Cama</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$( ".target" ).change(function() {
				index = $(this).val();
				if (index != "-"){
					$.ajax({
						type: "GET",
						url: "GetBedsServlet",
						data: {locationId: index },
						success: function(data){
							$("#bed").html(data)
						}
					});
					$('#beds').show();
				}else{
					$('#beds').hide();
				}
			});			
		});
		function occupiedBed(){
			bedId = $("#bed").val();
			$.ajax({
				type: "GET",
				url: "SetBedOccupationServlet",
				data: {bedId: bedId },
				success: function(data){
					if (data == "-1"){
						$("#error-bed").show();
						return false;
					}
					$("#bForm").submit();
				}
			});
			
		}
	</script>
	<script type="text/javascript">
	var idUser;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });
	});
	
	function loadVars(var1, var2) {
		idUser = var1;
		$('.cliente').text(var2);
		
	};
	
	function setV(f){
		f.elements['userId'].value = idUser;
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
	    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        </div>        
         <jsp:include page="./menu.jsp" />
		<div id="content">  
			<form action="SearchAdmissionBedsServlet" method="post" id="bForm">
			<input type="hidden" name="txtCedNumber"  value="<%= identityCard  %>" />
			<input type="hidden" name="bedId"  value="<%= bedId %>" />
			<h2>Escoger ubicación de cama:</h2><br>
			<p>Por favor seleccione la ubicación de la cama que desea:</p><br/>
			<fieldset>
				<label>Ubicación:  </label> 
				<select id="bedLocationId" name="bedLocationId" class="target">
					<option value="-" >Seleccionar</option>
					<% for (int i=0; i< locations.size(); i++){
						BedLocation l = locations.get(i);
					%>
						<option value="<%= l.getId() %>"><%= l.getName() %></option>
					<% } %>
				</select><br/><br/>
				<p style="display: none;" id="beds">
				<label for="pname">Cama:</label>
					<select name="bed" id="bed">
						<option value="-">Seleccionar</option>
					</select><br/><br/>
				</p>  
				<p style="display: none; color: red;" id="error-bed">
					Disculpe, la cama que escogió ya fue seleccionada por otro usuario. Por favor, elija una cama diferente.
				</p>  
				</fieldset>
				<div id="botonReg" style="position: absolute; margin-top: 40px; margin-left: 320px;">
					<input type="button" class="button" id="" onClick="return occupiedBed();" value="Aceptar" />
					<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
				</div>
		
			</form>
			<div class="spacer"></div>
        	</div>
       	</div>
		
	</body>
</html>