<%@page import="domain.PatientMedicalAdvice"%>
<%@page import="domain.Unit"%>
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
	ArrayList<PatientMedicalAdvice> mfList = (ArrayList<PatientMedicalAdvice>)request.getAttribute("pp");

	@SuppressWarnings("unchecked")
	ArrayList<Unit> u =  (ArrayList<Unit>)request.getAttribute("u");

	String identityCard = (String)request.getAttribute("identityCard");
	String gender = (String)request.getAttribute("gender");
	String isAdult = (String)request.getAttribute("isAdult");
	String admisionId = (String)request.getAttribute("admisionId");
	String estimationId = (String)request.getAttribute("estimationId");
	String dateIni = (String) request.getAttribute("dateIni");
	String dateEnd = (String)request.getAttribute("dateEnd");
	String sIdentityCard = (String)request.getAttribute("sIdentityCard");
	String sRif = (String)request.getAttribute("sRif");
	String sGender = (String)request.getAttribute("sGender");
	String unitId = (String)request.getAttribute("unitId");
	
	System.out.println(sGender);
	
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
		<div id="content" style="min-height: 700px;">  
			<h2>Reportes Interconsultas</h2>
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
									<option value="10" selected>Interconsultas</option>
									<option value="11" >Descuentos</option>
									<option value="12" >Facturas</option>
									<option value="13" >Admisión</option>
									<option value="14" >Honorarios Médicos</option>
									<option value="15" >Libro de Ventas</option>
									<option value="16" >Facturación detallada</option>
									<option value="17" >An&aacute;lisis Vencimiento</option>
									<option value="18" >Relaci&oacute;n de Facturaci&oacute;n</option>
									<option value="19" >An&aacute;lisis Vencimiento Resumido</option>
									<option value="20" >Registros de Pacientes</option>
									<option value="21" >Insumos Facturados</option>
									<option value="22" >Insumos Pacientes</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="ListPatientMedicalAdviceReportsServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
								    <td><b># Admisión:</b></td><td>  <input type="text" name="admissionId" size="20" value="<%= (admisionId != null) ? admisionId : "" %>"></td>
									<td><b># Presupuesto :</b></td><td>  <input type="text" name="estimationId" size="20" value="<%= (estimationId != null) ? estimationId : "" %>"></td>
									<td><b>Cédula Especialista :</b></td><td>  <input type="text" name="sIdentityCard" size="20" value="<%= (sIdentityCard != null) ? sIdentityCard : "" %>"></td>
								</tr>
								<tr>
									<td><b>Sexo Especialista:</b></td>
									<td> 
									<select name="sGender">
										<option value="-">Ambos</option>
										<option value="F" <%= (sGender != null && sGender.equals("F")) ? "selected" : "" %> >F</option>
										<option value="M" <%= (sGender != null && sGender.equals("M")) ? "selected" : "" %>>M</option>
									</select>
									</td>
									<td><b>Rif:</b></td><td><input type="text" name="sRif" size="20" value="<%= (sRif != null) ? sRif : "" %>"></td>  
									<td><b>Unidad:</b></td>
									<td>
										<select name="unitId" style="width: 152px;">
											<option value="-">Todas</option>
											<% for (int i=0; i < u.size(); i++){
												Unit un = u.get(i);
												String selected = "";
												if (unitId != null && Long.valueOf(unitId) == un.getUnitID())
													selected = "selected";
											%>
											<option value="<%= un.getUnitID() %>" <%= selected %>> <%= un.getName() %></option>
											<% } %>
									</select>
									</td>
								</tr>
								<tr>
								    <td><b>Cédula Paciente:</b></td><td>  <input type="text" name="identityCard" size="20" value="<%= (identityCard != null) ? identityCard : "" %>"></td>
									<td><b>Sexo Paciente:</b></td>
									<td> 
									<select name="gender">
										<option value="-">Ambos</option>
										<option value="F" <%= (gender != null && gender.equals("F")) ? "selected" : "" %> >F</option>
										<option value="M" <%= (gender != null && gender.equals("M")) ? "selected" : "" %>>M</option>
									</select>
									</td>
									<td><b>Tipo Paciente:</b></td><td>
									<select name="isAdult" style="width: 119px;">
										<option value="-"> Todos </option>
										<option value="1" <%= ( "1".equals(isAdult)) ? "selected" : "" %> > Adulto </option>
										<option value="2" <%= ( "2".equals(isAdult)) ? "selected" : "" %>>  Infante </option>
									</select></td>
								</tr>
								<tr>
								<td><b>Consultas Desde:</b></td><td><input  type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="20" value="<%= (dateIni != null) ? dateIni : "" %>" /></td>
								<td><b>Consultas Hasta:</b></td><td> <input  type="text" name="txtDateEnd" id="txtDateEnd" maxlength="50" size="20" value="<%= (dateEnd != null) ? dateEnd : "" %>"/></td>
								</tr>
							</table>
							<input type="submit" class="buttonGreen lessPadding"   style="float: right; margin-right:40px; margin-top: 5px;" value="Buscar">		
							</fieldset>
  						</div>	
  						</form>
  						<div id="demo" style="display: block; height: 400px; overflow-y: scroll; margin-top:10px;">
								<table id="sweetTable" >
									<thead>
										<tr>
											<th>Cédula Pact</th>
											<th>Nombre Pact</th>
											<th>Sexo Pact</th>
											<th>Tipo Pact</th>
											<th>Especialista</th>
											<th>Cédula Esp</th>
											<th>Rif Esp</th>
											<th>Unidad Esp</th>
											<th>Honorarios</th>
											<th>Fecha Servicio</th>
										</tr>
									</thead>
									<tbody>	
									<tbody>	
									<% 	if (mfList != null && mfList.size() > 0 ){
											for (int i = 0; i < mfList.size(); i++){ 
											PatientMedicalAdvice us = mfList.get(i); 
									%>
										<tr>
											<td><%= us.getPatient().getIdentityCard() %></td>
											<td><%= us.getPatient().getFirstName() + " " + us.getPatient().getLastName() %></td>
											<td><%= us.getPatient().getGender() %></td>
											<td><%= (us.getPatient().getIsAdult()== 1)? "Adulto": "Infante" %></td>
											<td><%= us.getSpecialist().getFirstName() + " " + us.getSpecialist().getLastName() %></td>
											<td><%= us.getSpecialist().getIdentityCard() %></td>
											<td><%= us.getSpecialist().getRif() %></td>
											<td><%= us.getUnitName() %></td>
											<td><%= us.getMedicalFeed() %></td>
											<td><%= us.getMedicalAdviceDate() %></td>
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