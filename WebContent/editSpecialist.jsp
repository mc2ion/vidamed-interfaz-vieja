<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%@ page import="domain.Specialist" %>
<%@ page import="domain.SpecialistPhoneNumber" %>
<%@ page import="domain.SpecialistUnit" %>
<%@ page import="domain.Unit" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
Specialist spec = (Specialist)request.getAttribute("specialist");
@SuppressWarnings("unchecked")
ArrayList<SpecialistPhoneNumber> specialistPhoneNumbers = (ArrayList<SpecialistPhoneNumber>) request.getAttribute("specialistPhoneNumbers");
@SuppressWarnings("unchecked")
HashMap<Long, SpecialistUnit> specialistUnits = (HashMap<Long, SpecialistUnit>) request.getAttribute("specialistUnits");
@SuppressWarnings("unchecked")
ArrayList<Unit> units = (ArrayList<Unit>) request.getAttribute("units");
String[] ci = spec.getIdentityCard().split("-");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Especialista</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>		
		<!--JS Datapicker-->
		<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<!--JS Buscador de Multiselect-->
		<script type="text/javascript" src="./js/jquery.quicksearch.js"></script>
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
			
			$(function() {
				$('#my-select').multiSelect({
					  selectableHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='Buscar' style='width:100%'>",
					  selectionHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='Buscar' style='width:100%'>",
					  afterInit: function(ms){
					    var that = this,
					        $selectableSearch = that.$selectableUl.prev(),
					        $selectionSearch = that.$selectionUl.prev(),
					        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
					        selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';

					    that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
					    .on('keydown', function(e){
					      if (e.which === 40){
					        that.$selectableUl.focus();
					        return false;
					      }
					    });

					    that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
					    .on('keydown', function(e){
					      if (e.which == 40){
					        that.$selectionUl.focus();
					        return false;
					      }
					    });
					  },
					  afterSelect: function(){
					    this.qs1.cache();
					    this.qs2.cache();
					  },
					  afterDeselect: function(){
					    this.qs1.cache();
					    this.qs2.cache();
					  }
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
            			alert("El campo 'Cedula' s�lo debe contener n�meros sin puntos ni espacios en blanco");
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
            		else if ($('#txtRifNum').val() == '') {
           			 	$("#tabs").tabs( "option", "active", 0);
           				alert("El campo 'RIF' no puede ser dejado en blanco");
           				return;
           			}
           			else if(!$('#txtRifNum').val().match(patternNumber)) {
           				$("#tabs").tabs( "option", "active", 0);
           				alert("El campo 'RIF' s�lo debe contener n�meros sin puntos ni espacios en blanco");
           				return;
           			}
            		else if ($('#txtAddress').val() == '') {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo 'Direccion' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#txtEmail').val() == '') {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo 'Correo Electr�nico' no puede ser dejado en blanco");
            			return;
            		}
            		else if (!$('#txtEmail').val().match(patternEmail)) {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El formato del Correo Electr�nico colocado es inv�lido");
            			return;
            		}
            		else if ($('#txtPhoneNumber0').val() == '') {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("Debe colocar al menos un n�mero telef�nico");
            			return;
            		}
            		else if (!$('#txtPhoneNumber0').val().match(patternPhoneNumber)) {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo de 'Tel�fono' debe contener s�lo n�meros sin puntos, ni guiones ni espacios en blanco. Coloque el c�digo de ciudad.");
            			return;
            		}
            		else if ($('#txtPhoneNumber1').val() != '' && !$('#txtPhoneNumber1').val().match(patternPhoneNumber)) {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo de 'Tel�fono' debe contener s�lo n�meros sin puntos, ni guiones ni espacios en blanco. Coloque el c�digo de ciudad.");
            			return;
            		}
            		else if ($('#txtPhoneNumber2').val() != '' && !$('#txtPhoneNumber2').val().match(patternPhoneNumber)) {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo de 'Tel�fono' debe contener s�lo n�meros sin puntos, ni guiones ni espacios en blanco. Coloque el c�digo de ciudad.");
            			return;
            		}
            		else if ($('#txtPhoneNumber3').val() != '' && !$('#txtPhoneNumber3').val().match(patternPhoneNumber)) {
            			$("#tabs").tabs( "option", "active", 1);
            			alert("El campo de 'Tel�fono' debe contener s�lo n�meros sin puntos, ni guiones ni espacios en blanco. Coloque el c�digo de ciudad.");
            			return;
            		}
            		else if (!$('#my-select').val()) {
            			$("#tabs").tabs( "option", "active", 2);
            			alert("Debe seleccionar al menos un valor para el campo 'Unidad'");
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
	            	<li class="menuitem"><a href="ListSpecialistsServlet">Ver Especialistas</a></li>
            	<li class="menuitem"><a href="CreateSpecialistServlet">Crear Especialista</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Editar Especialista:</h2>
				<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Datos Personales</a></li>
					    <li><a href="#tabs-2">Datos Contacto</a></li>
					    <li><a href="#tabs-3">Unidad</a></li>
			  		</ul>
			  		<form id="form1" name="form1" action="EditSpecialistServlet">
			  			<input type="hidden" id="specialistID" name="specialistID" value="<%= spec.getId() %>" /> 
			  			<div id="tabs-1">
							<fieldset>
								<label for="name">C�dula de Identidad:</label>
								<select name="txtCedId" id="txtCedId">
									<option value="V-" <%= ci[0].equals("V") ? "selected" : "" %>>V</option>
									<option value="E-" <%= ci[0].equals("E") ? "selected" : "" %>>E</option>
								</select>
								<input type="text" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" value="<%= ci[1] %>" /> <br><br>
								<label for="name">Nombre:</label>
								<input type="text" name="txtFirstName" id="txtFirstName" maxlength="50" size="5" value="<%= spec.getFirstName() %>"/> <br><br>
								<label for="name">Apellido:</label>
								<input type="text" name="txtLastName" id="txtLastName" maxlength="50" size="5" value="<%= spec.getLastName() %>"/> <br><br>
								<label for="name">Fecha de Nacimiento:</label>
								<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" value="<%= spec.getBirthdate() %>"/> <br><br>
								<label for="name">Sexo:</label>
								<select name="txtGen" id="txtGen">	
									<option value="" <%= spec.getSex().equals("-") ? "selected" : "" %>>Seleccionar</option>
									<option value="F" <%= spec.getSex().equals("F") ? "selected" : "" %>>Femenino</option>
									<option value="M" <%= spec.getSex().equals("M") ? "selected" : "" %>>Masculino</option>
								</select><br><br>
								<label for="name">RIF:</label>
								<input type="text" name="txtRifNum" id="txtRifNum" maxlength="50" size="18" value="<%= spec.getRif() %>" /> <br><br>
							</fieldset>						
							<br>
			  			</div>
			  			<div id="tabs-2">
							<fieldset>
								<label for="name">Direcci�n:</label>
								<textarea name="txtAddress" id="txtAddress" rows="2" cols="50"><%= spec.getAddress() %></textarea> <br><br>
								<label for="name">Correo Electr�nico:</label>
								<input type="text" name="txtEmail" id="txtEmail" maxlength="50" size="5" value="<%= spec.getEmail() %>"/> <br><br>
								<label for="name">Tel�fono:</label>
								<% for (int i = 0; i<specialistPhoneNumbers.size(); i++) {
										SpecialistPhoneNumber spn = specialistPhoneNumbers.get(i);
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
						  	 		<img alt="logo" src="./images/add.png"  id="addPhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
						  	 		<% }
						  	 		   else { %>
						  	 		<img alt="logo" src="./images/close.png"  id="deletePhone<%= i %>" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
									<% } %>
									<br /><br />
								</div>
								<% } 
								   for (int j = specialistPhoneNumbers.size(); j<4; j++) { 
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
							<br>
			  			</div>			  		
			  			<div id="tabs-3">
			  				<fieldset>
								<label for="name">Unidad:</label>
								<div style="float:left;">
								<select multiple="multiple" id="my-select" name="my-select[]">
									<% for (int k=0; k<units.size(); k++) {
											Unit u = units.get(k);	
									%>
											<option value="<%= u.getUnitID() %>" <%= specialistUnits.containsKey(u.getUnitID()) ? "selected" : "" %>><%= u.getName().toUpperCase() %></option>
									<% } %>
						    	</select>	
								<!--JS Multiselect http://loudev.com/-->
						    	<script src="./js/jquery.multi-select.js" type="text/javascript"></script>		
						    	</div>		
							</fieldset>		
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