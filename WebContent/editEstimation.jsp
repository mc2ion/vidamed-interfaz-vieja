<%@page import="domain.Estimation"%>
<%@page import="domain.ClinicType"%>
<%@page import="domain.Unit"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.PaymentResponsible"%>
<%@page import="domain.User"%>
<%
	String txtCedNumber = (String) request.getAttribute("txtCedNumber");
	String patientID 	= (String) request.getAttribute("patientID" );
	String txtName 		= (String) request.getAttribute("txtName");
	String txtLastName 	= (String) request.getAttribute("txtLastName");
	
	Estimation est = (Estimation) request.getAttribute("est");
						
	@SuppressWarnings("unchecked")
	ArrayList<Unit> sArea = (ArrayList<Unit>)request.getAttribute("units");
	
	@SuppressWarnings("unchecked")
	ArrayList<PaymentResponsible> resp = (ArrayList<PaymentResponsible>)request.getAttribute("responsibles");
	
	@SuppressWarnings("unchecked")
	ArrayList<ClinicType> ct = (ArrayList<ClinicType>)request.getAttribute("clinic");

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
		$( document ).ready(function() {
			var isNew = 1;
			$( ".target" ).change(function() {
				index = $(this).val();
				if (index != "-"){
					$('.sum-div').show();
					specialist = '<%= est.getSpecialistId() %>';
					$.ajax({
						type: "GET",
						url: "GetSpecialistServlet",
						data: {unit: index },
						success: function(data){
							$("#state").html(data);
							if (isNew == 1) {$("#state").val(specialist); isNew = 0; }
						}
					});
				}
			});
			
			$(".target").change();
			
			
			
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
	        	
	        </div>  
	     	<jsp:include page="./upperMenu.jsp" />       
			<div id="menu">
			
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListEstimationsServlet">Ver Presupuestos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>           
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Editar Presupuesto:</h2>
				<br>
				<div>
					<form action="EditEstimationServlet" method="post">
					<input type="hidden" name="patientid" value="<%= est.getPatientId() %>" />
					<input type="hidden" name="estimationid" value="<%= request.getParameter("id") %>" />
					
					<h3 style='border-bottom: 1px solid; padding-bottom:5px;'>Información Básica</h3>
					<div>
  						<br>
					    <fieldset>
					  	<label> Cédula Paciente: </label> 
						<input type="text" name="identityCard" class="hidden" value="<%= est.getIdentityCard() %>" readonly /><br><br>
					    <label> Nombre Paciente: </label> 
						<input type="text" name="name" class="hidden" value="<%= est.getFirstName() + " " + est.getLastName() %>" readonly /><br><br>
						<label>Unidad del Especialista: </label>
						<select name="unitId" id="unitId" class="target">	
							<option value="-"> Seleccionar </option>
							<% for (int i = 0; i < sArea.size(); i++){ 
							%>
								<option value="<%= sArea.get(i).getUnitID() %>" <%= (est.getUnitId() == sArea.get(i).getUnitID()) ? "selected": "" %>><%= sArea.get(i).getName() %></option>
							<% } %>
						</select><br/><br/>
						<p class="sum-div">
							<label for="pname">Médico Tratante:</label>
							<select name="specialist" id="state">
								<option value="-">Seleccionar</option>
							</select><br/><br/>
						</p> 
						<label>Tipo de Clínica: </label>
						<div><%= est.getClinicName() %></div><br>
						<input type="text" style="display:none" name="clinicType" value="<%= est.getClinicTypeID() %>" />
						<label>Responsable de Pago: </label>
						<div><%= est.getPaymentResponsibleName() %></div>
						<input type="text" style="display:none" name="paymentId" value="<%= est.getPaymentResponsibleId() %>" />
						<br><br>
						<label> </label>
						<label style="font-weight: normal; width: auto"><input type="checkbox" id="aval" name="aval" value="1" <%= (est.getHasGuaranteeLetter() == 1) ? "checked": "" %> /> &iquest; El paciente tiene carta aval?</label><br><br>
						<label> </label>
						<label style="font-weight: normal; width: auto"><input type="checkbox" id="titular" name="titular" value="1" <%= (est.getIsPolicyHolder() == 1) ? "checked": "" %>  /> &iquest; Es el paciente el titular del seguro?</label><br><br>
						<% String display = "none"; if (est.getIsPolicyHolder() == 0)  display = "block"; %>
						<div id="div-3" style="display: <%= display %>;">
							<h2>Datos del titular:</h2><br><br>
							<label> Cédula Titular: </label> 
							<%
								String cedula  = est.getPolicyHolderIdentityCard();
								String pref = "";
								String c 	= "";
								if (cedula != null){
									String split[] = cedula.split("-");
									pref    = split[0];
									if (split.length == 2) c 	   = split[1];
								}
							%>
							<select name="cedIdTitular" id="cedula">
								<option value="V-" <%= (pref.equals("V")? "selected" : "") %>>V</option>
								<option value="E-" <%= (pref.equals("E")? "selected" : "") %>>E</option>
							</select>
							<input type="text" name="cedulaTitular" id="cedula" style="width: 194px; margin-left: 3px;" value="<%= c %>"><br><br>
							<label> Nombre Titular: </label>
							<input type="text" name="nameTitular" id="name" value="<%= (est.getPolicyHolderName() != null ) ? est.getPolicyHolderName() : "" %>" style="width: 234px;"><br><br>
						</div>
						</fieldset>
					 	<br>
					    
					</div>
					<div id="botonera" style="margin-top: -20px; width:400px;">
						<div id="botonP" style="display: inline; margin-right: 10px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Guardar y Salir" />
						</div>
						<div id="botonP" style="display: inline; margin-right: 10px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Editar Protocolos" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</div>
					<div>
						<br/><br/>
						<span class="help">Recuerde que una vez editado, si este presupuesto posee un descuento aprobado, será enviado nuevamente a verificación para que sea revisado y re-aprobado de acuerdo a los nuevos cambios.</span>
					</div>
				</form>
			</div>
		</div>
		</div>
	</body>
</html>