<%@page import="domain.Hospitalization"%>
<%@page import="domain.Protocol"%>
<%@page import="domain.PatientService"%>
<%@page import="domain.User"%>
<%@page import="java.util.ArrayList"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	Hospitalization hosp = (Hospitalization) request.getAttribute("hospitalization");
	
	@SuppressWarnings("unchecked")
	ArrayList<Protocol> protocols = (ArrayList<Protocol>) request.getAttribute("protocols");
	@SuppressWarnings("unchecked")
	ArrayList<PatientService> xRayServices = (ArrayList<PatientService>) request.getAttribute("xRayServices");
	@SuppressWarnings("unchecked")
	ArrayList<PatientService> bloodBankServices = (ArrayList<PatientService>) request.getAttribute("bloodBankServices");
	@SuppressWarnings("unchecked")
	ArrayList<PatientService> ecosonographyServices = (ArrayList<PatientService>) request.getAttribute("ecosonographyServices");
	@SuppressWarnings("unchecked")
	ArrayList<PatientService> labServices = (ArrayList<PatientService>) request.getAttribute("labServices");
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Ver Alta de Admisión</title>
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
	            	<li class="menuitem"><a href="ListAdmissionDischargesServlet">Ver Altas de Admisión</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Ver Alta de Admisión:</h2>
				<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					    <li><a href="#tabs-3">Rayos X</a></li>
					    <li><a href="#tabs-4">Banco de Sangre</a></li>
					    <li><a href="#tabs-5">Ecosonografía</a></li>
					    <li><a href="#tabs-6">Laboratorio</a></li>
					</ul>
  					<div id="tabs-1">
  						<div class="leftColumS"><b> Cédula: </b></div><%= hosp.getPatient().getIdentityCard() %><br>
					    <div class="leftColumS"><b>Nombre:</b></div><%= hosp.getPatient().getFirstName() + " " + hosp.getPatient().getLastName() %><br>
					    <div class="leftColumS"><b>Fecha de Ingreso:</b></div><%= hosp.getAdmissionDate() %><br>
					   <div class="leftColumS"> <b>Ubicación:</b></div><%= hosp.getLocation().getName() %><br>
					   <div class="leftColumS"> <b>Cama:</b></div><%= hosp.getBed().getName() %><br>
					   <div class="leftColumS"> <b>Médico Tratante:</b></div><%= hosp.getSpecialist().getFirstName() + " " + hosp.getSpecialist().getLastName() %><br>
					   <div class="leftColumS"><b>Unidad:</b></div><%= hosp.getUnit().getName() %><br>
					   <div class="leftColumS"><b> Responsable del Pago:</b></div><%= hosp.getResponsible().getName() %><br>
					   
  					</div>
  					<div id="tabs-2">
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
					   		<thead>
						   		<tr style="background: rgb(136, 162, 190);">
						   			<th>Nombre</th>
						   			<th>Total</th>
						   			<th>Acción</th>
						   		</tr>
						   	</thead>
						   	<tbody>
						   	<% if (protocols != null) {
								for (int i=0; i< protocols.size(); i++){
								Protocol p = protocols.get(i);
								%>
								<tr>
						   			<td><%= p.getName() %></td>
						   			<td><%= p.getTotalWithPercentage()==null ? p.getTotal() : p.getTotalWithPercentage() %></td>
						   			<td>
										<a href="ShowProtocolEstimationDetailServlet?protocolID=<%= p.getProtocolID() %>&estimationID=<%= hosp.getEstimationId() %>&n=<%= p.getName() %>&fnc=hospitalization" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
										</a>
									</td>
						   		</tr>
						   		<% }
								}
								%>
						   	</tbody>
					   	</table>
					</div>
					<div id="tabs-3">
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
					   		<thead>
						   		<tr style="background: rgb(136, 162, 190);">
						   			<th>Servicio</th>
						   			<th>Total</th>
						   		</tr>
						   	</thead>
						   	<tbody>
						   	<% if (xRayServices != null && xRayServices.size() != 0) {
								for (int i=0; i< xRayServices.size(); i++){
								PatientService ps = xRayServices.get(i);
								%>
								<tr>
						   			<td><%= ps.getServiceName() %></td>
						   			<td><%= ps.getServicePrice() %></td>
						   		</tr>
						   		<% }
								} else {
								%>
								<tr>
						   			<td colspan="2" style="text-align:center;">No hay datos disponibles en la tabla</td>
						   		</tr>
						   		<%}
								%>
						   	</tbody>
					   	</table>
					</div>
					<div id="tabs-4">
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
					   		<thead>
						   		<tr style="background: rgb(136, 162, 190);">
						   			<th>Servicio</th>
						   			<th>Total</th>
						   		</tr>
						   	</thead>
						   	<tbody>
						   	<% if (bloodBankServices != null && bloodBankServices.size() != 0) {
								for (int i=0; i< bloodBankServices.size(); i++){
								PatientService ps = bloodBankServices.get(i);
								%>
								<tr>
						   			<td><%= ps.getServiceName() %></td>
						   			<td><%= ps.getServicePrice() %></td>
						   		</tr>
						   		<% }
								} else {
								%>
								<tr>
						   			<td colspan="2" style="text-align:center;">No hay datos disponibles en la tabla</td>
						   		</tr>
						   		<%}
								%>
						   	</tbody>
					   	</table>
					</div>
					<div id="tabs-5">
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
					   		<thead>
						   		<tr style="background: rgb(136, 162, 190);">
						   			<th>Servicio</th>
						   			<th>Total</th>
						   		</tr>
						   	</thead>
						   	<tbody>
						   	<% if (ecosonographyServices != null && ecosonographyServices.size() != 0) {
								for (int i=0; i< ecosonographyServices.size(); i++){
								PatientService ps = ecosonographyServices.get(i);
								%>
								<tr>
						   			<td><%= ps.getServiceName() %></td>
						   			<td><%= ps.getServicePrice() %></td>
						   		</tr>
						   		<% }
								} else {
								%>
								<tr>
						   			<td colspan="2" style="text-align:center;">No hay datos disponibles en la tabla</td>
						   		</tr>
						   		<%}
								%>
						   	</tbody>
					   	</table>
					</div>
					<div id="tabs-6">
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
					   		<thead>
						   		<tr style="background: rgb(136, 162, 190);">
						   			<th>Servicio</th>
						   			<th>Total</th>
						   		</tr>
						   	</thead>
						   	<tbody>
						   	<% if (labServices != null && labServices.size() != 0) {
								for (int i=0; i< labServices.size(); i++){
								PatientService ps = labServices.get(i);
								%>
								<tr>
						   			<td><%= ps.getServiceName() %></td>
						   			<td><%= ps.getServicePrice() %></td>
						   		</tr>
						   		<% }
								} else {
								%>
								<tr>
						   			<td colspan="2" style="text-align:center;">No hay datos disponibles en la tabla</td>
						   		</tr>
						   		<%}
								%>
						   	</tbody>
					   	</table>
					</div>
  				</div>
				<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
								<a id="go" rel="leanModal" href="#dischargeUser" class="button" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= hosp.getId() %>,'<%= hosp.getPatient().getFirstName() + " " + hosp.getPatient().getLastName() %>');" >
								Dar de Alta
								</a>
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
				</div>	
			</div>
		</div>
		<div id="dischargeUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Alta de Admisión</h3>
				<br><br>
				<span>¿Está seguro que desea darle el alta de admisión a <span class="cliente"></span>? </span> <br><br>
				<span style="color: red; font-size: small; font-style: italic;">
					Recuerde que debe verificar los servicios de Rayos X, Laboratorio y Servicios Médicos del paciente antes de darle de alta.
				</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="SetAdmissionDischargeServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>