<%
	String txtCedNumber = (String) request.getAttribute("txtCedNumber");
	String patientID 	= (String) request.getAttribute("patientID" );
	String txtName 		= (String) request.getAttribute("txtName");
	String txtLastName 	= (String) request.getAttribute("txtLastName");
%>
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
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x, .buttonPopUpClose " });	
			
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
			
			function getUrlVars() {
			    var vars = {};
			    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
			        vars[key] = value;
			    });
			    return vars;
			}

			var first = getUrlVars()["insurance"];
			var doctor = getUrlVars()["doctor"];
			var departmentId = getUrlVars()["department"];
			
			if (first != null){
				first = first.replace(/\+/g, ' ');
				$("#insuranceName").val(first);
			}
			
			if (doctor != null){
				doctor = doctor.replace(/\+/g, ' ');
				$("#doctorName").val(doctor);
			}
			
			if (departmentId != null){
				$("#departament").val("Alergog�a");
			}
			
			$('#titular').change(function() {
		        if(!$(this).is(":checked")) {
		            $("#div-3").show();
		        }else
					 $("#div-3").hide();
		               
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
         		<li><a href="#">Bienvenido, <%= name %></a></li>
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
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>           
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Crear Presupuesto:</h2>
				<br>
				<a id="go" rel="leanModal" href="#discount" style="color: #f7941e; font-weight: bold;" onclick="return loadVars(1003,'1003');" >
					<input type="button" class="buttonGray lessPadding" value="Solicitar Descuento" style="position: absolute;top: 20px;right: 30px;"/>			
				</a>
				
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					</ul>
  					<div id="tabs-1">
  						<br>
					    <p>
					    <b> C�dula: </b> <%= txtCedNumber %>
					    <b style="margin-left: 60px;"> Nombre: </b> <%= txtName + " " + txtLastName %><br><br>
					    </p>
					    <fieldset>
					  	<label> Unidad: </label>
					    <input type="text" name="departament" id="departament" value="" readonly>
					    <br><br>
					   <label>M�dico Tratante: </label> <input type="text" name="doctorName" id="doctorName" readonly>
					    <a href="SearchDoctorServlet?function=createEstimation" style="color: #f7941e; font-weight: bold;">
							<input type="button"id="doctorId" value="Escoger" >
						</a> <br><br>
						<label> Responsable del Pago:</label>  <input type="text" name="insuranceName" id="insuranceName" readonly>
					    <a href="SearchInsuranceServlet?function=createEstimation" style="color: #f7941e; font-weight: bold;">
							<input type="button"id="paymentResp" value="Escoger" >
						</a> <br><br>
						<input type="checkbox" id="aval" value="1" /> &iquest; El paciente tiene carta aval?<br><br>
						<input type="checkbox" id="titular" value="1" checked /> &iquest; Es el paciente el titular del seguro?<br><br>
						<div id="div-3" style="display: none;">
							Datos del titular:<br><br>
							<label> C�dula Titular: </label> 
							<select id="cedula">
								<option value="V-">V</option>
								<option value="E-">E</option>
							</select><input type="text" name="cedula" id="cedula" value="" style="width: 227px;"><br><br>
							<label> Nombre Titular: </label>
							<input type="text" name="name" id="name" value=""><br><br>
						</div>
					    </fieldset>
					 	<br>
					</div>
  					<div id="tabs-2">
  						<div style="text-align:right;">
	  						<a href="SearchProtocolsServlet?function=createEstimation" style="color: #006c92; font-weight: bold;">
								<img alt="logo" src="./images/add.png" height="12" width="12" />Agregar Protocolo
							</a>						
  						</div>
  						<br>
  						<br>
  						<table id="sweetTable">
							<tbody>
								<tr>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Acci�n</th>
								</tr>			
								<tr>
									<td id="columna a cambiars" colspan="3" style="text-align: center;">El paciente a�n no tiene ning�n prot�colo asignado</td>
								</tr>				
								
							</tbody>
						</table>
						<br>
					</div>
				</div><BR><BR>
  				
				  <div id="botonera" style="margin-top: -20px;">
					<form action="ListEstimationsServlet">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Crear" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</form>
				</div>
				
			</div>
		</div>
		<div id="deleteProtocol">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Protocolo</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar el protocolo '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"   name="sbmtButton" value="Aceptar"  />
				</div>
			</div>
		</div>
		<div id="deleteService">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Servicio</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar el servicio '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"  name="sbmtButton" value="Aceptar"  />
				</div>
			</div>
		</div>
		
		<div id="payment-resp">
			<div id="a">
				<h3 id="see_id" class="sprited" > Escoger responsable de pago</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar el servicio '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
				</div>
			</div>
		</div>
		<div id="discount">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Solicitar Descuento</h3><br><br>
				Por favor, indique la siguiente informaci�n.
				<div class="text">
					<div class="leftColum"><b>Descuento:</b></div>
						<select>
							<option value="P">%</option>
							<option value="Monto">Bs.</option>
						</select>
						<input type="text" size='10'/>
					<br>
					<div class="leftColum"><b>Justicaci�n:</b></div><textarea style="width: 138px;"></textarea><br>
				</div>
				<div id="signup-header">
					<a class="close_x" id="close_x_aux"  href="#"></a>
				</div>
				<form action="CreateEstimationServlet" method="post"  onsubmit="return setV(this)">
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpAux"  name="sbmtButton" value="Solicitar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>