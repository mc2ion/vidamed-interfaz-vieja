<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Proveedor</title>
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
				if (first.indexOf("Payable") > 0){
					if (first == "createAccountPayable"){
						$("#form").attr('action', 'CreateAccountPayableServletp#tabs-1');
						$("#form2").attr('action', 'CreateAccountPayableServlet#tabs-1');
					}
					else if(first == "editAccountPayable"){
						$("#form").attr('action', 'EditAccountPayableServlet#tabs-1');
						$("#form2").attr('action', 'EditAccountPayableServlet#tabs-1');
					}
					
				}
			}
				
		});
		
	</script>
		<link rel="stylesheet" href="/resources/demos/style.css" />		
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	   	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="ListAdmissionDischargesServlet">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListAccountsServlet">Ver Cuentas</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Datos del proveedor:</h2>
	        	<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Información Personal</a></li>
					    <li><a href="#tabs-2">Información Adicional</a></li>
			  		</ul>
			  		<div id="tabs-1">
						<fieldset>
							<label for="name">Nombre:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" style="width: 328px;" /> <br><br>
							<b>Rif:</b>
							<select style="margin-left:143px;">
								<option>J</option>
								<option>G</option>
							</select>
							<input type="text" name="txtRif" id="txtRif" maxlength="50" size="5" style="width: 120px;" />
							<b style="margin-left: 10px;">Nit:</b>
							<input  type="text" name="txtNit" id="txtNit" maxlength="50" size="5" style="width: 150px; margin-left:22px;" /> <br><br>
							<b>País:</b>
							<input type="text" name="txtCountry" id="txtCountry" maxlength="50" size="5" style="margin-left:134px;width: 160px; "/> 
							<b style="margin-left: 10px;">Estado:</b>
							<input type="text" name="txtState" id="txtState" maxlength="50" size="5" style="width: 150px;"/> <br><br>
							<b>Municipio:</b>
							<input type="text" name="txtMun" id="txtMun" maxlength="50" size="5" style="margin-left:98px;width: 160px; " /> 
							<b style="margin-left: 10px;">Ciudad:</b>
							<input type="text" name="txtCity" id="txtCity" maxlength="50" size="5" style="width: 150px;"  /> <br><br>
							<label>Dirección:</label>
							<textarea name="txtAddress" id="txtAddress" rows="2" cols="60"></textarea><br><br>
							<b>Teléfono:</b>
							<input type="text" name="txtPhone" id="txtPhone" maxlength="50" size="5" style="margin-left:100px;width:160px;">
							<b style="margin-left: 10px;">Fax:</b>
							<input type="text" name="txtFax" id="txtFax" maxlength="50" size="5" style="margin-left: 22px; width: 150px;" >
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
							<label for="name">Instrumento:</label>
							<select name="txtIns" id="txtIns" style="width: 176px;">
								<option>Seleccionar</option>
								<option>Chequera</option>
								<option>Cuenta Corriente</option>
								<option>Cuenta de Ahorro</option>
								<option>Efectivo</option>
								<option>Saldo Fijo</option>
								<option>Recibo de Pago</option>
							</select><br><br>
							<label for="name">Banco:</label>
							<select name="txtBank" id="txtBank" style="width: 176px;">
								<option>Seleccionar</option>
								<option>100% Banco</option>
								<option>ABN-AMRO BANK</option>
								<option>Banco Mercantil</option>
								<option>Banesco</option>
								<option>Sofitasa</option>
							</select><br><br>
							<label for="name">Número de Cuenta:</label>
							<input type="text" name="txtAccountNum" id="txtAccountNum" maxlength="50" size="5"/> <br><br>
							<label for="name">Persona de Contacto:</label>
							<input type="text" name="txtContact" id="txtContact" maxlength="50" size="5"/> <br><br>
							<label for="name">Otra información:</label>
							<textarea name="txtInfo" id="txtInfo" rows="2" cols="34"></textarea><br><br>
							<label for="name">Clasificación Proveedor:</label>
							<select name="txtClas" id="txtClas" style="width: 176px;">
								<option>Seleccionar</option>
								<option>Compras</option>
								<option>Farmacia</option>
								<option>Servicios Públicos</option>
								<option>Mantenimiento</option>
								<option>Honorario Profesionales</option>
							</select>
						</fieldset>						
						<div id="botonera2">
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