<%@page import="domain.Admission"%>
<%@page import="domain.BedLocation"%>
<%@page import="domain.PaymentResponsible"%>
<%@page import="domain.Bed"%>
<%@page import="domain.AdmissionReasons"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	//String identityCard = (String) request.getAttribute("txtCedNumber");
	User pat 			= (User) session.getAttribute("pat");
	String estimationId = (String) session.getAttribute("estimationId");
	
	@SuppressWarnings("unchecked")
	ArrayList<AdmissionReasons> ar = (ArrayList<AdmissionReasons>) request.getAttribute("ar");
	
	@SuppressWarnings("unchecked")
	ArrayList<PaymentResponsible> pr = (ArrayList<PaymentResponsible>) request.getAttribute("pr");
	
	@SuppressWarnings("unchecked")
	ArrayList<BedLocation> locations = (ArrayList<BedLocation>) request.getAttribute("locations");
	
	session.removeAttribute("pat");
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Admitir Paciente:</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
		<script type="text/javascript">
		var idUser;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x, .buttonPopUpClose " });	
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
	<script>
			$(function() {    
            	$('#subAdmit').click(function(event) { 
            		if($('#reasonAdmission').val() == '0') {
            			alert("Debe seleccionar el Motivo de la Admisión.");
            			return;
            		}
            		if($('#bedLocationId').val() == '-') {
            			alert("Debe seleccionar una Ubicación.");
            			return;
            		}
            		if($('#bed').val() == '-') {
            			alert("Debe seleccionar una Cama.");
            			return;
            		}
            		$("#admitP").hide();
    				$("#message").show();
            		$('#form1').submit();
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
	            	<li class="menuitem"><a href="ListAdmissionsServlet">Ver Admisiones</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
			 <!-- OJO TODA ADMISION DEBE TENER PRESUPUESTO.. TENER ESO EN CUENTA
			 	COMO RESTRICCION PARA CREAR LA ADMISION
			  -->
        	<div id="content" style="position:absolute;">
        		<div id="admitP">
	        	<h2>Admitir Paciente:</h2>
				<br>
						 <form id="form1" name="form1" action="AdmitPatientServlet" method="post">
						 <input type="hidden" name="estimationId" value="<%= estimationId %>" />
						 	<fieldset>
							   <b>Cédula:</b> <span style="margin-left: 155px;"><%= pat.getIdentityCard() %></span><br/><br/>
							   <% if (pat.getIsAdult() != null) { %>
							   		<b>Tipo: </b> <span style="margin-left: 150px;"><%= (pat.getIsAdult().equals("0")) ? "Pediátrico" : "Adulto"  %></span><br><br/>
							   <% } %>
							   <b>Nombre: </b><span style="margin-left: 150px;"><%= pat.getFirstName() + " " + pat.getLastName() %></span><br><br/>
							   <label> Motivo de la admisión:</label>
							   <select name="reasonAdmission" id="reasonAdmission" >
							   		<option value="0">Seleccionar</option>  
							   		<% if (ar != null){
							   			for (int i=0; i< ar.size(); i++){ %>
							   		<option value="<%= ar.get(i).getId()%>"><%= ar.get(i).getName() %></option>  
							   		<% }} %>
							   </select><br/><br/>			
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
							   
						   	   <label> Número de presupuesto:</label> 
							   <%
								   if (estimationId != null) { %>
									<input type="text" name="estimationId" readonly class="hidden" value="<%= estimationId %>" />
								<% } %>
								<br/><br/>
								 <label> Observaciones:</label>  
								 <textarea name="observations" id="observations" ></textarea>
							   
								<br><br>
							</fieldset>
							<div id="botonV" style="position:relative;">
									<input type="button"  class="button" id="subAdmit"  name="sbmtButton" value="Aceptar" style="margin-left:30%; margin-top: 5px;"/>
									<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" style="margin-left:20px;" />		
							</div>	
				</form>
			</div>
			</div>
			
		</div>
	</body>
</html>