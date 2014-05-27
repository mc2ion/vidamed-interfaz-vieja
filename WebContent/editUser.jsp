<%@page import="domain.User"%>
<%
	User userB = (User) session.getAttribute("user");
	String name = "";
	if (userB != null)
		name = userB.getFirstName() ;
%>
<%@ page import="domain.PermissionModule" %>
<%@ page import="domain.Permission" %>
<%@ page import="domain.User" %>
<%@ page import="domain.UserPermission" %>
<%@ page import="domain.UserPhoneNumber" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%
	User user = (User) request.getAttribute("user");
	@SuppressWarnings("unchecked")
	ArrayList<UserPhoneNumber> userPhoneNumbers = (ArrayList<UserPhoneNumber>) request.getAttribute("userPhoneNumbers");
	@SuppressWarnings("unchecked")
	HashMap<Long, UserPermission> userPermissions = (HashMap<Long, UserPermission>) request.getAttribute("userPermissions");
	@SuppressWarnings("unchecked")
	HashMap<Long, String> userUnits = (HashMap<Long, String>)request.getAttribute("userUnits");
	Iterator<Long> it = (Iterator<Long>)userUnits.keySet().iterator();
	@SuppressWarnings("unchecked")
	ArrayList<PermissionModule> permissionModules = (ArrayList<PermissionModule>)request.getAttribute("permissionModules");
	@SuppressWarnings("unchecked")
	HashMap<Long, ArrayList<Permission>> permissions = (HashMap<Long, ArrayList<Permission>>)request.getAttribute("permissions");
	String[] ci = user.getIdentityCard().split("-");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Usuario</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>		
		<!--JS Datapicker-->
		<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
			
			$(function() {
				$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });
				$("#addPhone").click(function() {
					
					if($('#otherPhone1').is(':hidden')) {
						$("#otherPhone1").show();
					} else {
						if($('#otherPhone2').is(':hidden')) {
							$("#otherPhone2").show();
						} else {
							$("#otherPhone3").show();
						}
					}
					
					if($('#otherPhone1').is(':visible') && $('#otherPhone2').is(':visible') && $('#otherPhone3').is(':visible')){
						$(this).hide();						
					}
					  
				});
				
				$("#deletePhone1").click(function() {
					  $("#otherPhone1").hide();
					  $("#addPhone").show();
					  $("#txtPhoneNumber1").val("");
					  $("#txtType1").val("L");
				});
				
				$("#deletePhone2").click(function() {
					  $("#otherPhone2").hide();
					  $("#addPhone").show();
					  $("#txtPhoneNumber2").val("");
					  $("#txtType2").val("L");
				});
				
				$("#deletePhone3").click(function() {
					  $("#otherPhone3").hide();
					  $("#addPhone").show();
					  $("#txtPhoneNumber3").val("");
					  $("#txtType3").val("L");
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
		    $( "#accordion" ).accordion({
		    	heightStyle: "content"
		    });
		  });
		  </script>
		  <script>
			$(function() {    
            	$('#sbmtButton').click(function(event) { 
            		var patternNumber = new RegExp('^\\d+$');
            		var patternDouble = new RegExp('^[0-9]+(\.[0-9]+)?$');
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
            		else if ($('#txtEmail').val() == '') {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo 'Correo Electrónico' no puede ser dejado en blanco");
            			return;
            		}
            		else if (!$('#txtEmail').val().match(patternEmail)) {
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
            		else if ($('#txtPhoneNumber2').val() != '' && !$('#txtPhoneNumber2').val().match(patternPhoneNumber)) {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo de 'Teléfono' debe contener sólo números sin puntos, ni guiones ni espacios en blanco. Coloque el código de ciudad.");
            			return;
            		}
            		else if ($('#txtPhoneNumber3').val() != '' && !$('#txtPhoneNumber3').val().match(patternPhoneNumber)) {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo de 'Teléfono' debe contener sólo números sin puntos, ni guiones ni espacios en blanco. Coloque el código de ciudad.");
            			return;
            		}
            		else if ($('#txtUnitId').val() == '') {
            			$("#tabs").tabs( "option", "active", 2);
            			alert("Debe seleccionar un valor para el campo 'Unidad'");
            			return;
            		}
            		else if ($('#txtDateIni2').val() == '') {
            			$("#tabs").tabs( "option", "active", 2);
            			alert("El campo 'Fecha de Ingreso' no puede ser dejado en blanco");
            			return;
            		}
            		else if (!$('#txtDateIni2').val().match(patternDate)) {
            			$("#tabs").tabs( "option", "active", 2);
            			alert("El campo 'Fecha de Ingreso' debe tener el formato DD/MM/YYYY");
            			return;
            		}
            		else if ($('#txtPosition').val() == '') {
            			$("#tabs").tabs( "option", "active", 2);
            			alert("El campo 'Cargo' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#txtSalary').val() == '') {
            			$("#tabs").tabs( "option", "active", 2);
            			alert("El campo 'Salario' no puede ser dejado en blanco");
            			return;
            		}
            		else if (!$('#txtSalary').val().match(patternDouble)) {
            			$("#tabs").tabs( "option", "active", 2);
            			alert("El valor del campo 'Salario' debe ser numérico");
            			return;
            		}
            		else if ($('#txtUserName').val() == '') {
            			$("#tabs").tabs( "option", "active", 2);
            			alert("El campo 'Usuario' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#txtUserName').val().length < 5) {
            			$("#tabs").tabs( "option", "active", 2);
            			alert("El campo 'Usuario' debe contener al menos 5 caracteres");
            			return;
            		}
            		else {
            			$('#form1').submit();
            		}
            	});
			});
			
			function checkAll(bx) {
				  var cbs = document.getElementsByTagName('input');
				  for(var i=0; i < cbs.length; i++) {
					if(cbs[i].type == 'checkbox') {
					  cbs[i].checked = bx.checked;
					}
				  }
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
		    	<ul>
	            	<li class="menuitem"><a href="ListUsersServlet">Ver Usuarios</a></li>
            		<li class="menuitem"><a href="CreateUserServlet">Crear Usuario</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Editar Usuario:</h2>
				<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Datos Personales</a></li>
					    <li><a href="#tabs-2">Datos Contacto</a></li>
					    <li><a href="#tabs-3">Datos Usuario</a></li>
					    <li><a href="#tabs-4">Permisología</a></li>
			  		</ul>
			  		<form id="form1" name="form1" action="EditUserServlet">
			  			<input type="hidden" id="userID" name="userID" value="<%= user.getUserID() %>" />
			  			<div id="tabs-1">
							<fieldset>
								<label for="name">Cédula de Identidad:</label>
								<select name="txtCedId" id="txtCedId">
									<option value="V-" <%= ci[0].equals("V") ? "selected" : "" %>>V</option>
									<option value="E-" <%= ci[0].equals("E") ? "selected" : "" %>>E</option>
								</select>
								<input type="number" maxlength="8" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" value="<%= ci[1] %>" title="Debe colocar la cédula del usuario. Colocar sólo números. No colocar puntos ni espacios en blanco." required /> <br><br>
								<label for="name">Nombre:</label>
								<input type="text" name="txtFirstName" id="txtFirstName" maxlength="50" size="5" value="<%= user.getFirstName() %>" title="Debe colocar el nombre del usuario." required /> <br><br>
								<label for="name">Apellido:</label>
								<input type="text" name="txtLastName" id="txtLastName" maxlength="50" size="5" value="<%= user.getLastName() %>" title="Debe colocar el apellido del usuario." required /> <br><br>
								<label for="name">Fecha de Nacimiento:</label>
								<input type="text" pattern="[0-3]?[0-9]/[0-1]?[0-9]/[0-9]{4}" title="Debe colocar la fecha de nacimiento del usuario. Colocar fecha en formato DD/MM/YYYY" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" value="<%= user.getBirthday() %>" required /><br><br>
								<label for="name">Sexo:</label>
								<select name="txtGen" id="txtGen" title="Debe seleccionar el sexo del usuario." required >	
									<option value="" <%= user.getGender().equals("") ? "selected" : "" %>>Seleccionar</option>
									<option value="F" <%= user.getGender().equals("F") ? "selected" : "" %>>Femenino</option>
									<option value="M" <%= user.getGender().equals("M") ? "selected" : "" %>>Masculino</option>
								</select><br><br>
							</fieldset>						
							<br>
			  			</div>
			  			<div id="tabs-2">
							<fieldset>
								<label for="name">Dirección:</label>
								<textarea name="txtAddress" id="txtAddress" rows="2" cols="50" title="Debe colocar la dirección del usuario." required ><%= user.getAddress() %></textarea> <br><br>
								<label for="name">Correo Electrónico:</label>
								<input type="email" name="txtEmail" id="txtEmail" maxlength="50" size="36" value="<%= user.getEmail() %>" title="Debe colocar el correo electrónico del usuario." required /> <br><br>
								<label for="name">Teléfono:</label>
								<% for (int i = 0; i<userPhoneNumbers.size(); i++) {
										UserPhoneNumber upn = userPhoneNumbers.get(i);
								%>
								<div id="otherPhone<%= i %>">
									<input type="hidden" id="txtPhoneId<%= i %>" name="txtPhoneId<%= i %>" value="<%= upn.getPhoneNumberID() %>" />
									<select id="txtType<%= i %>" name="txtType<%= i %>">
										<option value="L" <%= upn.getType().equals("L") ? "selected" : "" %>>Local</option>
										<option value="P" <%= upn.getType().equals("P") ? "selected" : "" %>>Particular</option>
										<option value="T" <%= upn.getType().equals("T") ? "selected" : "" %>>Trabajo</option>
									</select>
						  	 		<% if (i == 0) { %>
						  	 			<input type="text" pattern="\d{10}\d*" maxlength="15" id="txtPhoneNumber<%= i %>" name="txtPhoneNumber<%= i %>" value="<%= upn.getPhoneNumber() %>" style="width: 135px;" title="Debe colocar al menos un número telefónico del usuario. Colocar sólo números. No colocar puntos, ni guiones ni espacios en blanco." required >
						  	 			<img alt="logo" src="./images/add.png"  id="addPhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
						  	 		<% }
						  	 		   else { %>
						  	 		   	<input type="text" pattern="\d{10}\d*" maxlength="15" id="txtPhoneNumber<%= i %>" name="txtPhoneNumber<%= i %>" value="<%= upn.getPhoneNumber() %>" style="width: 135px;">
						  	 			<img alt="logo" src="./images/close.png"  id="deletePhone<%= i %>" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Eliminar telefono" title="Debe colocar sólo números. No colocar puntos, ni guiones ni espacios en blanco." />
									<% } %>
									<br /><br />
								</div>
								<% } 
								   for (int j = userPhoneNumbers.size(); j<4; j++) { 
								   		if (j == 0) {
								%>
								<div id="otherPhone<%= j %>">
									<select id="txtType<%= j %>" name="txtType<%= j %>">
										<option value="L" selected>Local</option>
										<option value="P">Particular</option>
										<option value="T">Trabajo</option>
									</select>
						  	 		<input type="text" pattern="\d{10}\d*" maxlength="15" id="txtPhoneNumber<%= j %>" name="txtPhoneNumber<%= j %>" value="" style="width: 135px;" title="Debe colocar al menos un número telefónico del usuario. Colocar sólo números. No colocar puntos, ni guiones ni espacios en blanco." required >
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
						  	 		<input type="text" pattern="\d{10}\d*" maxlength="15" id="txtPhoneNumber<%= j %>" name="txtPhoneNumber<%= j %>" value="" style="width: 135px;" title="Debe colocar sólo números. No colocar puntos, ni guiones ni espacios en blanco." >
						  	 		<img alt="logo" src="./images/close.png"  id="deletePhone<%= j %>" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Eliminar telefono" />
									<br /><br />
								</div>
								<% }
								} %>
							</fieldset>		
							<br>
			  			</div>			  		
			  			<div id="tabs-3">
			  				<fieldset>
								<label for="name">Unidad:</label>
								<select name="txtUnitId" id="txtUnitId" title="Debe seleccionar la unidad en la que se desempeña el usuario." required >	
									<option value="">Seleccionar</option>
									<% while (it.hasNext()) {
											Long unitID = it.next();
											String unitName = userUnits.get(unitID);
									%>
											<option value="<%= unitID %>" <%= user.getUserUnitID() == unitID ? "selected" : "" %>><%= unitName %></option>
									<% } %>
								</select><br><br>
								<label for="name">Fecha de Ingreso:</label>
								<input type="text" pattern="[0-3]?[0-9]/[0-1]?[0-9]/[0-9]{4}" name="txtDateIni2" id="txtDateIni2" maxlength="50" size="10" value="<%= user.getStartDate() %>" title="Debe seleccionar la fecha de ingreso del usuario. Colocar fecha en formato DD/MM/YYYY" required /><br><br>
								<label for="name">Cargo:</label>
								<input type="text" name="txtPosition" id="txtPosition" maxlength="50" size="5" value="<%= user.getPosition() %>" title="Debe colocar el cargo en el cual se desempeña el usuario." required /> <br><br>
								<label for="name">Salario:</label>
								<input type="text" min="1" name="txtSalary" id="txtSalary" maxlength="6" size="6" value="<%= user.getSalary() %>" title="Debe colocar el salario del usuario." required /> <br><br>
								<label for="name">Usuario:</label>
								<input type="text" name="txtUserName" id="txtUserName" maxlength="50" size="5" value="<%= user.getUserName() %>" title="Debe colocar un ID de usuario." required /> <br><br>
							</fieldset>		
							<br>
			  			</div>			  		
			  			<div id="tabs-4">
							<div style="float: right">
								<input type="checkbox" onclick="checkAll(this)"> Seleccionar Todo
							</div>
			  				<div>
								<% for (int i = 0; i<permissionModules.size(); i++) {
			  							PermissionModule pm = permissionModules.get(i);
			  							ArrayList<Permission> ps = permissions.get(pm.getPermissionModuleID());
			  					%>
			  							<h2 style="font-size:14px;"><%= pm.getName() %>:</h2>
										<table style="margin: 7px 0px; ">
											<tr>
											<% for (int j = 0; j<ps.size(); j++ ) {
											Permission p = ps.get(j);
												if (j % 4 == 0 && j != 0) {
											%>	
											</tr>
											<tr>
											<%  } %>			    					
											<td style="padding: 5px;"><input type="checkbox" id="permissions" name="permissions" value="<%= p.getPermissionID() %>" <%= userPermissions.containsKey(p.getPermissionID()) ? "checked" : "" %>><%= p.getName() %></td>
											<% } %>
											</tr>
										</table>
				    			<% } %>
							</div>
			  				<br>
			  			</div>			  			
			  		</form>	
			  	</div>
			  	<div id="botonera">
								<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="button" class="button" id="sbmtButton" name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
									<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>	
							</div>
			</div>
		</div>
	</body>
</html>