<%@page import="com.sun.xml.internal.ws.org.objectweb.asm.Label"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	String patientName 	= (String) request.getAttribute("txtFirstName");
	String lastName 	= (String) request.getAttribute("txtLastName");
	String identityCard = (String) request.getAttribute("identityCard");
	
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Admitir Paciente:</title>
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
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x, .buttonPopUpClose " });	
			
			$("#subAdmit").click(function() {
				$("#admitP").hide();
				$("#message").show();
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

			var first = getUrlVars()["insurance"];
			var bed = getUrlVars()["bed"];
			var ubication = getUrlVars()["bedLocationId"];
			var estimationId = getUrlVars()["id"];
		
			if (estimationId != null)
				$("#estimationId").val("154600");
			
			if (first != null){
				first = first.replace(/\+/g, ' ');
				$("#insuranceName").val(first);
			}
			
			if (bed != null){
				bed = bed.replace(/\+/g, ' ');
				$("#bedId").val(bed);
			}
			
			if (ubication != null){
				ubication = ubication.replace(/\+/g, ' ');
				$("#ubication").val(ubication);
			}
			
		});
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
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
			 <!-- OJO TODA ADMISION DEBE TENER PRESUPUESTO.. TENER ESO EN CUENTA
			 	COMO RESTRICCION PARA CREAR LA ADMISION
			  -->
        	<div id="content" style="position:absolute;">
        		<div id="admitP">
	        	<h2>Admitir Paciente:</h2>
				<br>
						 <form action="#">
						 	<fieldset>
							   <b>Cédula:</b> <span style="margin-left: 155px;"><%= identityCard %></span><br/><br/>
							   <b>Nombre: </b><span style="margin-left: 150px;"><%= patientName + " " + lastName %></span><br><br/>
							   <label> Responsable del Pago:</label>  <input type="text" name="insuranceName" id="insuranceName" value="" readonly>
							    <a href="SearchInsuranceServlet?function=admitPatient" style="color: #f7941e; font-weight: bold;">
									<input type="button"id="paymentResp" value="Cambiar" >
								</a> 
								<br><br>
					
							   <label> Motivo de la admisión:</label>
							   <select name="reasonAdmission" id="reasonAdmission" >
							   		<option value="h">Hospitalizaci&oacute;n</option>  
							   		<option value="e">Emergencia</option> 
							   		<option value="t">Tratamiento M&eacute;dico</option>   
							   </select><br/><br/>							    
							    <label> Ubicación:  </label>
								<input type="text" name="ubication" id="ubication" readonly><br><br>
								 
								<label> Cama:</label>  <input type="text" name="bedId" id="bedId"  readonly>
							    <a href="SearchBedsServlet?function=admitPatient" style="color: #f7941e; font-weight: bold;">
									<input type="button"id="bedUbication" value="Cambiar" >
								</a> <br><br>
						   
							   <label> Número de presupuesto:</label> 
							   	<input type="text" name="estimationId" id="estimationId" value="">
							    <a href="SearchEstimationServlet" style="color: #f7941e; font-weight: bold;" >
									<input type="button" value="Buscar" >
								</a>
								<a href="CreateEstimationServlet" style="color: #f7941e; font-weight: bold;" >
									<input type="button" value="Crear" >
								</a>
								<br><br>
								 <label> Observaciones:</label>  
								 <textarea name="observations" id="observations" ></textarea>
							   
								<br><br>
							</fieldset>
							<div id="botonV" style="position:relative;">
									<input type="button"  class="button" id="subAdmit"  name="sbmtButton" value="Aceptar" style="margin-left:30%; margin-top: 5px;"/>
									<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" style="margin-left:20px;" />		
							</div>	
				</form>
			</div>
			<div id="message" style="display:none; font-size: 24px; text-align: center; margin-top: 40px;">
				El paciente ha sido admitido sastifactoriamente. 
			</div>
			</div>
			
		</div>
		
		
	</body>
</html>