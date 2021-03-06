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
		<title>Servicios Farmaceuticos Quirurgicos</title>
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
	        	
	        </div>         
          	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Servicios Farmaceuticos Quirurgicos</h2>
				<br>
				<fieldset>
						Agregue o elimine servicios farmac�uticos:
						<div  style="margin: 20px auto;">
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
							<option value="235" >CIRUGIA GENERAL</option>
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
							<option value="356" >GINECOLOG�A CL�NICA</option>
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
							<option value="370" >ONCOLOG�A M�DICA</option>
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
						<form action="ListDoctorsServlet">
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
	</body>
</html>