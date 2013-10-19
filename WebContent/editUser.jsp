<!DOCTYPE html>
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
					dateFormat:'dd/mm/yyyy',
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
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	   	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="pendingAdmissionDischarges.jsp">Altas Admisi�n<span class="badge yellow">3</span></a></li>
		 		<li><a href="pendingCreditNotes.jsp">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="pendingCreditNotesReview.jsp">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="pendingInvoices.jsp">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="pendingRequest.jsp">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="pendingPharmacyDischarges.jsp">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="billing.jsp">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="mainMenu.jsp">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="users.jsp">Ver Usuarios</a></li>
            		<li class="menuitem"><a href="createUser.jsp">Crear Usuario</a></li>
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
			  		<div id="tabs-1">
						<fieldset>
							<label for="name">C�dula de Identidad:</label>
							<select name="txtCedId" id="txtCedId">
								<option value="V-" selected>V</option>
								<option value="E-">E</option>
							</select>
							<input type="text" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" value="18143944" /> <br><br>
							<label for="name">Nombre:</label>
							<input type="text" name="txtFirstName" id="txtFirstName" maxlength="50" size="5" value="Rafael"/> <br><br>
							<label for="name">Apellido:</label>
							<input type="text" name="txtLastName" id="txtLastName" maxlength="50" size="5" value="Ch�vez"/> <br><br>
							<label for="name">Fecha de Nacimiento:</label>
							<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" value="26/11/1988" /><br><br>
							<label for="name">Sexo:</label>
							<select name="txtGen" id="txtGen">	
								<option value="-" selected="selected">Seleccionar</option>
								<option value="F">Femenino</option>
								<option value="M" selected>Masculino</option>
							</select><br><br>
						</fieldset>						
						<div id="botonera">
							<form action="users.jsp">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>	
							</form>
						</div><br>
			  		</div>
			  		<div id="tabs-2">
						<fieldset>
							<label for="name">Direcci�n:</label>
							<textarea name="txtDescription" id="txtDescription" rows="2" cols="50">Avenida Francisco de Miranda, Edificio Miravila, Piso 18, Apartamento 18-C. La California, Caracas.</textarea> <br><br>
							<label for="name">Correo Electr�nico:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="rafael.chavez@gmail.com"/> <br><br>
							<label for="name">Tel�fono:</label>
							<div >
								<select id="phone" name="phone">
									<option value="L" >Local</option>
									<option value="P" selected>Particular</option>
									<option value="T" >Trabajo</option>
								</select>
						  	 	<input type="text" value="" style="width: 135px;" value="04143313133">
						  	 	<img alt="logo" src="./images/add.png"  id="addPhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
								<br /><br />
							</div>
							<div id="otherPhone" style="display:none;">
								<select id="phone" name="phone">
									<option value="L" >Local</option>
									<option value="P" >Particular</option>
									<option value="T" >Trabajo</option>
								</select>
								<input type="text" value="" style="width: 135px;">
								<img alt="logo" src="./images/close.png"  id="deletePhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
						 		<br /><br />
						 	</div>
							<div id="otherPhone2" style="display:none;">
								<select id="phone" name="phone">
									<option value="L" >Local</option>
									<option value="P" >Particular</option>
									<option value="T" >Trabajo</option>
								</select>
								<input type="text" value="" style="width: 135px;">
								<img alt="logo" src="./images/close.png"  id="deletePhone2" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
						  	 	<br /><br />
						  	 </div>
							 <div id="otherPhone3" style="display:none;">
								 <select id="phone" name="phone">
										<option value="L" >Local</option>
										<option value="P" >Particular</option>
										<option value="T" >Trabajo</option>
									</select>
							  	 <input type="text" value="" style="width: 135px;">
							  	 <img alt="logo" src="./images/close.png"  id="deletePhone3" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
							
						  	 </div>
						</fieldset>		
						<div id="botonera">
							<form action="users.jsp">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>	
							</form>
						</div><br>
			  		</div>			  		
			  		<div id="tabs-3">
			  			<fieldset>
							<label for="name">Unidad:</label>
							<select name="txtGen" id="txtGen">	
								<option value="-" selected="selected">Seleccionar</option>
								<option value="M" >Admisi�n</option>
								<option value="M" >Caja</option>
								<option value="M" >Emergencia</option>
								<option value="F">Facturaci�n</option>
								<option value="M" >Farmacia</option>
								<option value="M" selected>Sistema</option>
							</select><br><br>
							<label for="name">Fecha de Ingreso:</label>
							<input type="text" name="txtDateIni2" id="txtDateIni2" maxlength="50" size="10" value="28/07/2008" /><br><br>
							<label for="name">Cargo:</label>
							<input type="text" name="txtFirstName" id="txtFirstName" maxlength="50" size="5" value="Supervisor"/> <br><br>
							<label for="name">Salario:</label>
							<input type="number" min="1" name="txtPrice" id="txtPrice" maxlength="6" size="6" value="7000" /> <br><br>
							<label for="name">Usuario:</label>
							<input type="text" name="txtFirstName" id="txtFirstName" maxlength="50" size="5" value="rchavez"/> <br><br>
						</fieldset>		
						<div id="botonera">
							<form action="users.jsp">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>	
							</form>
						</div><br>
			  		</div>			  		
			  		<div id="tabs-4">
			  			<div id="accordion">
				  <h3>Presupuesto</h3>
				  <div>
				    <table class="table-simple">
				    	<tr>
				    		<td><input type="checkbox" checked>Ver Listado</td>
				    		<td><input type="checkbox" checked>Crear</td>
				    		<td><input type="checkbox">Ver Detalle</td>
				    		<td><input type="checkbox">Imprimir</td>
				    	</tr>
				    	<tr>
				    		<td><input type="checkbox" checked>Editar</td>
				    		<td><input type="checkbox">Actualizar</td>
				    		<td><input type="checkbox" checked>Eliminar</td>
				    		<td><input type="checkbox">Todos</td>
				    	</tr>
				    </table>
				  </div>
				  <h3>Emergencia</h3>
				  <div>
				    <table class="table-simple">
				    	<tr>
				    		<td><input type="checkbox">Ver Listado</td>
				    		<td><input type="checkbox">Ver Detalle</td>
				    		<td><input type="checkbox">Editar</td>
				    		<td><input type="checkbox">Dar de Altar</td>
				    	</tr>
				    	<tr>
				    		<td><input type="checkbox">Hospitalizar</td>
				    		<td><input type="checkbox">Eliminar</td>
				    		<td><input type="checkbox">Corte de Cuenta</td>
				    		<td><input type="checkbox">Todos</td>
				    	</tr>
				    </table>
				  </div>
				  <h3>Admisi�n</h3>
				  <div>
				    <table class="table-simple">
				    	<tr>
				    		<td><input type="checkbox">Ver Listado</td>
				    		<td><input type="checkbox">Crear</td>
				    		<td><input type="checkbox">Ver Detalle</td>
				    		<td><input type="checkbox">Imprimir</td>
				    	</tr>
				    	<tr>
				    		<td><input type="checkbox">Editar</td>
				    		<td><input type="checkbox">Actualizar</td>
				    		<td><input type="checkbox">Elimintar</td>
				    		<td><input type="checkbox">Todos</td>
				    	</tr>
				    </table>
				  </div>
				  <h3>Hospitalizaci�n</h3>
				  <div>
				    <table class="table-simple">
				    	<tr>
				    		<td><input type="checkbox">Ver Listado</td>
				    		<td><input type="checkbox">Crear</td>
				    		<td><input type="checkbox">Ver Detalle</td>
				    		<td><input type="checkbox">Imprimir</td>
				    	</tr>
				    	<tr>
				    		<td><input type="checkbox">Editar</td>
				    		<td><input type="checkbox">Actualizar</td>
				    		<td><input type="checkbox">Elimintar</td>
				    		<td><input type="checkbox">Todos</td>
				    	</tr>
				    </table>
				  </div>
				  <h3>Usuarios</h3>
				  <div>
				    <table class="table-simple">
				    	<tr>
				    		<td><input type="checkbox">Ver Listado</td>
				    		<td><input type="checkbox">Crear</td>
				    		<td><input type="checkbox">Ver Detalle</td>
				    		<td><input type="checkbox">Imprimir</td>
				    	</tr>
				    	<tr>
				    		<td><input type="checkbox">Editar</td>
				    		<td><input type="checkbox">Actualizar</td>
				    		<td><input type="checkbox">Elimintar</td>
				    		<td><input type="checkbox">Todos</td>
				    	</tr>
				    </table>
				  </div>
				  <h3>Protocolos</h3>
				  <div>
				    <table class="table-simple">
				    	<tr>
				    		<td><input type="checkbox">Ver Listado</td>
				    		<td><input type="checkbox">Crear</td>
				    		<td><input type="checkbox">Ver Detalle</td>
				    		<td><input type="checkbox">Imprimir</td>
				    	</tr>
				    	<tr>
				    		<td><input type="checkbox">Editar</td>
				    		<td><input type="checkbox">Actualizar</td>
				    		<td><input type="checkbox">Elimintar</td>
				    		<td><input type="checkbox">Todos</td>
				    	</tr>
				    </table>
				  </div>
				</div>
			  			<div id="botonera">
							<form action="users.jsp">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>	
							</form>
						</div><br>
			  		</div>	
			  	</div>
			</div>
		</div>
	</body>
</html>