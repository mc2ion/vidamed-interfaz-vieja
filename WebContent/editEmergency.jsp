<%@page import="domain.Protocol"%>
<%@page import="domain.Unit"%>
<%@page import="domain.BedLocation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%@page import="domain.Emergency"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	Emergency emergency = (Emergency) request.getAttribute("emergency");
	
	String action = (String) request.getAttribute("action");
	
	@SuppressWarnings("unchecked")
	ArrayList<BedLocation> locations = (ArrayList<BedLocation>) request.getAttribute("locations");
	
	@SuppressWarnings("unchecked")
	ArrayList<Unit> sArea = (ArrayList<Unit>)request.getAttribute("units");
	
	@SuppressWarnings("unchecked")
	ArrayList<Protocol> protocols = (ArrayList<Protocol>) request.getAttribute("protocols");
	
	String info_text = "";
	String info = (String) session.getAttribute("info");
	if (info != null ){
		info_text = info;
	}
	session.removeAttribute("info");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Emergencia</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript"  src="./js/jquery.leanModal.min.js"></script>
		<script type="text/javascript">
		var idUser;

		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x, .buttonPopUpClose" });		
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
			var isNew = 1;
			var isNew2 = 1;
			
			$( ".target" ).change(function() {
			
				index = $(this).val();
				if (index != "-"){
					bid = '<%= emergency.getBed().getId()%>';
					lid = '<%= emergency.getLocation().getId()%>';
					eid = '<%= emergency.getId()%>' ;
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

			$( ".target2" ).change(function() {
				index = $(this).val();
				if (index != "-"){
					eid = '<%= emergency.getSpecialist().getId() %>';
					uid = '<%= emergency.getUnit().getUnitID() %>';
					$('.sum-div').show();
					$.ajax({
						type: "GET",
						url: "GetSpecialistServlet",
						data: {unit: index },
						success: function(data){
							$("#state").html(data);
							if (isNew2 == 1 || index == uid) {$("#state").val(eid); isNew2 = 0;}
						}
					});
				}
			});

			$(".target2").change();	
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
			var ac = '<%= action %>';
			
			if(ac == 'ep'){
				$('#tabs').tabs( "option", "active", 1 );
			} else {
				$('#tabs').tabs( "option", "active", window.location.hash );
			}
		});
	</script>
	
	<script type="text/javascript">
	var eId;
	var pId;
	var aId;
	
	function loadVarsEdit(var1, var2, var3, var4) {
		eId = var1;
		pId = var2;	
		aId = var4;
		$('#diagnosis').val(var3);
	};
	
	function setVEdit(f){
		f.elements['eId'].value = eId;
		f.elements['pId'].value = pId;
		f.elements['aId'].value = aId;
		return true;
	}
	</script>
	<script>
			$(function() {    
            	$('#sbmtButton').click(function(event) { 
            		if($('#unitId').val() == '-') {
            			alert("Debe seleccionar la unidad del Especialista.");
            			return;
            		}
            		if($('#state').val() == '-' || $('#state').val() == '') {
            			alert("Debe seleccionar un Médico Tratante.");
            			return;
            		}
            		if($('#bedLocationId').val() == '-') {
            			alert("Debe seleccionar una Ubicación.");
            			return;
            		}
            		if($('#bed').val() == '-') {
            			alert("Debe seleccionar una cama.");
            			return;
            		}
            		$('#form1').submit();
            	});
			});
        </script>
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	<img alt="logo" src="./images/logo.png"/>
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
	        	<h2>Editar Emergencia:</h2>
				<br>
				<div class="info-text"><%= info_text %></div>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
			  		</ul>
  					<div id="tabs-1">
  						<form id="form1" name="form1" action='EditEmergencyServlet' method="post">
  						<input type="hidden" name="admissionId" value="<%= emergency.getId() %>"/> 
					   <fieldset>
					    <br>
					    <label>Cédula:</label><%= emergency.getPatient().getIdentityCard() %><br><br>
					   	<label>Nombre:</label><%= emergency.getPatient().getFirstName() + " " + emergency.getPatient().getLastName() %><br><br>
					    <label>Fecha de Ingreso:</label><%= emergency.getAdmissionDate() %><br><br>
					    <label>Unidad del Especialista: </label>
						<select name="unitId" id="unitId" class="target2">	
							<option value="-"> Seleccionar </option>
							<% for (int i = 0; i < sArea.size(); i++){ 
							%>
								<option value="<%= sArea.get(i).getUnitID() %>" <%= (emergency.getUnit().getUnitID() == sArea.get(i).getUnitID() ) ? "selected" : "" %>><%= sArea.get(i).getName() %></option>
							<% } %>
						</select><br/><br/>
						<p class="sum-div">
							<label for="pname">Médico Tratante:</label>
							<select name="specialist" id="state">
								<option value="-">Seleccionar</option>
							</select><br/><br/>
						</p>   
					   	<label>Ubicación:  </label> 
								<select id="bedLocationId" name="bedLocationId" class="target">
									<option value="-" >Seleccionar</option>
									<% for (int i=0; i< locations.size(); i++){
										BedLocation l = locations.get(i);
									%>
										<option value="<%= l.getId() %>" <%= (l.getId() == emergency.getLocation().getId()) ? "selected" : "" %>><%= l.getName() %></option>
									<% } %>
								</select><br/><br/>
								<p style="display: none;" id="beds">
								<label for="pname">Cama:</label>
									<select name="bed" id="bed">
										<option value="-">Seleccionar</option>
										<option value="<%= emergency.getBed().getId()%>" selected><%= emergency.getBed().getName()%></option>
									</select><br/><br/>
								</p>  
								<p style="display: none; color: red;" id="error-bed">
									Disculpe, la cama que escogió ya fue seleccionada por otro usuario. Por favor, elija una cama diferente.
								</p> 
							</fieldset>
					    	<div id="botonera">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="button" class="button" id="sbmtButton" name="sbmtButton" value="Modificar" />
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
	  						<a href="AddAdmissionProtocolServlet?function=editEmergency&id=<%= emergency.getEstimationId()%>&adminId=<%= emergency.getId() %>" style="color: #006c92; font-weight: bold;">
								<img alt="logo" src="./images/add.png" height="12" width="12" />Agregar Protocolo
							</a>						
  						</div>
  						<br>
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
					   		<% if (protocols != null) { %>
			   				<thead>
						   		<tr style="background: rgb(136, 162, 190);">
						   			<th>Nombre</th>
						   			<th>Diagn&oacute;stico</th>
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
						   			<td><%= p.getDiagnosis() %></td>
						   			<td><%= p.getTotalWithPercentage()==null ? p.getTotal() : p.getTotalWithPercentage() %></td>
						   			<td>
										<a href="ShowProtocolEstimationDetailServlet?protocolID=<%= p.getProtocolID() %>&estimationID=<%= emergency.getEstimationId() %>&n=<%= p.getName() %>&fnc=emergency" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
										</a>
										<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVarsEdit('<%= emergency.getEstimationId() %>','<%= p.getProtocolID() %>', '<%= p.getDiagnosis() %>', '<%= emergency.getId() %>');" >
											<img alt="logo" src="./images/edit.png" height="16" width="16" title="Editar Diagnóstico"/>
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
		<div id="deleteUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Editar Diagn&oacute;stico</h3>
				<br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="EditDiagnosisServlet" method="post"  onsubmit="return setVEdit(this)">
					<input type="hidden" id="eId" class="good_input" name="eId"  value=""/>
					<input type="hidden" id="pId" class="good_input" name="pId"  value=""/>
					<input type="hidden" id="aId" class="good_input" name="aId"  value=""/>
					<label>Diágnostico:</label>
					<textarea name="diagnosis" id="diagnosis" style="width:285px; height:70px;"></textarea>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Editar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="deleteProtocol">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Protocolo</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el protocolo '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"  name="sbmtButton" value="Aceptar"  />
				</div>
			</div>
		</div>
		<div id="deleteService">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Servicio</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el servicio '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"  name="sbmtButton" value="Aceptar"  />
				</div>
			</div>
		</div>
		<div id="deleteSupply">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Suministro</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el suministro '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"  name="sbmtButton" value="Aceptar"  />
				</div>
			</div>
		</div>
	</body>
</html>