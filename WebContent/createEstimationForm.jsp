<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Presupuesto</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
		<script type="text/javascript">
		var idUser;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });	
			
				$('#cedNumber').on('input', function() {
				    $("#go").hide();
				    $("#form").show();
				    $('#form').css({'display':'inline'});
				    
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
			  if( $(this).find(":selected").text() == "Pedi�trico"){
				$("#info-title").text("C�dula de identidad de alg�n representante legal:");
			  }else
				$("#info-title").text("C�dula de identidad del paciente:");
				
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
	            	<li class="menuitem"><a href="ListEstimationsServlet">Ver Presupuestos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute; text-align: left;">	
	        	<h2>Crear Presupuesto:</h2><br><br> 
				<!-- Recordar que sino se consigue al cliente, se debe mostrar una ventana para indicarlo
				     y verificar si se desea crear el usuario (mostrar deleteVitalSign) -->
				<form action="CreateEstimationServlet"  id="form" >
					<fieldset class="bigger">
						<label>Escoja el tipo de paciente:</label>
						<select class="target">
							<option value="Adulto">Adulto</option>
							<option value="Pedi�trico">Pedi&aacute;trico</option>
						</select><br><br><br>
						<label id="info-title">Ingrese el n�mero de c�dula de identidad del paciente:</label>
						<select id="cedId" name="cedId">
							<option value="V-" >V</option>
							<option value="E-" >E</option>
						</select> 
						<input id="cedNumber" type="text">
						<input type="submit" value="Buscar" />
						
					</fieldset>
				</form>
				<div id="botonera" style="width:100px; margin-top: 200px;">
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>		
				</div>	
			</div>
		</div>
		
		<div id="deleteVitalSign">
			<div id="signup-ct">
				<form action="CreatePatientEstimationServlet">
				<h3 id="see_id" class="sprited" > Paciente Inexistente</h3>
				<br><br>
				<span style="font-size: 16px; text-align: center;">El paciente indicado no se encuentra registrado en el sistema. �Desea agregarlo? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"  name="sbmtButton" value="Aceptar"  />
				</div>
				</form>
			</div>
		</div>
	</body>
</html>