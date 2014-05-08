<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%><!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Responsable de Pago</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>		
		<!--JS Datapicker-->
		<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
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
					dateFormat:'dd/mm/yyyy',
					changeMonth: true,
				    changeYear: true
				});
			} );
			
			$(function(){
				$.datepicker.setDefaults($.datepicker.regional['es']);
				$('#txtDateIni2').datepicker({
					showOn: "button",
					buttonImage: "images/calendar.png",
					buttonImageOnly: true,
					buttonText: "Seleccione una fecha",
					dateFormat:'dd/mm/yyyy',
					changeMonth: true,
				    changeYear: true
				});
			} );
		</script>
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
				if (first.indexOf("Receivable") > 0){
					if (first == "createReceivable"){
						$("#form").attr('action', 'CreateReceivableServlet#tabs-1');
						$("#form2").attr('action', 'CreateReceivableServlet#tabs-1');
					}
					else if(first == "editReceivable")
						$("#form").attr('action', 'EditReceivableServlet#tabs-1');
				}
			}
				
		});
		
	</script>
		<link rel="stylesheet" href="/resources/demos/style.css" />		
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListAccountsServlet">Ver Cuentas</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Datos del responsable de pago:</h2>
	        	<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Información Personal</a></li>
					    <li><a href="#tabs-2">Información Adicional</a></li>
			  		</ul>
			  		<div id="tabs-1">
						<fieldset>
							<label for="name">Nombre:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" style="width: 430px;" /> <br><br>
							<b>Rif:</b>
							<select style="margin-left:166px;">
								<option>J</option>
								<option>G</option>
							</select>
							<input type="text" name="txtRif" id="txtRif" maxlength="50" size="5" style="width: 120px;" />
							<b style="margin-left: 10px;">Nit:</b>
							<input  type="text" name="txtNit" id="txtNit" maxlength="50" size="5" style="width: 150px; margin-left:72px;" /> <br><br>
							<label>Dirección:</label>
							<textarea name="txtAddress" id="txtAddress" rows="2" cols="69"></textarea><br><br>
							<b>Teléfono:</b>
							<input type="text" name="txtPhone" id="txtPhone" maxlength="50" size="5" style="margin-left:125px;width:160px;">
							<b style="margin-left: 10px;">Fax:</b>
							<input type="text" name="txtFax" id="txtFax" maxlength="50" size="5" style="margin-left: 72px; width: 150px;" ><br><br>
							<b>Email:</b>
							<input type="text" name="txtEmail" id="txtEmail" maxlength="50" size="5" style="margin-left:148px;width:160px;">
							<b style="margin-left: 10px;">Página Web:</b>
							<input type="text" name="txtWebsite" id="txtWebsite" maxlength="50" size="5" style="margin-left: 22px; width: 150px;" >
							
						</fieldset>						
						<div id="botonera">
							<form id="form" action="" style="display: inline; ">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
								</div>
								<div id="botonV" style="display: inline; margin-right: 30px;" >
										<input type="submit" class="button" value="Regresar" />		
								</div>
							</form>	
						</div><br>
			  		</div>			  		
			  		<div id="tabs-2">
						<fieldset>
							<label>Plan de Pago (%):</label>
							<input type="text" name="txtPaymentPlan" id="txtPaymentPlan" maxlength="50" size="5" style="width:55px;"/> 
							<b style="margin-left: 134px;">% Retención de la Empresa:</b>
							<input type="text" name="txtRet" id="txtRet" maxlength="50" size="5" style="width:55px;"/> <br><br>
							<label >Baremos:</label>
							<select name="txtIns" id="txtIns" style="width: 176px;">
								<option>Seleccionar</option>
								<option>Vidamed</option>
								<option>Otros</option>
							</select> <b style="margin-left: 17px;" >% Otras Retenciones:</b>
							<input type="text" name="txtRet" id="txtRet" maxlength="50" size="5" style="width:55px;margin-left: 41px;"/> <br><br>
							
							<label for="name">Persona de Contacto:</label>
							<input type="text" name="txtContact" id="txtContact" maxlength="50" size="5"/> <br><br>
							<label for="name">Otra información:</label>
							<textarea name="txtInfo" id="txtInfo" rows="2" cols="34"></textarea><br><br>
							<input type="checkbox" name="option" value="Rent" style="margin-left: 166px; margin-right:5px;">Rent. Menos Honorarios
							<input type="checkbox" name="option" value="PreAdm" style="margin-left: 50px;margin-right:5px;">Permite Pre-Admisión 
						</fieldset>						
						<div id="botonera">
							<form id="form2" action="" style="display: inline; ">
								<div id="botonP" style="display: inline; margin-right: 30px;">
										<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
								</div>
								<div id="botonV" style="display: inline; margin-right: 30px;" >
										<input type="submit" class="button" value="Regresar" />		
								</div>
							</form>	
						</div><br>
			  		</div>
			  	</div><br>
			</div>
		</div>
	</body>
</html>