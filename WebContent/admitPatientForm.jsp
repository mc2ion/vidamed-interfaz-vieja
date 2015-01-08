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
		<title>Admitir Paciente</title>
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
			
			// AJAX
        $('#submit').click(function(event) {  
			ShowProgressAnimation();
			setTimeout( function(){ 
				var txtCedIdNum	= $('#cedNumber').val();
				var patientType	= $('.target option:selected').val();
				var txtCedId	= $("#cedId option:selected").val();
				var isAdult     = $("#isAdult option:selected").val();
				var numPres		= $('#estimation').val();
					$.get('SearchPatientServlet', {patientType: patientType, txtCedId: txtCedId , 
												txtCedIdNum: txtCedIdNum, estimation: numPres}, function(responseText) { 
						$('#progress').dialog('close');
						if (responseText == "not found") {
							//Paso los datos para que no deban escribirlos de nuevo
							$("#txtCedIdHidden").val(txtCedId);
							$("#txtCedIdNumHidden").val(txtCedIdNum);
							$("#txtPatientTypeHidden").val(patientType);
							$("#txtNumEstimationHidden").val(numPres);
							$("#go").click();
						}
						//Cliente encontrado o presupuesto encontrado
						else{
							var json = JSON.stringify(eval("(" + responseText + ")"));
							obj = JSON.parse(json);
						
							if (isAdult){
								var estimationID = obj[0].estimationID;
								var patientId = obj[0].patientID;
								var ced 	  = obj[0].identityCard;
								var name 	  = obj[0].firstName;
								var lastname  = obj[0].lastName;
								/*var estimationId = obj[0].estimationID;
								var responsableId = obj[0].paymentResponsibleId;
								var responsableName = obj[0].responsibleName;*/
								
								$("#patientID").val(patientId);
								$("#txtCedNumber").val(ced);
								$("#txtName").val(name);
								$("#txtLastName").val(lastname);
								$("#estimationId").val(estimationID);
								
								//$("#estimationId").val(estimationId);
								//$("#responsableId").val(responsableId);
								//$("#responsableName").val(responsableName);
								$("#submit-form").click();
							}
							// Submit form
							//
						}
					});
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
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListAdmissionsServlet">Ver Admisiones</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Admitir Paciente:</h2><br><br>
	        	<!-- Recordar que sino se consigue al cliente, se debe mostrar una ventana para indicarlo
				     y verificar si se desea crear el usuario (mostrar deleteVitalSign) -->
				     
				<form action="AdmitPatientServlet" id="form-create" method="post" >
					<input type="hidden" id="patientID" name="patientID" value="" />
					<input type="hidden" id="txtCedNumber" name="txtCedNumber" value=""/>
					<input type="hidden" id="txtName" name="txtName" value=""/>
					<input type="hidden" id="txtLastName" name="txtLastName" value=""/>
					<input type="hidden" id="estimationId" name="estimationId" value=""/>
					<input type="hidden" id="responsableId" name="responsableId" value=""/>
					<input type="hidden" id="responsableName" name="responsableName" value=""/>
					<input type="hidden" id="function" name="function" value="admitPatientForm"/>
				
				
					<fieldset class="bigger">
						<label>Escoja el tipo de paciente:</label>
						<select class="target" id="isAdult">
							<option value="1">Adulto</option>
							<option value="0">Pedi&aacute;trico</option>
						</select><br><br><br>
						<div style="font-size: 14px;">Proporcione alguno de los siguientes datos: </div><br><br>
						<label id="info-title">C�dula de identidad del paciente:</label>
						<select id="cedId" name="cedId">
							<option value="V-" >V</option>
							<option value="E-" >E</option>
						</select> <input id="cedNumber" type="text"><br><br>
						<div> &oacute; </div><br/>
						<label>No. Presupuesto:</label>  <input id="estimation" type="text" style="width: 25%;">
					</fieldset>
					<div id="botonera" style="width:300px; margin-top: 50px;">
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>
						<div id="botonV" style="display: inline; margin-left: 20px;">
							<a id="go" rel="leanModal" href="#deleteVitalSign" style="display: none;"></a> 
							<input type="button" class="button" id="submit" value="Buscar" />
							<input type="submit" id="submit-form" name="admitPatientForm" value="" style="display:none;" />
						</div>							
					</div>	
				</form>
				
			</div>
		</div>
		
		<div id="deleteVitalSign">
			<div id="signup-ct">
				<form action="CreatePatientServlet" method="post">
				<h3 id="see_id" class="sprited" > Paciente Inexistente</h3>
				<br><br>
				<span style="font-size: 16px; text-align: center;">El paciente y/o presupuesto indicado no se encuentra registrado en el sistema. �Desea agregarlo ahora? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="txtCedIdHidden"    		name="txtCedId"   class="good_input" value=""/>
				<input type="hidden" id="txtCedIdNumHidden" 		name="txtCedIdNum"   class="good_input" value=""/>
				<input type="hidden" id="txtPatientTypeHidden" 		name="txtPatientType"   class="good_input" value=""/>
				<input type="hidden" id="txtNumEstimationHidden" 	name="txtNumEstimationHidden"   class="good_input" value=""/>
				<input type="hidden" name="f"  class="good_input"   value="admision" >
				<input type="hidden" name="submit"  value="find"/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"  name="sbmtButton" value="Aceptar"  />
				</div>
				</form>
			</div>
		</div>
		
		<div id="progress" style="text-align: center; display: none;">
			<img src="./images/loader.gif" style="margin-right: 5px; width: 20px;" /><br/><br/>
			<span>Por favor, espere...</span>
		</div>
		
	</body>
</html>