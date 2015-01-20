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
		
		var obj ;
			
				
		function getValues() {
			id = $('input[type="radio"]:checked').val();
			$.each(obj, function(i, v) {
				if (v.patientID == id) {
					var patientId = v.patientID;
					var ced 	  = v.identityCard;
					var name 	  = v.firstName;
					var lastname  = v.lastName;
					$("#patientID").val(patientId);
					$("#txtCedNumber").val(ced);
					$("#txtName").val(name);
					$("#txtLastName").val(lastname);
					$("#submit-form").click();
				}
			});
		};
		
		$(document).ready(function() {
			$( ".target" ).change(function() {
			  if( $(this).find(":selected").text() == "Pediátrico"){
				$("#info-title").text("Cédula de identidad de algún representante legal:");
			  }else
				$("#info-title").text("Cédula de identidad del paciente:");
				
			});
			$('#txtCedIdNum').keypress(function (e) {
				if (e.which == 13) {
				 $('#submit').click();
				 e.preventDefault();
			   }
			});
		
			// AJAX
	        $('#submit').click(function(event) {  
	        	ShowProgressAnimation();
				setTimeout( function(){ 
					var txtCedIdNum	= $('#txtCedIdNum').val();
					var patientType	= $('#target option:selected').val();
					var txtCedId	= $("#txtCedId option:selected").val();
	        		var isAdult     = $("#target option:selected").val();
					
					$.get('SearchPatientServlet', {patientType: patientType, txtCedId: txtCedId , txtCedIdNum: txtCedIdNum}, 
					function(responseText) { 
						$('#progress').dialog('close');
						//Cliente no encontrado
						if (responseText == "not found") {
							if (isAdult == 0){ $('.msg').hide(); $('.msg2').show(); }
						
							//Paso los datos para que no deban escribirlos de nuevo
							$("#txtCedIdHidden").val(txtCedId);
							$("#txtCedIdNumHidden").val(txtCedIdNum);
							$("#txtPatientTypeHidden").val(patientType);
							$("#go").click();
						}
						//Cliente encontrado
						else{
							var json = JSON.stringify(eval("(" + responseText + ")"));
							obj = JSON.parse(json);
							if (obj[0].patientID == -3){
								$("#go2").click();
								return;
							}
							if (isAdult == 1){
								var patientId = obj[0].patientID;
								var ced 	  = obj[0].identityCard;
								var name 	  = obj[0].firstName;
								var lastname  = obj[0].lastName;
								$("#patientID").val(patientId);
								$("#txtCedNumber").val(ced);
								$("#txtName").val(name);
								$("#txtLastName").val(lastname);
								$("#submit-form").click();
							}
							else{
								$('.patients').html("");
								text = "<h2 style='font-size:18px;'>Escoja el paciente o cree uno nuevo:</h2><br/>";
								text += "<form id='ptsub'><table class='sweetTable'><tr><td>Id</td><td>Nombre Paciente</td><td style='width:12%;'>Seleccionar</td></tr>";
								var textAux = "";
								$.each(obj, function(i, item) {
									textAux = textAux + "<tr><td>" + obj[i].patientID + "</td><td><span class='pname'>" + obj[i].firstName + " " + obj[i].lastName + "</span></td><td style='text-align:center;'><input name='id' class='pt' type='radio' value='"+obj[i].patientID +"'/></td></tr>";
									/*alert(obj[i].firstName);*/
								});
								text += textAux;
								text += "</table><input type='button' onclick='getValues();' value='Escoger' style='float:right; margin-top:10px;'></form>";
								text += "<form action='CreatePatientServlet' method='post' style='float: right;margin-top: 10px;margin-right: 10px;'>";
								text +=	'<input type="hidden" id="txtCedIdHidden" name="txtCedId" class="good_input" value="'+txtCedId+'">';
								text +=		'<input type="hidden" id="txtCedIdNumHidden" name="txtCedIdNum" class="good_input" value="'+txtCedIdNum+'">';
								text +=		'<input type="hidden" id="txtPatientTypeHidden" name="txtPatientType" class="good_input" value="'+patientType+'">';
								text +=		'<input type="hidden" name="f" class="good_input" value="estimation">';
								text +=		'<input type="hidden" name="submit" value="find">';
								text +='<div class="btn-fld">';
								text +=	'<input type="submit" name="sbmtButton" value="Crear nuevo paciente" style="background: rgb(255, 212, 77);">';
								text +='</div>';
								text +='</form>';
								form = $(text);
								$('.patients').append(form);
							}
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
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListEstimationsServlet">Ver Presupuestos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
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
					<input type="hidden" id="function" name="function" value="estimation"/>
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
						<input id="txtCedIdNum" name="txtCedIdNum" type="text" >
						<input type="button" id="submit" value="Buscar" />
						<input type="submit" id="submit-form" value="" style="display:none;" />
					</fieldset>
					<div class='patients'></div>
					<div id="botonera" style="width:100px; margin-top: 200px;">
						<a id="go" rel="leanModal" href="#deleteVitalSign" style="display: none;"></a> 
						<a id="go2" rel="leanModal" href="#printUser" style="display: none;"></a> 
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
		<div id="printUser">
			<div id="signup-ct">
				<form action="CreatePatientServlet" method="post">
				<h3 id="see_id" class="sprited" >Paciente Admitido</h3>
				<br><br>
				<span style="font-size: 16px; text-align: center;">Disculpe, no puede continuar debido a que el paciente indicado ya se encuentra admitido en la clínica.</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				</form>
			</div>
		</div>
		
		
		<div id="deleteVitalSign">
			<div id="signup-ct">
				<form action="CreatePatientServlet" method="post">
				<h3 id="see_id" class="sprited" > Paciente Inexistente</h3>
				<br><br>
				<span class="msg" style="font-size: 16px; text-align: center;">El paciente y/o presupuesto indicado no se encuentra registrado en el sistema. ¿Desea agregarlo ahora? </span> 
				<span class="msg2" style="display:none; font-size: 16px; text-align: center;">El paciente indicado no se encuentra registrado en el sistema, o ya está admitido en la clínica. Le recomendamos buscar en el listado, antes de proceder a crearlo.
				¿Desea crear al paciente ahora? </span>
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