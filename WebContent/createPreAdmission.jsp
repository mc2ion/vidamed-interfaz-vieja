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
		<title>Pre-Admitir Paciente:</title>
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
            		<li class="menuitem"><a href="ListPreAdmissionsServlet">Ver Pre-Admisiones</a></li>
           		 </ul>
		    	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">
        		<div id="admitP">
	        	<h2>Pre-Admitir Paciente:</h2>
				<br>
						 <form action="#">
						 	<fieldset>
							   <label>Cédula del Paciente:</label>
							   <select>
							   	<option value="V">V</option>
							   	<option value="E">E</option>
							   </select>
							   <input type="text" name="patientCed" id="patientCed" style="width:202px" >
							   <br><br>
							   <label>Nombre del Paciente:</label>
							   <input type="text" name="patientName" id="patientName" value="" >
							   <a href="#" style="color: #f7941e; font-weight: bold;">
									<input type="button"id="findPatient" value="Buscar Paciente" >
								</a>
							   <br><br/>
							   <label> Seguro:</label>  <input type="text" name="insuranceName" id="insuranceName" value="" readonly>
							    <a href="SearchInsuranceServlet?function=admitPatient" style="color: #f7941e; font-weight: bold;">
									<input type="button"id="paymentResp" value="Buscar" >
								</a> 
								<br><br>
					
							   <label> Médico Tratante:</label> <input type="text" name="reasonAdmission" id="reasonAdmission" value="" >
							    <a href="SearchDoctorServlet?function=preAdmitPatient" style="color: #f7941e; font-weight: bold;">
									<input type="button"id="doctor" value="Buscar" >
								</a> <br><br>
							    <label> Área:  </label>
								<input type="text" name="area" id="area"><br><br>
								 
								<label> Condición de Pago:</label>  
								<select>
								   	<option value="C">Contado</option>
								   	<option value="TDC">Tarjeta de Cr&eacute;dito</option>
								   	<option value="TDC">Cheque</option>
								</select><br><br>
						   
							   <label> Número de presupuesto:</label> 
							   	<input type="text" name="estimationId" id="estimationId" value="">
							    <a href="SearchEstimationServlet" style="color: #f7941e; font-weight: bold;" >
									<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Buscar" />
								</a><br><br>
							</fieldset>
							<div id="botonP">
										<input type="button"  class="button" id="subAdmit"  name="sbmtButton" value="Aceptar" style="margin-left:30%; margin-top: 5px;"/>
							</div>	
							
							<div id="botonV" style="position:relative; margin-left: 250px; top: -22px;">
									<input type="button" class="button" value="Regresar" style="margin-left:40%;" onClick="javascript:history.back();" style="margin-left:40%;" />		
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