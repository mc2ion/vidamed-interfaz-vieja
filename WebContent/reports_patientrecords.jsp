<%@page import="sun.font.EAttribute"%>
<%@page import="domain.PatientRecord"%>
<%@page import="domain.Admission"%>
<%@ page import="domain.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	int modSelect = 0;
	String modId = (String) request.getAttribute("modId");
	if (modId != null && !modId.equals(""))
		modSelect = Integer.valueOf(modId);
	
	@SuppressWarnings("unchecked")
	ArrayList<PatientRecord> mfList = (ArrayList<PatientRecord>)request.getAttribute("pp");

	String from 			= (String)request.getAttribute("from");
	String to 			= (String)request.getAttribute("to");
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Reportes</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	<script src="./js/jquery-1.9.1.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<script type="text/javascript">
		$(function() {
			$( "#from" ).datepicker({
		      changeMonth: true,
		      numberOfMonths: 1,
		      onClose: function( selectedDate ) {
		        $( "#txtDateEndR" ).datepicker( "option", "minDate", selectedDate );
		      },
			    showOn: "button",
				buttonImage: "images/calendar.png",
				buttonImageOnly: true,
				buttonText: "Seleccione una fecha",
				dateFormat:'dd/mm/yy',
				changeMonth: true,
			    changeYear: true
		    });
			$( "#to" ).datepicker({
		      changeMonth: true,
		      numberOfMonths: 1,
		      onClose: function( selectedDate ) {
		        $( "#txtDateIniR" ).datepicker( "option", "maxDate", selectedDate );
		      },
		      showOn: "button",
				buttonImage: "images/calendar.png",
				buttonImageOnly: true,
				buttonText: "Seleccione una fecha",
				dateFormat:'dd/mm/yy',
				changeMonth: true,
			    changeYear: true
		    });
		  });
		</script>
	<script type="text/javascript">
	var idUser;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2) {
		console.log('pase por aca');
		idUser = var1;
		$('.cliente').text(var2);
		$('#admId').attr('value', var1);
		$('#factId').attr('value', var2);			
	};
	
	function setV(f){
		//f.elements['userId'].value = idUser;
		return true;
	};
	
	function formatSelected(f){
		var opt = $('#formats').val();
		$('#printForm').attr('action', opt);
		return true;
	};
	</script>
	<style>
		fieldset input[type="text"]{ width: 75%;}
	</style>
	</head>
<body>
	<div id="container">
		<div id="header">
        	
        </div>         
      	<jsp:include page="./upperMenu.jsp" />        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
			<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content" style="min-height: 600px;">  
			<h2>Reporte Registros de Pacientes</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoja el m�dulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								     <option value="0">Seleccionar</option>
									<option value="1" >Usuarios</option>
									<option value="2" >Especialistas</option>
									<option value="3" >Responsables de Pago</option>
									<option value="4" >Farmacia - Admin</option>
									<option value="5" >Farmacia - Pacientes</option>
									<option value="6" >Banco de Sangre</option>
									<option value="7" >Ecosonograf�a</option>
									<option value="8" >Rayos X</option>
									<option value="9" >Laboratorio</option>
									<option value="10" >Interconsultas</option>
									<option value="11" >Descuentos</option>
									<option value="12" >Facturas</option>
									<option value="13" >Admisi�n</option>
									<option value="14" >Honorarios M�dicos</option>
									<option value="15" >Libro de Ventas</option>
									<option value="16" >Facturaci�n detallada</option>
									<option value="17" >An&aacute;lisis Vencimiento</option>
									<option value="18" >Relaci&oacute;n de Facturaci&oacute;n</option>
									<option value="19" >An&aacute;lisis Vencimiento Resumido</option>
									<option value="20" selected>Registros de Pacientes</option>
									<option value="21" >Insumos Facturados</option>
									<option value="22" >Insumos Pacientes</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="PatientRecordsReportServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la b�squeda por los siguientes par�metros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Ingreso Desde:</b></td><td><input  type="text" name="from" id="from" maxlength="50" size="20" value="<%= (from != null) ? from : "" %>" required /></td>
									<td><b>Ingreso Hasta:</b></td><td><input  type="text" name="to" id="to" maxlength="50" size="20" value="<%= (to != null) ? to : "" %>" required /></td>
								</tr>
							</table>	
							<input type="submit" class="buttonGreen lessPadding"   style="float: right; margin-right:40px; margin-top: 5px;" value="Buscar">
							</fieldset>
  						</div>	
  						</form>
  						<div id="demo" style="display: block; height: 300px; overflow-y: scroll; margin-top:10px;">
								<table id="sweetTable" >
									<thead>
										<tr>
											<th># Admisi&oacute;n</th>
											<th>Fecha de Ingreso</th>
											<th>Nombre y Apellido</th>
											<th>C&eacute;dula</th>
											<th>Edad</th>
											<th>Sexo</th>
											<th>Diagn&oacute;stico</th>
											<th>Tratamiento</th>
											<th>Tipo</th>
											<th>M&eacute;dico Tratante</th>
											<th>Ayudante 1</th>
											<th>Ayudante 2</th>
											<th>Anestesi&oacute;logo</th>
											<th>D�as de Hosp</th>
											<th>Fecha de Egreso</th>
										</tr>
									</thead>
									<tbody>		
									<% 	if (mfList != null && mfList.size() > 0 ){
											for (int i = 0; i < mfList.size(); i++){ 
											PatientRecord u = mfList.get(i); 
									%>
										<tr>
											<td><%= u.getAdmissionID() %></td>
											<td><%= u.getAdmissionDate() %></td>
											<td><%= u.getPatientName() %></td>
											<td><%= u.getIdentityCard() %></td>
											<td><%= u.getAge() %></td>
											<td><%= u.getGender() %></td>
											<td><%= u.getDiagnosis() %></td>
											<td><%= u.getProtocolName() %></td>
											<td><%= u.getType() %></td>
											<td><%= u.getAttendingSpecialist() %></td>
											<td><%= (u.getHelper1() != null) ? u.getHelper1() : "" %></td>
											<td><%= (u.getHelper2() != null) ? u.getHelper2() : "" %></td>
											<td><%= (u.getAnesthesiologist() != null) ? u.getAnesthesiologist() : "" %></td>
											<td><%= u.getRoomDays() %></td>
											<td><%= (u.getDischargeDate() != null) ? u.getDischargeDate() : "" %></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="15" style="text-align: center;">No hay datos disponibles</td></tr>
									
									<% } %>	
									</tbody>
								</table>
							</div>
					</div>
				</div>
				<div class="spacer"></div>
       		</div>
		</div>
	</body>
</html>