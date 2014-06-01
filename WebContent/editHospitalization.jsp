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
	session.removeAttribute("text");
	
	@SuppressWarnings("unchecked")
	ArrayList<PaymentResponsible> a = (ArrayList<PaymentResponsible>) request.getAttribute("paymentR");
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
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Editar Hospitalización:</h2>
				<br>
				<div class="info-text"><%= text_result %> </div>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Responsables de Pago</a></li> 
					    <li><a href="#tabs-3">Protocolos</a></li>
					</ul>
  					<div id="tabs-1">
						<fieldset>
						<%
							String patientName  = h.getPatient().getFirstName() + " " + h.getPatient().getLastName();
							String eName 		= h.getSpecialist().getFirstName() + " " + h.getSpecialist().getLastName();
						%>
						<label><b>Cédula:</b></label> <%= h.getPatient().getIdentityCard() %><br/><br/>
						<label><b>Nombre:</b></label> <%= patientName %><br/><br/>
						<label><b>Fecha de Ingreso:  </b></label><%= h.getAdmissionDate() %><br/><br/>
						<label>Unidad: </label>
						   <input type="text" name="departament" id="departament" value="<%= h.getUnit().getName() %>" readonly>
							<br><br>
					   <label>Médico Tratante: </label> <input type="text" name="doctorName" id="doctorName" value="<%= eName %>" readonly>
						<a href="SearchDoctorServlet?function=editHospitalization&id=<%=h.getId()%>" style="color: #f7941e; font-weight: bold;">
							<input type="button"id="doctorId" value="Cambiar" >
						</a> <br><br>
						<label> Ubicación:  </label>
						<input type="text" name="ubication" id="ubication" value="<%= h.getLocation().getName() %>" readonly><br><br>
						 
						<label> Cama:</label>  <input type="text" name="bedId" id="bedId" value="<%= h.getBed().getName() %>" readonly>
							<a href="SearchBedsServlet?function=editHospitalization&id=<%= h.getId() %>&bN=<%= h.getBed().getName() %>&lN=<%= h.getLocation().getName()  %>" style="color: #f7941e; font-weight: bold;">
								<input type="button"id="bedUbication" value="Cambiar" >
							</a> <br><br>
						  </fieldset>
						  <div id="botonera" style="margin-top: -3px;">
							<form action="#">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<a href="./ListHospitalizationsServlet"  class="button" >Regresar</a>
								</div>	
							</form>
							<br/>
						</div>
					</div>
					<div id="tabs-2">
						<div style="text-align:right;">
	  						<a href="SearchInsuranceServlet?function=editHospitalization&id=<%= h.getId() %>" style="color: #006c92; font-weight: bold;">
								<img alt="logo" src="./images/add.png" height="12" width="12" />Agregar Responsable
							</a>						
  						</div><br/>
  						<table id="sweetTable" style="margin-bottom: 10px;">
				   			<tr>
									<th>Nombre</th>
									<th>Titular</th>
									<th>Carta Aval</th>
									<th>Acción</th>
								</tr>	
					   		<% if (a.size() > 0){ 
					   				for (int i = 0; i < a.size() ; i++){
					   					PaymentResponsible p = a.get(i);
					   					int gl = p.getHasGuaranteeLetter();
					   					String carta = "Si";
					   					if (gl == 0)
					   						carta = "No";
					   					
					   					int ph = p.getIsPolicyHolder();
					   					String titular = "Si";
					   					if (ph == 0)
					   						titular = "No";
					   				
					   		%>
					   		<tr>
					   				<td><%= p.getName() %></td>
					   				<td><%= titular %></td>
					   				<td><%= carta %></td>
					   				<td>
										<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(<%= p.getId() %>,'<%= p.getName()%>');" >
											<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
										</a> 
										<a href="EditEstimationPaymentResponsibleServlet?function=editHospitalization&estimationId=<%= h.getId()%>&pRid=<%= p.getId() %>" style="color: #f7941e; font-weight: bold;" >
											<img alt="logo" src="./images/edit.png" height="16" width="16" title="Editar"/>
										</a> 
									</td>
					   				
					   		</tr>
					   		<%  	}
					   			}else{ %>
							<tr>
					   				<td colspan="4"> No hay responsables de pago asociados </td>
							</tr>
					   		<% } %>	
					   		
					   	</table>
					</div>
  					<div id="tabs-3">
  						<div style="text-align:right;">
	  						<a href="SearchAdmissionServlet?function=editHospitalization" style="color: #006c92; font-weight: bold;">
								<img alt="logo" src="./images/add.png" height="12" width="12" />Agregar Protocolo
							</a>						
  						</div>
  						<br>
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
				   			<tr>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Acción</th>
								</tr>	
					   		<tr>
					   			<td>Colocación de prótesis peneana</td>
					   			<td>Bs. 14321,00</td>
					   			<td>
										<a id="go" rel="leanModal" href="#deleteProtocol" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(1001,'Colocación de prótesis peneana');" >
											<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
										</a> 
								</td>
					   		</tr>
					   		<tr>
					   			<td>Apendicectomía</td>
					   			<td>Bs. 7680,00</td>
					   			<td>
									<a id="go" rel="leanModal" href="#deleteProtocol" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(1001,'Apendicectomía');" >
											<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
									</a>
								</td>
					   		</tr>
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