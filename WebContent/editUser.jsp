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
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	   	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, <%= name %></a></li>
                <li><a href="ListAdmissionDischargesServlet">Altas Admisi�n<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListUsersServlet">Ver Usuarios</a></li>
            		<li class="menuitem"><a href="CreateUserServlet">Crear Usuario</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
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
					    <li><a href="#tabs-4">Permisolog�a</a></li>
			  		</ul>
			  		<form action="EditUserServlet">
			  			<input type="hidden" id="userID" name="userID" value="<%= user.getUserID() %>" />
			  			<div id="tabs-1">
							<fieldset>
								<label for="name">C�dula de Identidad:</label>
								<select name="txtCedId" id="txtCedId">
									<option value="V-" <%= ci[0].equals("V") ? "selected" : "" %>>V</option>
									<option value="E-" <%= ci[0].equals("E") ? "selected" : "" %>>E</option>
								</select>
								<input type="text" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" value="<%= ci[1] %>" /> <br><br>
								<label for="name">Nombre:</label>
								<input type="text" name="txtFirstName" id="txtFirstName" maxlength="50" size="5" value="<%= user.getFirstName() %>"/> <br><br>
								<label for="name">Apellido:</label>
								<input type="text" name="txtLastName" id="txtLastName" maxlength="50" size="5" value="<%= user.getLastName() %>"/> <br><br>
								<label for="name">Fecha de Nacimiento:</label>
								<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" value="<%= user.getBirthday() %>" /><br><br>
								<label for="name">Sexo:</label>
								<select name="txtGen" id="txtGen">	
									<option value="-" <%= user.getGender().equals("-") ? "selected" : "" %>>Seleccionar</option>
									<option value="F" <%= user.getGender().equals("F") ? "selected" : "" %>>Femenino</option>
									<option value="M" <%= user.getGender().equals("M") ? "selected" : "" %>>Masculino</option>
								</select><br><br>
							</fieldset>						
							<div id="botonera">
								<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
									<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>
							</div><br>
			  			</div>
			  			<div id="tabs-2">
							<fieldset>
								<label for="name">Direcci�n:</label>
								<textarea name="txtAddress" id="txtAddress" rows="2" cols="50"><%= user.getAddress() %></textarea> <br><br>
								<label for="name">Correo Electr�nico:</label>
								<input type="text" name="txtEmail" id="txtEmail" maxlength="50" size="5" value="<%= user.getEmail() %>"/> <br><br>
								<label for="name">Tel�fono:</label>
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
						  	 		<input type="text" id="txtPhoneNumber<%= i %>" name="txtPhoneNumber<%= i %>" value="<%= upn.getPhoneNumber() %>" style="width: 135px;">
						  	 		<% if (i == 0) { %>
						  	 		<img alt="logo" src="./images/add.png"  id="addPhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
						  	 		<% }
						  	 		   else { %>
						  	 		<img alt="logo" src="./images/close.png"  id="deletePhone<%= i %>" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
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
							<div id="botonera">
								<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
									<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>
							</div><br>
			  			</div>			  		
			  			<div id="tabs-3">
			  				<fieldset>
								<label for="name">Unidad:</label>
								<select name="txtUnitId" id="txtUnitId">	
									<option value="-">Seleccionar</option>
									<% while (it.hasNext()) {
											Long unitID = it.next();
											String unitName = userUnits.get(unitID);
									%>
											<option value="<%= unitID %>" <%= user.getUserUnitID() == unitID ? "selected" : "" %>><%= unitName %></option>
									<% } %>
								</select><br><br>
								<label for="name">Fecha de Ingreso:</label>
								<input type="text" name="txtDateIni2" id="txtDateIni2" maxlength="50" size="10" value="<%= user.getStartDate() %>" /><br><br>
								<label for="name">Cargo:</label>
								<input type="text" name="txtPosition" id="txtPosition" maxlength="50" size="5" value="<%= user.getPosition() %>"/> <br><br>
								<label for="name">Salario:</label>
								<input type="number" min="1" name="txtSalary" id="txtSalary" maxlength="6" size="6" value="<%= user.getSalary() %>" /> <br><br>
								<label for="name">Usuario:</label>
								<input type="text" name="txtUserName" id="txtUserName" maxlength="50" size="5" value="<%= user.getUserName() %>"/> <br><br>
							</fieldset>		
							<div id="botonera">
								<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
									<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>
							</div><br>
			  			</div>			  		
			  			<div id="tabs-4">
			  				<div id="accordion">
								<% for (int i = 0; i<permissionModules.size(); i++) {
			  							PermissionModule pm = permissionModules.get(i);
			  							ArrayList<Permission> ps = permissions.get(pm.getPermissionModuleID());
			  					%>
			  							<h3><%= pm.getName() %></h3>
				  						<div>
				    						<table class="table-simple">
				    							<tr>
				    								<% for (int j = 0; j<ps.size(); j++ ) {
				    									Permission p = ps.get(j);
				    									if (j % 4 == 0 && j != 0) {
				    								%>	
				    										</tr><tr>
				    								<%  } %>			    					
				    										<td><input type="checkbox" id="permissions" name="permissions" value="<%= p.getPermissionID() %>" <%= userPermissions.containsKey(p.getPermissionID()) ? "checked" : "" %>><%= p.getName() %></td>
				    								<% } %>
				    							</tr>
				    						</table>
				  						</div>
				  				<% } %>
							</div>
			  				<div id="botonera">
								<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
									<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>	
							</div><br>
			  			</div>
			  		</form>	
			  	</div>
			</div>
		</div>
	</body>
</html>