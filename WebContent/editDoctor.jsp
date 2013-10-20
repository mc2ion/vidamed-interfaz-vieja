<!DOCTYPE html>
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
					dateFormat:'dd/mm/yyyy',
					changeMonth: true,
				    changeYear: true
				});
			} );
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
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="doctors.jsp">Ver Especialistas</a></li>
            	<li class="menuitem"><a href="createDoctor.jsp">Crear Especialista</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
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
			  		<div id="tabs-1">
						<fieldset>
							<label for="name">C�dula de Identidad:</label>
							<select name="txtCedId" id="txtCedId">
								<option value="V-" selected>V</option>
								<option value="E-">E</option>
							</select>
							<input type="text" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" value="12345678" /> <br><br>
							<label for="name">Nombre:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Ricardo"/> <br><br>
							<label for="name">Apellido:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="L�pez"/> <br><br>
							<label for="name">Fecha de Nacimiento:</label>
							<input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" value="07/09/1965"/> <br><br>
							<label for="name">Sexo:</label>
							<select name="txtGen" id="txtGen">	
								<option value="-" selected="selected">Seleccionar</option>
								<option value="F">Femenino</option>
								<option value="M" selected>Masculino</option>
							</select><br><br>
						</fieldset>						
						<div id="botonera">
							<form action="doctors.jsp">
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
							<textarea name="txtDescription" id="txtDescription" rows="2" cols="50">Av. Francisco de Miranda, Edif. Miravila, piso 18, apto 183. La California.</textarea> <br><br>
							<label for="name">Correo Electr�nico:</label>
							<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="rlopez@gmail.com"/> <br><br>
							<label for="name">Tel�fono:</label>
							<div >
								<select id="phone" name="phone">
									<option value="L" selected>Local</option>
									<option value="P" >Particular</option>
									<option value="T" >Trabajo</option>
								</select>
						  	 	<input type="text" value="02122345678" style="width: 135px;">
						  	 	<img alt="logo" src="./images/add.png"  id="addPhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
								<br /><br />
							</div>
							<div id="otherPhone">
								<select id="phone" name="phone">
									<option value="L">Local</option>
									<option value="P" selected>Particular</option>
									<option value="T" >Trabajo</option>
								</select>
								<input type="text" value="04142345678" style="width: 135px;">
								<img alt="logo" src="./images/close.png"  id="deletePhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
						 		<br /><br />
						 	</div>
							<div id="otherPhone2">
								<select id="phone" name="phone">
									<option value="L" >Local</option>
									<option value="P" >Particular</option>
									<option value="T"  selected>Trabajo</option>
								</select>
								<input type="text" value="02129876543" style="width: 135px;">
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
							<form action="doctors.jsp">
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
							<div style="float:left;">
							<select multiple="multiple" id="my-select" name="my-select[]">
								<option value="337" >ALERGOLOG�A</option>
							 	<option value="660" >ANALISTAS DE SEGUROS</option>
								<option value="338" >ANESTESIOLOG�A</option>
								<option value="340" >BIOAN�LISIS</option>
								<option value="240" >CARDIOLOG�A</option>
								<option value="342" >CARDIOVASCULAR PERIF�RICO</option>
								<option value="343" >CIRUG�A BARI�TRICA</option>
								<option value="344" >CIRUG�A COLUMNA</option>
								<option value="345" >CIRUG�A DE T�RAX</option>
								<option value="887" >CIRUGIA EN ORTOPEDIA INFANTIL</option>
								<option value="235" selected>CIRUGIA GENERAL</option>
								<option value="346" >CIRUG�A GINECOL�GICA</option>
								<option value="544" >CIRUG�A LAPAROSCOPICA</option>
								<option value="348" >CIRUG�A M�XILO-FACIAL </option>
								<option value="349" >CIRUG�A ONCOL�GICA </option>
								<option value="350" >CIRUG�A PEDI�TRICA</option>
								<option value="351" >CIRUG�A PL�STICA, EST�TICA Y RECONSTRUCTIVA</option>
								<option value="935" >COLOPROCTOLOG�A</option>
								<option value="658" >COORDINADOR DE APS / SUP. DE SECRETARIAS</option>
								<option value="236" >DERMATOLOG�A</option>
								<option value="352" >ENDOCRINOLOG�A</option>
								<option value="231" >FISIATR�A</option>
								<option value="353" >FISIOTERAPEUTAS</option>
								<option value="238" >GASTROENTEROLOG�A</option>
								<option value="418" >GASTROENTEROLOG�A INFANTIL</option>
								<option value="355" >GINECO OBSTETRICIA</option>
								<option value="356" selected>GINECOLOG�A CL�NICA</option>
								<option value="239" >HEMATOLOG�A</option>
								<option value="357" >INFERTILIDAD</option>
								<option value="419" >LABORATORIO</option>
								<option value="359" >MASTOLOG�A</option>
								<option value="245" >MEDICINA INTERNA</option>
								<option value="362" >M�DICOS RESIDENTES</option>
								<option value="656" >NEFROLOGIA DE ADULTOS</option>
								<option value="364" >NEONATOLOG�A</option>
								<option value="365" >NEUMONOLOG�A</option>
								<option value="366" >NEUMONOLOG�A PED�ATRICA</option>
								<option value="367" >NEUROCIRUG�A</option>
								<option value="233" >NEUROLOG�A</option>
								<option value="229" >NUTRICI�N</option>
								<option value="232" >OFTALMOLOG�A</option>
								<option value="370" selected>ONCOLOG�A M�DICA</option>
								<option value="244" >OTORRINOLARINGOLOG�A</option>
								<option value="371" >PATOLOG�A</option>
								<option value="372" >PEDIATR�A</option>
								<option value="373" >PROCTOLOG�A</option>
								<option value="374" >PSQUIATR�A</option>
								<option value="375" >RADIOLOG�A, IMAGENOLOG�A</option>
								<option value="376" >REUMATOLOG�A</option>
								<option value="659" >SECRETARIAS</option>
								<option value="378" >T�CNICOS RADI�LOGOS</option>
								<option value="379" >TOMOGRAF�A Y RESONANCIA</option>
								<option value="657" >TRAUMATOLOGIA ESPECIALISTA EN COLUMNA</option>
								<option value="380" >TRAUMATOLOG�A Y ORTOPEDIA</option>
								<option value="242" >UROLOG�A</option>
								<option value="381" >UROLOG�A PEDI�TRICA</option>
						    </select>	
							<!--JS Multiselect http://loudev.com/-->
						    <script src="./js/jquery.multi-select.js" type="text/javascript"></script>		
						    </div>		
						</fieldset>		
						<div id="botonera">
							<form action="doctors.jsp">
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