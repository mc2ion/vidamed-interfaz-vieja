<%@page import="domain.DischargeType"%>
<%@page import="domain.AdmissionReasons"%>
<%@page import="domain.PatientSupply"%>
<%@page import="domain.SupplyArea"%>
<%@page import="domain.SupplyForm"%>
<%@page import="domain.Supply"%>
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
	ArrayList<Admission> pp = (ArrayList<Admission>)request.getAttribute("pp");

	@SuppressWarnings("unchecked")
	ArrayList<AdmissionReasons> ar =  (ArrayList<AdmissionReasons>)request.getAttribute("ar");

	@SuppressWarnings("unchecked")
	ArrayList<DischargeType> dt = (ArrayList<DischargeType>)request.getAttribute("dt");
	
	String admisionId 		= (String)request.getAttribute("admisionId");
	String estimationId 	= (String)request.getAttribute("estimationId");
	String reasonid 		= (String) request.getAttribute("reasonid");
	String admissionfrom 	= (String)request.getAttribute("admissionfrom");
	String admissionto 		= (String)request.getAttribute("admissionto");
	String dischargetypeid 	= (String)request.getAttribute("dischargetypeid");
	String dischargefrom	= (String)request.getAttribute("dischargefrom");
	String dischargeto 		= (String)request.getAttribute("dischargeto");
	
	
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
	<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<script type="text/javascript">
		$(function() {
		    $( "#txtDateIni" ).datepicker({
		      changeMonth: true,
		      numberOfMonths: 1,
		      onClose: function( selectedDate ) {
		        $( "#txtDateEnd" ).datepicker( "option", "minDate", selectedDate );
		      },
			    showOn: "button",
				buttonImage: "images/calendar.png",
				buttonImageOnly: true,
				buttonText: "Seleccione una fecha",
				dateFormat:'dd/mm/yy',
				changeMonth: true,
			    changeYear: true
		    });
		    $( "#txtDateEnd" ).datepicker({
		      changeMonth: true,
		      numberOfMonths: 1,
		      onClose: function( selectedDate ) {
		        $( "#txtDateIni" ).datepicker( "option", "maxDate", selectedDate );
		      },
		      showOn: "button",
				buttonImage: "images/calendar.png",
				buttonImageOnly: true,
				buttonText: "Seleccione una fecha",
				dateFormat:'dd/mm/yy',
				changeMonth: true,
			    changeYear: true
		    });
		    $( "#txtDateIniR" ).datepicker({
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
			    $( "#txtDateEndR" ).datepicker({
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
			<h2>Reportes Admisión</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoja el módulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								     <option value="0">Seleccionar</option>
									<option value="1" >Usuarios</option>
									<option value="2" >Especialistas</option>
									<option value="3" >Responsables de Pago</option>
									<option value="4" >Farmacia - Admin</option>
									<option value="5" >Farmacia - Pacientes</option>
									<option value="6" >Banco de Sangre</option>
									<option value="7" >Ecosonografía</option>
									<option value="8" >Rayos X</option>
									<option value="9" >Laboratorio</option>
									<option value="10" >Interconsultas</option>
									<option value="11" >Descuentos</option>
									<option value="12" >Facturas</option>
									<option value="13" selected>Admisión</option>
									<option value="14" >Honorarios Médicos</option>
									<option value="15" >Libro de Ventas</option>
									<option value="16" >Facturación detallada</option>
									<option value="17" >An&aacute;lisis Vencimiento</option>
									<option value="18" >Relaci&oacute;n de Facturaci&oacute;n</option>
									<option value="19" >An&aacute;lisis Vencimiento Resumido</option>
									<option value="20" >Registros de Pacientes</option>
									<option value="21" >Insumos Facturados</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="ListAdmissionReportServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b># Admisión:</b></td><td>  <input type="text" name="admissionid" size="20" value="<%= (admisionId != null) ? admisionId : "" %>"></td>
									<td><b># Presupuesto :</b></td><td>  <input type="text" name="estimationid" size="20" value="<%= (estimationId != null) ? estimationId : "" %>"></td>
									<td><b>Motivo:</b></td><td>
									<select name="reasonid" style="width: 119px;">
										<option value="-"> Todos </option>
										<% for (int j = 0; j < ar.size(); j++){ 
											AdmissionReasons a = ar.get(j);
										%>
										<option value="<%= a.getId() %>" <%= ( String.valueOf(a.getId()).equals(reasonid)) ? "selected" : "" %> > <%= a.getName() %> </option>
										<% } %>
									</select></td>
								</tr>
								<tr>
								<td><b>Admisión Desde:</b></td><td><input  type="text" name="admissionfrom" id="txtDateIni" maxlength="50" size="20" value="<%= (admissionfrom != null) ? admissionfrom : "" %>" /></td>
								<td><b>Admisión Hasta:</b></td><td> <input  type="text" name="admissionto" id="txtDateEnd" maxlength="50" size="20" value="<%= (admissionto != null) ? admissionto : "" %>"/></td>
								<td><b>Tipo Alta:</b></td><td>
									<select name="dischargetypeid" style="width: 119px;">
										<option value="-"> Todos </option>
										<% for (int k=0; k < dt.size(); k++){ 
											DischargeType d = dt.get(k);
										%>
										<option value="<%= d.getId() %>" <%= ( String.valueOf(d.getId()).equals(dischargetypeid)) ? "selected" : "" %> > <%= d.getName() %> </option>
										<% } %>
									</select>
									</td>
								</tr>
								<tr>
								<td><b>Alta Desde:</b></td><td><input  type="text" name="dischargefrom" id="txtDateIniR" maxlength="50" size="20" value="<%= (dischargefrom != null) ? dischargefrom : "" %>" /></td>
								<td><b>Alta Hasta:</b></td><td> <input  type="text" name="dischargeto" id="txtDateEndR" maxlength="50" size="20" value="<%= (dischargeto != null) ? dischargeto : "" %>"/></td>
								<td></td>
								<td>
								<input type="submit" class="buttonGreen lessPadding"   style="float: right; margin-right:40px; margin-top: 5px;" value="Buscar">		
								</td>
								</tr>
							</table>	
							</fieldset>
  						</div>	
  						</form>
  						<div id="demo" style="display: block; height: 400px; overflow-y: scroll; margin-top:10px;">
								<table id="sweetTable" >
									<thead>
										<tr>
											<th># Admisión</th>
											<th># Presupuesto</th>
											<th>Fecha Admisión</th>
											<th>Tipo Alta</th>
											<th>Fecha Alta</th>
										</tr>
									</thead>
									<tbody>	
									<tbody>	
									<% 	if (pp != null && pp.size() > 0 ){
											for (int i = 0; i < pp.size(); i++){ 
											Admission us = pp.get(i); 
									%>
										<tr>
											<td><%= us.getAdmissionID() %></td>
											<td><%= us.getEstimationID() %></td>
											<td><%= us.getAdmissionDate() %></td>
											<td><%= (us.getDischargeName() != null)? us.getDischargeName(): "-" %></td>
											<td><%= (us.getDischargeDate() != null)? us.getDischargeDate(): "-" %></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="5" style="text-align: center;">No hay datos disponibles</td></tr>
									
									<% } %>	
									</tbody>
										
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