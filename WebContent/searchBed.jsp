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
	
	String admissionId = (String) request.getAttribute("admissionId");
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
			
			function getUrlVars() {
			    var vars = {};
			    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
			        vars[key] = value;
			    });
			    return vars;
			}

			var first = getUrlVars()["function"];
			first = first.replace(/\+/g, ' ');
			if (first != null){
				if (first.indexOf("Emergency") > 0){
					$("#emergencies").attr('class', 'active');
					if (first == "editEmergency")
						$("#form").attr('action', 'EditEmergencyServlet');
				}
				else if (first.indexOf("Hospitalization") > 0){
					$("#hospitalization").attr('class', 'active');
					if (first == "editHospitalization")
						$("#form").attr('action', 'EditHospitalizationServlet');
					
				}
				else if (first.indexOf("Patient") > 0){
					$("#admission").attr('class', 'active');
					if (first == "admitPatient")
						$("#form").attr('action', 'AdmitPatientServlet');
					
				}
			}
			
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
			<form action="SearchBedsServlet" method="post">
			<input type="hidden" name="admissionId" value="<%= admissionId %>">
				
			<h2>Escoger ubicación de cama:</h2><br>
			<p>Por favor seleccione la ubicación de la cama que desea:</p><br>
			<fieldset>
				<label>Ubicación:  </label> 
				<select id="bedLocationId" name="bedLocationId" class="target">
					<option value="-" >Seleccionar</option>
					<% for (int i=0; i< locations.size(); i++){
						BedLocation l = locations.get(i);
					%>
						<option value="<%= l.getId() %>" ><%= l.getName() %></option>
					<% } %>
				</select><br/><br/>
				<p style="display: none;" id="beds">
				<label for="pname">Cama:</label>
					<select name="bed" id="bed">
						<option value="-">Seleccionar</option>
					</select><br/><br/>
				</p>  
				</fieldset>
				<div id="botonReg" style="position: absolute; margin-top: 40px; margin-left: 320px;">
					<input type="submit" class="button" value="Aceptar" />
					<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />
				</div>
		
			</form>
			<div class="spacer"></div>
        	</div>
       	</div>
		
	</body>
</html>