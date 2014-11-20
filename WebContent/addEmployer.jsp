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
		<title>Agregar Empleado</title>
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
					
					if($('#otherPhone').is(':hidden')) {
						$("#otherPhone").show();
					} else {
						if($('#otherPhone2').is(':hidden')) {
							$("#otherPhone2").show();
						} else {
							$("#otherPhone3").show();
						}
					}
					
					if($('#otherPhone').is(':visible') && $('#otherPhone2').is(':visible') && $('#otherPhone3').is(':visible')){
						$(this).hide();						
					}
					  
				});
				
				$("#deletePhone").click(function() {
					  $("#otherPhone").hide();
					  $("#addPhone").show();
				});
				
				$("#deletePhone2").click(function() {
					  $("#otherPhone2").hide();
					  $("#addPhone").show();
				});
				
				$("#deletePhone3").click(function() {
					  $("#otherPhone3").hide();
					  $("#addPhone").show();
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
				    changeYear: true
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
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListBillingsServlet">Ver Facturación</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
        	<h2>Agregar Usuario:</h2>
			<br>
				<div id="tabs-1">
					<fieldset>
						<label for="name">Cédula de Identidad:</label>
						<select name="txtCedId" id="txtCedId">
							<option value="V-">V</option>
							<option value="E-">E</option>
						</select>
						<input type="text" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" /> <br><br>
						<label for="name">Nombre:</label>
						<input type="text" name="txtFirstName" id="txtFirstName" maxlength="50" size="5"/> <br><br>
						<label for="name">Apellido:</label>
						<input type="text" name="txtLastName" id="txtLastName" maxlength="50" size="5"/> <br><br>
						<label for="name">Fecha de Ingreso:</label>
						<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" /><br><br>
						<label for="name">Cargo:</label>
						<input type="text" name="rol" id="rol" maxlength="50" size="10" /><br><br>
						<label for="name">Importe:</label>
						<input type="text" name="salary" id="salary" maxlength="50" size="10" /><br><br>
					</fieldset>						
					<div id="botonera">
						<form action="ListBillingsServlet#tabs-3">
							<div id="botonP" style="display: inline; margin-right: 30px;">
										<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
							</div>	
							<div id="botonV" style="display: inline;">
									<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
							</div>	
						</form>
					</div><br>
			  </div>
			</div>
		</div>
	</body>
</html>