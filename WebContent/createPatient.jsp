<%
	String cedId  		= (String) request.getAttribute("cedId");
	String cedNum 		= (String) request.getAttribute("cedNum");
	String patientType  = (String) request.getAttribute("patientType");
	String function	    = (String) request.getAttribute("function");
	
	String mensaje = "Una vez creado el paciente, se continuará con la creación del presupuesto.";
	
	String cedNumTxt = "";
	if (cedNum != null)
		cedNumTxt = cedNum;
		
	System.out.println("patientType " + patientType);
%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Paciente</title>
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
	            	<li class="menuitem"><a href="ListAdmissionsServlet">Ver Admisiones</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Crear Paciente:</h2> <br/>
				<p style='font-style: italic'>** <%= mensaje %> </p>
				<br>
				<form id="form1" name="form1" action="CreatePatientServlet" method="post">
				<input type="hidden" name="function" value="<%= function %>"/>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Datos Personales</a></li>
					    <li><a href="#tabs-2">Datos de Contacto</a></li>
					  
			  		</ul>
					<input type="hidden" name="function"  value="<%= function %>" />
					<div id="tabs-1">
  						<br>
					    <fieldset>
					    	<label>Tipo de Paciente:</label>
					    	<%
								String aSelected = "";
								if (patientType != null){
									if (patientType.equals("1"))
										aSelected = "selected";
								}
									
							%>
							<select id="isAdult" name="isAdult" class="target">
								<option value="0" >Pedi&aacute;trico</option>
								<option value="1" <%= aSelected %>>Adulto</option>
							</select><br /><br />
							<label for="name">Cédula de Identidad:</label>
							<%
								String vSelected = "";
								String eSelected = "";
								if (cedId != null){
									if (cedId.equals("V-"))
										vSelected = "selected";
									else
										eSelected = "selected";
								}
									
							%>
							<select name="txtCedId" id="txtCedId">
									<option value="V-" <%= vSelected %>>V</option>
									<option value="E-" <%= eSelected %>>E</option>
							</select>
							<input type="text" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" value="<%= cedNumTxt %>"/> <br><br>
						  	<label for="name">Nombre:</label>
							<input type="text" name="txtFirstName" id="txtFirstName" maxlength="50" size="5"/> <br><br>
							<label for="name">Apellido:</label>
							<input type="text" name="txtLastName" id="txtLastName" maxlength="50" size="5"/> <br><br>
							<label for="name">Fecha de Nacimiento:</label>
							<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" /><br><br>
							<label for="name">Sexo:</label>
							<select name="txtGen" id="txtGen">	
								<option value="" selected="selected">Seleccionar</option>
								<option value="F">Femenino</option>
								<option value="M" >Masculino</option>
							</select><br><br>
				   		 </fieldset>
  					</div>
  					<div id="tabs-2">
  						<br>
					    <fieldset>
							<label for="name">Dirección:</label>
								<textarea name="txtAddress" id="txtAddress" rows="2" cols="50"></textarea> <br><br>
								<label for="name">Correo Electrónico:</label>
								<input type="text" name="txtEmail" id="txtEmail" maxlength="50" size="5"/> <br><br>
								<label for="name">Teléfono:</label>
								<div >
									<select id="txtType0" name="txtType0">
										<option value="L" >Local</option>
										<option value="P" >Particular</option>
										<option value="T" >Trabajo</option>
									</select>
						  	 		<input type="text" id="txtPhoneNumber0" name="txtPhoneNumber0" value="" style="width: 135px;">
						  	 		<img alt="logo" src="./images/add.png"  id="addPhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
									<br /><br />
								</div>
								<div id="otherPhone1" style="display:none;">
									<select id="txtType1" name="txtType1">
										<option value="L" >Local</option>
										<option value="P" >Particular</option>
										<option value="T" >Trabajo</option>
									</select>
									<input type="text" id="txtPhoneNumber1" name="txtPhoneNumber1" value="" style="width: 135px;">
									<img alt="logo" src="./images/close.png"  id="deletePhone1" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
						 			<br /><br />
						 		</div>
						 </fieldset>
  					</div>
  			</div>
			<div id="botonera" style="position: absolute; bottom: 30px;text-align:center; width: 100%;">
				<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="button" class="button" id="sbmtButton" name="sbmtButton" value="Agregar" />
				</div>	
				<div id="botonV" style="display: inline;">
						<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
				</div>	
			</div>
		</form>
			
		</div>
		</div>
		<div id="refreshUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Actualizar Presupuesto</h3>
				<br><br>
				<span>¿Desea actualizar fecha y costos del presupuesto seleccionado? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListEstimationsServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>