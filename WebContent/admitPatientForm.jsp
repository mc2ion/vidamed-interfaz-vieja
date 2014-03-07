<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Adminitir Paciente</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
		<script type="text/javascript">
		var idUser;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });	
			
			/*Simular que un cliente existe o no.. si se coloca un numero de cedula se pone a ver el form, y se quita el leanModal*/
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
			  if( $(this).find(":selected").text() == "Pediátrico"){
				$("#info-title").text("Cédula de identidad de algún representante legal:");
			  }else
				$("#info-title").text("Cédula de identidad del paciente:");
				
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
	            	<li class="menuitem"><a href="ListAdmissionsServlet">Ver Admisiones</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Admitir Paciente:</h2><br><br>
	        	<!-- Recordar que sino se consigue al cliente, se debe mostrar una ventana para indicarlo
				     y verificar si se desea crear el usuario (mostrar deleteVitalSign) -->
				<form action="AdmitPatientServlet"  id="form" >
					<fieldset class="bigger">
						<label>Escoja el tipo de paciente:</label>
						<select class="target">
							<option value="Adulto">Adulto</option>
							<option value="Pediátrico">Pedi&aacute;trico</option>
						</select><br><br><br>
						<div style="font-size: 14px;">Proporcione alguno de los siguientes datos: </div><br><br>
						<label id="info-title">Cédula de identidad del paciente:</label>
						<select id="cedId" name="cedId">
							<option value="V-" >V</option>
							<option value="E-" >E</option>
						</select> <input id="cedNumber" type="text"><br><br>
						<label>No. Presupuesto:</label>  <input id="estimation" type="text" style="width: 25%;">
					</fieldset>
					<div id="botonera" style="width:300px; margin-top: 50px;">
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>
						<div id="botonV" style="display: inline; margin-left: 20px;">
							<input type="submit" class="button" value="Buscar" />
						</div>							
					</div>	
				</form>
				
			</div>
		</div>
		
		<div id="deleteVitalSign">
			<div id="signup-ct">
				<form action="CreatePatientServlet">
				<h3 id="see_id" class="sprited" > Paciente Inexistente</h3>
				<br><br>
				<span style="font-size: 16px; text-align: center;">El paciente indicado no se encuentra registrado en el sistema. ¿Desea agregarlo? </span> <br><br>
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