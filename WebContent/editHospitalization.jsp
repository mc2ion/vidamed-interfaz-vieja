<%@page import="domain.Protocol"%>
<%@page import="domain.Unit"%>
<%@page import="domain.BedLocation"%>
<%@page import="domain.PaymentResponsible"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Hospitalization"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	Hospitalization h = (Hospitalization) request.getAttribute("hospitalization");
	
	String text_result = (String) session.getAttribute("text");
	if (text_result == null)
		text_result = "";
	session.removeAttribute("info");
	
	@SuppressWarnings("unchecked")
	ArrayList<BedLocation> locations = (ArrayList<BedLocation>) request.getAttribute("locations");
	
	@SuppressWarnings("unchecked")
	ArrayList<PaymentResponsible> a = (ArrayList<PaymentResponsible>) request.getAttribute("paymentR");
	

	@SuppressWarnings("unchecked")
	ArrayList<Unit> sArea = (ArrayList<Unit>)request.getAttribute("units");
	
	@SuppressWarnings("unchecked")
	ArrayList<Protocol> protocols = (ArrayList<Protocol>) request.getAttribute("protocols");
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Hospitalización</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript"  src="./js/jquery.leanModal.min.js"></script>
		<script>
			$(function() {
				$("#tabs").tabs();
				$("#tabs").tabs({ active: window.location.hash });
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
				<script type="text/javascript">
		$(document).ready(function() {
			var isNew  = 1;
			var isNew2 = 1;
			
			$( ".target" ).change(function() {
			
				index = $(this).val();
				if (index != "-"){
					bid = '<%= h.getBed().getId()%>';
					lid = '<%= h.getLocation().getId()%>';
					eid = '<%= h.getId()%>' ;
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
					eid = '<%= h.getSpecialist().getId() %>';
					uid = '<%= h.getUnit().getUnitID() %>';
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
	        	<h2>Editar Hospitalización:</h2>
				<br>
				<div class="info-text"><%= text_result %> </div>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					</ul>
  					<div id="tabs-1">
  						<form action="EditHospitalizationServlet" method="post">
  						<input type="hidden" name="admissionId" value="<%= h.getId() %>"/> 
					  
							<fieldset>
						<%
							String patientName  = h.getPatient().getFirstName() + " " + h.getPatient().getLastName();
							String eName 		= h.getSpecialist().getFirstName() + " " + h.getSpecialist().getLastName();
						%>
						<label><b>Cédula:</b></label> <%= h.getPatient().getIdentityCard() %><br/><br/>
						<label><b>Nombre:</b></label> <%= patientName %><br/><br/>
						<label><b>Fecha de Ingreso:  </b></label><%= h.getAdmissionDate() %><br/><br/>
						<label>Unidad del Especialista: </label>
						<select name="unitId" id="unitId" class="target2">	
							<option value="-"> Seleccionar </option>
							<% for (int i = 0; i < sArea.size(); i++){ 
							%>
								<option value="<%= sArea.get(i).getUnitID() %>" <%= (h.getUnit().getUnitID() == sArea.get(i).getUnitID() ) ? "selected" : "" %>><%= sArea.get(i).getName() %></option>
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
								<option value="<%= l.getId() %>" <%= (l.getId() == h.getLocation().getId()) ? "selected" : "" %>><%= l.getName() %></option>
							<% } %>
						</select><br/><br/>
						<p style="display: none;" id="beds">
						<label for="pname">Cama:</label>
							<select name="bed" id="bed">
								<option value="-">Seleccionar</option>
							</select><br/><br/>
						</p>  
						<p style="display: none; color: red;" id="error-bed">
							Disculpe, la cama que escogió ya fue seleccionada por otro usuario. Por favor, elija una cama diferente.
						</p> 						

						</fieldset>
						  <div id="botonera" style="margin-top: -3px;">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<a href="./ListHospitalizationsServlet"  class="button" >Regresar</a>
								</div>	
							<br/>
						</div>
						</form>
					</div>
					<div id="tabs-2">
						<div style="text-align:right;">
	  						<a href="AddAdmissionProtocolServlet?function=editHospitalization&id=<%= h.getEstimationId() %>&adminId=<%= h.getId() %>" style="color: #006c92; font-weight: bold;">
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
										<a href="ShowProtocolEstimationDetailServlet?protocolID=<%= p.getProtocolID() %>&estimationID=<%= h.getEstimationId() %>&n=<%= p.getName() %>&fnc=hospitalization" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
										</a>
									</td>
						   		</tr>
						   		<% } %>
							 </tbody>
							 <%	} %>
						   	
					   	</table>
					</div>
					
  				</div>
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
				<form action="EditHospitalizationServlet#tabs-2" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="deleteUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Responsable de Pago</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el responsable de pago <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveEstimationPaymentRespServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<input type="hidden" id="function" class="good_input" name="function"  value="editHospitalization"/>
					<input type="hidden" id="eId" class="good_input" name="eId"  value="<%= h.getId() %>"/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
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
					<form action="EditHospitalizationServlet#tabs-3" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
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
				<form action="EditHospitalizationServlet#tabs-4" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>		
	</body>
</html>