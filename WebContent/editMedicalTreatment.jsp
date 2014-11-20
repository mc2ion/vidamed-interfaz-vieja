<%@page import="domain.MedicalTreatment"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	MedicalTreatment med = (MedicalTreatment) request.getAttribute("medical");
	String text_result = (String) session.getAttribute("text");
	if (text_result == null)
		text_result = "";
	session.removeAttribute("text");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Ver Tratamiento M&eacute;dico</title>
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
	            	<li class="menuitem"><a href="ListEmergenciesServlet">Ver Emergencias</a></li>
	              </ul>	
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Tratamiento M&eacute;dico:</h2>
				<br>
				<div class="info-text"><%= text_result %></div>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					</ul>
  					<div id="tabs-1">
  						<div class="leftColumS"><b>Cédula: </b></div><%= med.getPatient().getIdentityCard() %><br>
					   	<div class="leftColumS"><b>Nombre:</b></div><%= med.getPatient().getFirstName() + " " + med.getPatient().getLastName() %><br>
					    <div class="leftColumS"><b>Fecha de Ingreso:</b></div><%= med.getAdmissionDate() %><br>
					    <div class="leftColumS"><b>Ubicación:</b></div>
					    <input type="text" name="ubication" id="ubication" value="<%= med.getLocation().getName() %>" readonly><br>
					    <div class="leftColumS"><b>Cama:</b></div> 
					    <input type="text" name="bedId" id="bedId" value="<%= med.getBed().getName() %>" readonly>
					    <a href="SearchBedsServlet?function=editMedicalTreatment&id=<%= med.getId() %>&bN=<%= med.getBed().getName() %>&lN=<%= med.getLocation().getName()%>" style="color: #f7941e; font-weight: bold;">
							<input type="button"id="bedUbication"  style="margin-top: -25px;" value="Cambiar" >
						</a> <br><br>
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
									<a href="ShowProtocolEmergencyDetailServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
					   		</tr>
					   		<tr>
					   			<td>Apendicectomía</td>
					   			<td>Bs. 7680,00</td>
					   			<td>
									<a href="ShowProtocolEmergencyDetailServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
					   		</tr>
					   	</table>
					</div>
  				</div>
				<div id="botonera">
					<form action="PrintEmergencyServlet">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" />
						</div>	
						<div id="botonV" style="display: inline;">
								<a href="./ListMedicalTreatmentsServlet" class="button">Regresar</a>	
						</div>	
					</form>
				</div><br>
			</div>
		</div>
	</body>
</html>