<%@page import="domain.Emergency"%>
<%@page import="domain.Protocol"%>
<%@page import="domain.User"%>
<%@page import="java.util.ArrayList"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	Emergency emergency = (Emergency) request.getAttribute("emergency");
	
	@SuppressWarnings("unchecked")
	ArrayList<Protocol> protocols = (ArrayList<Protocol>) request.getAttribute("protocols");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Ver Emergencia</title>
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
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Ver Emergencia:</h2>
				<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					</ul>
  					<div id="tabs-1">
  						<div class="leftColumS"><b> C�dula: </b></div><%= emergency.getPatient().getIdentityCard() %><br>
					   	<div class="leftColumS"><b>Nombre:</b></div><%= emergency.getPatient().getFirstName() + " " + emergency.getPatient().getLastName() %><br>
					    <div class="leftColumS"><b>Fecha de Ingreso:</b></div><%= emergency.getAdmissionDate() %><br>
					    <div class="leftColumS"> <b>Ubicaci�n:</b></div><%= emergency.getLocation().getName() %><br>
					    <div class="leftColumS"> <b>Cama:</b></div><%= emergency.getBed().getName() %><br>
					</div>
  				<div id="tabs-2">
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
						   	<% if (protocols != null) { %>
								<thead>
						   		<tr style="background: rgb(136, 162, 190);">
						   			<th>Nombre</th>
						   			<th>Total</th>
						   			<th>Acci�n</th>
						   		</tr>
						   	</thead>
						   	<tbody>
						   <%  for (int i=0; i< protocols.size(); i++){
								Protocol p = protocols.get(i);
								%>
								<tr>
						   			<td><%= p.getName() %></td>
						   			<td><%= p.getTotalWithPercentage()==null ? p.getTotal() : p.getTotalWithPercentage() %></td>
						   			<td>
										<a href="ShowProtocolEstimationDetailServlet?protocolID=<%= p.getProtocolID() %>&estimationID=<%= emergency.getEstimationId() %>&n=<%= p.getName() %>&fnc=emergency" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
										</a>
									</td>
						   		</tr>
						   		<% } %>
						   	</tbody>
						   	<% }%>
					   	</table>
					</div>
  				</div>
				<div id="botonera">
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
				</div><br>
			</div>
		</div>
	</body>
</html>