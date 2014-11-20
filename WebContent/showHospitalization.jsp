<%@page import="domain.Hospitalization"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	Hospitalization hosp = (Hospitalization) request.getAttribute("hospitalization");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Ver Hospitalización</title>
			<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
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
	            	<li class="menuitem"><a href="ListHospitalizationsServlet">Ver Hospitalizaciones</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Hospitalización:</h2>
				<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
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
					   		<tr style="background: rgb(136, 162, 190);">
					   			<td>Nombre</td>
					   			<td>Precio</td>
					   			<td>Acción</td>
					   		</tr>
							<tr>
					   			<td>Colocación de prótesis peneana</td>
					   			<td>Bs. 14321,00</td>
					   			<td>
									<a href="ShowProtocolHospitalizationDetailServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
					   		</tr>
					   		<tr>
					   			<td>Apendicectomía</td>
					   			<td>Bs. 7680,00</td>
					   			<td>
									<a href="ShowProtocolHospitalizationDetailServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
					   		</tr>
					   	</table>
					</div>
  				</div>
				<div id="botonera">
					<form action="PrintHospitalizationServlet">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>		
					</form>
				</div>	
			</div>
		</div>
	</body>
</html>