<%@page import="domain.User"%>
<%@page import="domain.Patient"%>
<%@ page import="java.util.ArrayList" %>
<%@page import="domain.PatientPhoneNumber"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	Patient patient = (Patient)request.getAttribute("patient");
	@SuppressWarnings("unchecked")
	ArrayList<PatientPhoneNumber> phoneNumbers = (ArrayList<PatientPhoneNumber>)request.getAttribute("phoneNumbers");
	String identityCard = patient.getIdentityCard();
	String str = identityCard.substring(0,2);
	String num = identityCard.substring(2);
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Paciente</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript"  src="./js/jquery.leanModal.min.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
		<script type="text/javascript">
		var idUser;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });
			
			$("#addPhone").click(function() {
				if($('#otherPhone1').is(':hidden')) {
					$("#otherPhone1").show();
				}
				if($('#otherPhone1').is(':visible')){
					$(this).hide();						
				}
				  
			});
			
			$("#deletePhone1").click(function() {
				  $("#otherPhone1").hide();
				  $("#addPhone").show();
				  $("#txtPhoneNumber1").val("");
				  $("#txtType1").val("L");
			});
			
			
		});
		
		function loadVars(var1, var2) {
			idUser = var1;
			$('.cliente').text(var2);
			
		};
		
		function setV(f){
			f.elements['userId'].value = idUser;
			return true;
		}
		
		$(document).ready(function() {
			$( ".target" ).change(function() {
			  if( $(this).find(":selected").text() == "Pediátrico"){
				$("#id").text("Cédula de identidad del representante:");
			  }else
				$("#id").text("Cédula de identidad del paciente:");
				
			});
		});
		</script>
		<script type="text/javascript">
			$(function(){
				$.datepicker.setDefaults($.datepicker.regional['es']);
				$('#txtDateIni').datepicker({
					showOn: "button",
					buttonImage: "images/calendar.png",
					buttonImageOnly: true,
					buttonText: "Seleccione una fecha",
					dateFormat:'dd/mm/yy',
					changeMonth: true,
				    changeYear: true,
				    yearRange: "-100:+20"
				});
				$('#txtDateIni2').datepicker({
					showOn: "button",
					buttonImage: "images/calendar.png",
					buttonImageOnly: true,
					buttonText: "Seleccione una fecha",
					dateFormat:'dd/mm/yy',
					changeMonth: true,
				    changeYear: true,
				    yearRange: "-100:+20"
				});
			} );
		</script>
		<script>
			$(function() {    
            	$('#sbmtButton').click(function(event) { 
            		var patternNumber = new RegExp('^\\d+$');
            		var patternEmail = new RegExp('^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$');
            		var patternDate = new RegExp('^[0-3]?[0-9]/[0-1]?[0-9]/[0-9]{4}$');
            		var patternPhoneNumber = new RegExp('^\\d{10}\\d*$');
            		if ($('#txtCedIdNum').val() == '') {
            			 $("#tabs").tabs( "option", "active", 0);
            			alert("El campo 'Cedula' no puede ser dejado en blanco");
            			return;
            		}
            		else if(!$('#txtCedIdNum').val().match(patternNumber)) {
            			$("#tabs").tabs( "option", "active", 0);
            			alert("El campo 'Cedula' sólo debe contener números sin puntos ni espacios en blanco");
            			return;
            		}
            		else if ($('#txtFirstName').val() == '') {
            			$("#tabs").tabs( "option", "active", 0);
            			alert("El campo 'Nombre' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#txtLastName').val() == '') {
            			$("#tabs").tabs( "option", "active", 0);
            			alert("El campo 'Apellido' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#txtDateIni').val() == '') {
            			$("#tabs").tabs( "option", "active", 0);
            			alert("El campo 'Fecha de Nacimiento' no puede ser dejado en blanco");
            			return;
            		}
            		else if (!$('#txtDateIni').val().match(patternDate)) {
            			$("#tabs").tabs( "option", "active", 0);
            			alert("El campo 'Fecha de Nacimiento' debe tener el formato DD/MM/YYYY");
            			return;
            		}
            		else if ($('#txtGen').val() == '') {
            			$("#tabs").tabs( "option", "active", 0);
            			alert("Debe seleccionar un valor para el campo 'Sexo'");
            			return;
            		}
            		else if ($('#txtAddress').val() == '') {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo 'Direccion' no puede ser dejado en blanco");
            			return;
            		}
            		/*else if ($('#txtEmail').val() == '') {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo 'Correo Electrónico' no puede ser dejado en blanco");
            			return;
            		}*/
            		else if ($('#txtEmail').val() != '' && !$('#txtEmail').val().match(patternEmail)) {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El formato del Correo Electrónico colocado es inválido");
            			return;
            		}
            		else if ($('#txtPhoneNumber0').val() == '') {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("Debe colocar al menos un número telefónico");
            			return;
            		}
            		else if (!$('#txtPhoneNumber0').val().match(patternPhoneNumber)) {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo de 'Teléfono' debe contener sólo números sin puntos, ni guiones ni espacios en blanco. Coloque el código de ciudad.");
            			return;
            		}
            		else if ($('#txtPhoneNumber1').val() != '' && !$('#txtPhoneNumber1').val().match(patternPhoneNumber)) {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo de 'Teléfono' debe contener sólo números sin puntos, ni guiones ni espacios en blanco. Coloque el código de ciudad.");
            			return;
            		}            		
            		else {
            			$('#form1').submit();
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
		    	<ul>
	            	<li class="menuitem"><a href="ListPatientsServlet">Ver Pacientes</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Editar Paciente:</h2> <br/>
				<br>
				<form id="form1" name="form1" action="EditPatientServlet" method="post">
				<input type="hidden" id="patientID" name="patientID" value="<%= patient.getPatientID() %>"/>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Datos Personales</a></li>
					    <li><a href="#tabs-2">Datos de Contacto</a></li>
					  
			  		</ul>
					<div id="tabs-1">
  						<br>
					    <fieldset>
					    	<label>Tipo de Paciente:</label>
							<select id="isAdult" name="isAdult" class="target">
								<option value="0" <%= (patient.getIsAdult()==0)?"selected":"" %>>Pedi&aacute;trico</option>
								<option value="1" <%= (patient.getIsAdult()==1)?"selected":"" %>>Adulto</option>
							</select><br /><br />
							<label for="name">Cédula de Identidad:</label>
							<select name="txtCedId" id="txtCedId">
									<option value="V-" <%= (str.equals("V-"))?"selected":"" %>>V</option>
									<option value="E-" <%= (str.equals("E-"))?"selected":"" %>>E</option>
							</select>
							<input type="text" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" value="<%= num %>"/> <br><br>
						  	<label for="name">Nombre:</label>
							<input type="text" name="txtFirstName" id="txtFirstName" maxlength="50" size="5" value="<%= patient.getFirstName() %>"/> <br><br>
							<label for="name">Apellido:</label>
							<input type="text" name="txtLastName" id="txtLastName" maxlength="50" size="5" value="<%= patient.getLastName() %>"/> <br><br>
							<label for="name">Fecha de Nacimiento:</label>
							<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10"  value="<%= patient.getBirthday() %>" /><br><br>
							<label for="name">Sexo:</label>
							<select name="txtGen" id="txtGen">	
								<option value="F" <%= (patient.getGender().equals("F"))?"selected":"" %>>Femenino</option>
								<option value="M" <%= (patient.getGender().equals("M"))?"selected":"" %>>Masculino</option>
							</select><br><br>
				   		 </fieldset>
  					</div>
  					<div id="tabs-2">
  						<br>
					    <fieldset>
							<label for="name">Dirección:</label>
								<textarea name="txtAddress" id="txtAddress" rows="2" cols="50"><%= patient.getAddress() %></textarea> <br><br>
								<label for="name">Correo Electrónico:</label>
								<input type="text" name="txtEmail" id="txtEmail" maxlength="50" size="5" value="<%= patient.getEmail() %>"/> <br><br>
								<label for="name">Teléfono:</label>
								<% for (int i = 0; i<phoneNumbers.size(); i++) {
										PatientPhoneNumber spn = phoneNumbers.get(i);
								%>
								<div id="otherPhone<%= i %>">
									<input type="hidden" id="txtPhoneId<%= i %>" name="txtPhoneId<%= i %>" value="<%= spn.getPhoneNumberID() %>" />
									<select id="txtType<%= i %>" name="txtType<%= i %>">
										<option value="L" <%= spn.getType().equals("L") ? "selected" : "" %>>Local</option>
										<option value="P" <%= spn.getType().equals("P") ? "selected" : "" %>>Particular</option>
										<option value="T" <%= spn.getType().equals("T") ? "selected" : "" %>>Trabajo</option>
									</select>
						  	 		<input type="text" id="txtPhoneNumber<%= i %>" name="txtPhoneNumber<%= i %>" value="<%= spn.getPhoneNumber() %>" style="width: 135px;">
						  	 		<% if (i == 0) { %>
						  	 			<img alt="logo" src="./images/add.png"  id="addPhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" <%= (phoneNumbers.size()<2)?"":"hidden" %> />
						  	 		<%} else { %>
						  	 		<img alt="logo" src="./images/close.png"  id="deletePhone<%= i %>" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
									<% } %>
									<br /><br />
								</div>
								<% } 
								   for (int j = phoneNumbers.size(); j<2; j++) { 
								   		if (j == 0) {
								%>
								<div id="otherPhone<%= j %>">
									<select id="txtType<%= j %>" name="txtType<%= j %>">
										<option value="L" selected>Local</option>
										<option value="P">Particular</option>
										<option value="T">Trabajo</option>
									</select>
						  	 		<input type="text" id="txtPhoneNumber<%= j %>" name="txtPhoneNumber<%= j %>" value="" style="width: 135px;">
						  	 		<img alt="logo" src="./images/add.png"  id="addPhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
									<br /><br />
								</div>
								<% }
								   else { 
								%>
								<div id="otherPhone<%= j %>" style="display:none;">
									<select id="txtType<%= j %>" name="txtType<%= j %>">
										<option value="L" selected>Local</option>
										<option value="P">Particular</option>
										<option value="T">Trabajo</option>
									</select>
						  	 		<input type="text" id="txtPhoneNumber<%= j %>" name="txtPhoneNumber<%= j %>" value="" style="width: 135px;">
						  	 		<img alt="logo" src="./images/close.png"  id="deletePhone<%= j %>" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
									<br /><br />
								</div>
								<% }
								} %>
						 </fieldset>
  					</div>
  			</div>
			<div id="botonera" style="position: absolute; bottom: 30px;text-align:center; width: 100%;">
				<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="button" class="button" id="sbmtButton" name="sbmtButton" value="Modificar" />
				</div>	
				<div id="botonV" style="display: inline;">
						<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
				</div>	
			</div>
		</form>			
		</div>
		</div>
	</body>
</html>