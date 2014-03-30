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
		
		$(document).ready(function() {
			$( ".target" ).change(function() {
			  if( $(this).find(":selected").text() == "Pediátrico"){
				$("#info-title").text("Cédula de identidad de algún representante legal:");
			  }else
				$("#info-title").text("Cédula de identidad del paciente:");
				
			});
			
			
			// AJAX
	        $('#submit').click(function(event) {  
	        	ShowProgressAnimation();
				setTimeout( function(){ 
					var txtCedIdNum	= $('#txtCedIdNum').val();
					var patientType	= $('#target option:selected').val();
					var txtCedId	= $("#txtCedId option:selected").val();
	        	
	        	
					$.get('SearchPatientServlet', {patientType: patientType, txtCedId: txtCedId , txtCedIdNum: txtCedIdNum}, function(responseText) { 
						$('#progress').dialog('close');
						//Cliente no encontrado
						if (responseText == "not found") {
							//Paso los datos para que no deban escribirlos de nuevo
							$("#txtCedIdHidden").val(txtCedId);
							$("#txtCedIdNumHidden").val(txtCedIdNum);
							$("#txtPatientTypeHidden").val(patientType);
							$("#go").click();
						}
						//Cliente encontrado
						else{
							var split = responseText.split('/');
							var patientId = split[0];
							var ced = split[1];
							var name = split[2];
							var lastname = split[3];
							$("#patientID").val(patientId);
							$("#txtCedNumber").val(ced);
							$("#txtName").val(name);
							$("#txtLastName").val(lastname);
							// Submit form
							$("#submit-form").click();
						}
					})
				}, 1000 );
	        });
    	});
		
		
		function ShowProgressAnimation() {
		    var pleaseWaitDialog = $("#progress").dialog(
		    	{
			    resizable: false,
			    height: 'auto',
			    width: 250,
			    modal: true,
			    closeText: '',
			    bgiframe: true,
			    closeOnEscape: true,
			    open: function(type, data) {
					$(this).parent().appendTo($('body'));
						$('body').css('overflow', 'auto'); //IE scrollbar fix for long checklist templates
			    }
		    });
		    }
		
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
	            	<li class="menuitem"><a href="ListEstimationsServlet">Ver Presupuestos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute; text-align: left;">	
	        	<h2>Crear Presupuesto:</h2><br><br> 
				<!-- Recordar que sino se consigue al cliente, se debe mostrar una ventana para indicarlo
				     y verificar si se desea crear el usuario (mostrar deleteVitalSign) -->
				<form id="form-create" method="post" action="CreateEstimationServlet">
					<input type="hidden" id="patientID" name="patientID" value="" />
					<input type="hidden" id="txtCedNumber" name="txtCedNumber" value=""/>
					<input type="hidden" id="txtName" name="txtName" value=""/>
					<input type="hidden" id="txtLastName" name="txtLastName" value=""/>
					<input type="hidden" id="function" name="function" value="estimationForm"/>
					<fieldset class="bigger">
						<label>Escoja el tipo de paciente:</label>
						<select name="patientType" class="target" id="target">
							<option value="1">Adulto</option>
							<option value="0">Pedi&aacute;trico</option>
						</select><br><br><br>
						<label id="info-title">Ingrese el número de cédula de identidad del paciente:</label>
						<select id="txtCedId" name="txtCedId">
							<option value="V-" >V</option>
							<option value="E-" >E</option>
						</select> 
						<input id="txtCedIdNum" name="txtCedIdNum" type="text">
						<input type="button" id="submit" value="Buscar" />
						<input type="submit" id="submit-form" value="" style="display:none;" />
					</fieldset>
					<div id="botonera" style="width:100px; margin-top: 200px;">
						<a id="go" rel="leanModal" href="#deleteVitalSign" style="display: none;"></a> 
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>		
					</div>	
				</form>
			</div>
		</div>
		<div id="progress" style="text-align: center; display: none;">
			<img src="./images/loader.gif" style="margin-right: 5px; width: 20px;" /><br/><br/>
			<span>Por favor, espere...</span>
		</div>
		
		
		
		<div id="deleteVitalSign">
			<div id="signup-ct">
				<form action="CreatePatientServlet" method="post">
				<h3 id="see_id" class="sprited" > Paciente Inexistente</h3>
				<br><br>
				<span style="font-size: 16px; text-align: center;">El paciente indicado no se encuentra registrado en el sistema. ¿Desea agregarlo? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="txtCedIdHidden"    	name="txtCedId"   class="good_input" value=""/>
				<input type="hidden" id="txtCedIdNumHidden" 	name="txtCedIdNum"   class="good_input" value=""/>
				<input type="hidden" id="txtPatientTypeHidden" 	name="txtPatientType"   class="good_input" value=""/>
				<input type="hidden" name="f"  class="good_input" value="estimation"/>
				<input type="hidden" name="submit"  value="find"/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"  name="sbmtButton" value="Aceptar"  />
				</div>
				</form>
			</div>
		</div>
	</body>
</html>