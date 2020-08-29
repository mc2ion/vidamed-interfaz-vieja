<%@page import="domain.PendingEstimationDiscount"%>
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
	ArrayList<PendingEstimationDiscount> mfList = (ArrayList<PendingEstimationDiscount>)request.getAttribute("pp");

	
	String estimationId 	= (String) request.getAttribute("estimationId");
	String identityCard 	= (String)request.getAttribute("identityCard");
	String gender 			= (String)request.getAttribute("gender");
	String isAdult 			= (String)request.getAttribute("isAdult");
	String type 			= (String)request.getAttribute("type");
	String requestFrom 		= (String)request.getAttribute("requestFrom");
	String requestTo 		= (String)request.getAttribute("requestTo");
	String isApproved 		= (String) request.getAttribute("isApproved");
	String reviewfrom		= (String)request.getAttribute("reviewfrom");
	String reviewto 		= (String)request.getAttribute("reviewto");
	
	
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
			<h2>Reportes Descuentos</h2>
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
									<option value="11" selected>Descuentos</option>
									<option value="12" >Facturas</option>
									<option value="13" >Admisión</option>
									<option value="14" >Honorarios Médicos</option>
									<option value="15" >Libro de Ventas</option>
									<option value="16" >Facturación detallada</option>
									<option value="17" >An&aacute;lisis Vencimiento</option>
									<option value="18" >Relaci&oacute;n de Facturaci&oacute;n</option>
									<option value="19" >An&aacute;lisis Vencimiento Resumido</option>
									<option value="20" >Registros de Pacientes</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="ListEstimationDiscountReportServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b># Estimación:</b></td><td>  <input type="text" name="estimationId" size="20" value="<%= (estimationId != null) ? estimationId : "" %>"></td>
									<td><b>Cédula Paciente :</b></td><td>  <input type="text" name="identityCard" size="20" value="<%= (identityCard != null) ? identityCard : "" %>"></td>
									<td><b>Sexo:</b></td>
									<td> 
									<select name="gender">
										<option value="-">Ambos</option>
										<option value="F" <%= (gender != null && gender.equals("F")) ? "selected" : "" %> >F</option>
										<option value="M" <%= (gender != null && gender.equals("M")) ? "selected" : "" %>>M</option>
									</select>
									</td>
								</tr>
								<tr>
								    <td><b>Paciente:</b></td><td>  
									<select name="isAdult">
										<option value="-">Ambos</option>
										<option value="1" <%= ( "1".equals(isAdult)) ? "selected" : "" %>>Adulto</option>
										<option value="0" <%= ( "0".equals(isAdult)) ? "selected" : "" %>>Infante</option>
									</select>
									</td>
									<td><b>Solicitado Desde:</b></td><td><input  type="text" name="requestFrom" id="txtDateIniR" maxlength="50" size="20" value="<%= (requestFrom != null) ? requestFrom : "" %>" /></td>
									<td><b>Solicitado Hasta:</b></td><td> <input  type="text" name="requestTo" id="txtDateEndR" maxlength="50" size="20" value="<%= (requestTo != null) ? requestTo : "" %>"/></td>
								</tr>
								<tr>
									<td><b>Tipo de Descuento:</b></td>
									<td>
									<select name="type">
										<option value="-">Ambos</option>
										<option value="P" <%= ( "P".equals(type)) ? "selected" : "" %>>%</option>
										<option value="M" <%= ( "M".equals(type)) ? "selected" : "" %>>Bs.</option>
									</select>
									</td>
									<td><b>Revisado Desde:</b></td><td><input  type="text" name="reviewfrom" id="txtDateIni" maxlength="50" size="20" value="<%= (reviewfrom != null) ? reviewfrom : "" %>" /></td>
									<td><b>Revisado Hasta:</b></td><td> <input  type="text" name="reviewto" id="txtDateEnd" maxlength="50" size="20" value="<%= (reviewto != null) ? reviewto : "" %>"/></td>
								</tr>
								<tr>
									<td><b>Aprobado:</b></td>
									<td>
									<select name="isApproved">
										<option value="-">Ambos</option>
										<option value="1" <%= ( "1".equals(isApproved)) ? "selected" : "" %>>Si</option>
										<option value="0" <%= ( "0".equals(isApproved)) ? "selected" : "" %>>No</option>
									</select>
									</td>
									<td></td><td></td><td></td>
									<td><input type="submit" class="buttonGreen lessPadding"   style="float: right; margin-right:40px; margin-top: 5px;" value="Buscar"></td>		
								</tr>
							</table>	
							</fieldset>
  						</div>	
  						</form>
  						<div id="demo" style="display: block; height: 400px; overflow-y: scroll; margin-top:10px;">
								<table id="sweetTable" >
									<thead>
										<tr>
											<th>Cédula</th>
											<th>Paciente</th>
											<th>Sexo</th>
											<th>Tipo Paciente</th>
											<th>Fecha Solicitud</th>
											<th>Justificación</th>
											<th>Estado</th>
											<th>Fecha Revisión</th>
											<th>Tipo de desc.</th>
											<th>Monto Desc.</th>
										</tr>
									</thead>
									<tbody>	
									<tbody>	
									<% 	if (mfList != null && mfList.size() > 0 ){
											for (int i = 0; i < mfList.size(); i++){ 
											PendingEstimationDiscount us = mfList.get(i); 
									%>
										<tr>
											<td><%= us.getIdentityCard() %></td>
											<td><%= us.getFirstName() + " " + us.getLastName() %></td>
											<td><%= us.getGender() %></td>
											<td><%= (us.getIsAdult()== 1)? "Adulto": "Infante" %></td>
											<td><%= (us.getRequestDate() != null)? us.getRequestDate() : "-"%></td>
											<td><%= (us.getJustification()!= null)? us.getJustification() : "-" %></td>
											<td><%= (us.getIsApproved() == 1) ? "Aprobado": "Rechazado" %></td>
											<td><%= (us.getReviewDate()!= null) ? us.getReviewDate(): "-" %></td>
											<td><%= us.getType() %></td>
											<td><%= us.getTotal() %></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="10" style="text-align: center;">No hay datos disponibles</td></tr>
									
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