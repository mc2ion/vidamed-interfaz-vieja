<%@page import="domain.Protocol"%>
<%@page import="domain.BedLocation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.MedicalTreatment"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	MedicalTreatment med = (MedicalTreatment) request.getAttribute("medical");
	
	@SuppressWarnings("unchecked")
	ArrayList<BedLocation> locations = (ArrayList<BedLocation>) request.getAttribute("locations");
	
	@SuppressWarnings("unchecked")
	ArrayList<Protocol> protocols = (ArrayList<Protocol>) request.getAttribute("protocols");
	
	String info_text = "";
	String info = (String) session.getAttribute("info");
	if (info != null ){
		info_text = info;
	}
	session.removeAttribute("info");
	
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
		<script type="text/javascript">
		$(document).ready(function() {
			var isNew = 1;
			$( ".target" ).change(function() {
			
				index = $(this).val();
				if (index != "-"){
					bid = '<%= med.getBed().getId()%>';
					lid = '<%= med.getLocation().getId()%>';
					eid = '<%= med.getId()%>' ;
					$.ajax({
						type: "GET",
						url: "GetBedsServlet",
						data: {locationId: index, estimationId: eid },
						success: function(data){
							$("#bed").html(data);
							if (isNew == 1 || index == lid) {$("#bed").val(bid); isNew = 0; }
						}
					});
					$('#beds').show();
				}else{
					$('#beds').hide();
				}
			});	
			$(".target").change();			
		});

		
		
		function occupiedBed(){
			bedId = $("#bed").val();
			$.ajax({
				type: "GET",
				url: "SetBedOccupationServlet",
				data: {bedId: bedId },
				success: function(data){
					if (data == "-1"){
						$("#error-bed").show();
						return false;
					}
					$("#bForm").submit();
				}
			});
			
		}
	</script>
	<script>
		$(function() {
			$( "#tabs" ).tabs();
			$('#tabs').tabs( "option", "active", window.location.hash );
			//$("#tabs").tabs("select", window.location.hash);
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
	            	<li class="menuitem"><a href="ListMedicalTreatmentsServlet">Ver Tratamientos Médicos</a></li>
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
  						<form action='EditMedicalTreatmentServlet' method="post">
  						<input type="hidden" name="admissionId" value="<%= med.getId() %>"/> 
					   <fieldset>
					    <br>
					    <label>Cédula:</label><%= med.getPatient().getIdentityCard() %><br><br>
					   	<label>Nombre:</label><%= med.getPatient().getFirstName() + " " + med.getPatient().getLastName() %><br><br>
					    <label>Fecha de Ingreso:</label><%= med.getAdmissionDate() %><br><br>
					   	<label>Ubicación:  </label> 
								<select id="bedLocationId" name="bedLocationId" class="target">
									<option value="-" >Seleccionar</option>
									<% for (int i=0; i< locations.size(); i++){
										BedLocation l = locations.get(i);
									%>
										<option value="<%= l.getId() %>" <%= (l.getId() == med.getLocation().getId()) ? "selected" : "" %>><%= l.getName() %></option>
									<% } %>
								</select><br/><br/>
								<p style="display: none;" id="beds">
								<label for="pname">Cama:</label>
									<select name="bed" id="bed">
										<option value="-">Seleccionar</option>
										<option value="<%= med.getBed().getId()%>" selected><%= med.getBed().getName()%></option>
									</select><br/><br/>
								</p>  
								<p style="display: none; color: red;" id="error-bed">
									Disculpe, la cama que escogió ya fue seleccionada por otro usuario. Por favor, elija una cama diferente.
								</p> 
							</fieldset>
					    	<div id="botonera">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>	
							</div>
						
					   <br>
					   </form>
  					</div>
  					<div id="tabs-2">
  						<div style="text-align:right;">
	  						<a href="AddAdmissionProtocolServlet?function=editMedicalT&id=<%= med.getEstimationId()%>&adminId=<%= med.getId() %>" style="color: #006c92; font-weight: bold;">
								<img alt="logo" src="./images/add.png" height="12" width="12" />Agregar Protocolo
							</a>						
  						</div>
  						<br>
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
					   		<% if (protocols != null && protocols.size()> 0) { %>
			   				<thead>
						   		<tr style="background: rgb(136, 162, 190);">
						   			<th>Nombre</th>
						   			<th>Total</th>
						   			<th>Acción</th>
						   		</tr>
						   	</thead>
						   	<tbody>
						   	<%	for (int i=0; i< protocols.size(); i++){
									Protocol p = protocols.get(i);
								%>
								<tr>
						   			<td><%= p.getName() %></td>
						   			<td><%= p.getTotalWithPercentage()==null ? p.getTotal() : p.getTotalWithPercentage() %></td>
						   			<td>
										<a href="ShowProtocolEstimationDetailServlet?protocolID=<%= p.getProtocolID() %>&estimationID=<%= med.getEstimationId() %>&n=<%= p.getName() %>&fnc=med" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
										</a>
									</td>
						   		</tr>
						   		<% } %>
						   	</tbody>
						   	<% } %>
					   	</table>
					</div>
  				</div>
			</div>
		</div>
	</body>
</html>