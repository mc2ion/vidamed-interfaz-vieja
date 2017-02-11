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
	ArrayList<PatientSupply> mfList = (ArrayList<PatientSupply>)request.getAttribute("pp");

	@SuppressWarnings("unchecked")
	ArrayList<SupplyForm> u =  (ArrayList<SupplyForm>)request.getAttribute("u");

	@SuppressWarnings("unchecked")
	ArrayList<SupplyArea> a = (ArrayList<SupplyArea>)request.getAttribute("a");
	
	String supplyF 		= (String) request.getAttribute("supplyF");
	String supplyArea 	= (String)request.getAttribute("supplyArea");
	String type 		= (String)request.getAttribute("type");
	String isRegulated 	= (String)request.getAttribute("isRegulated");
	String identityCard = (String)request.getAttribute("identityCard");
	String gender = (String)request.getAttribute("gender");
	String isAdult = (String)request.getAttribute("isAdult");
	String admisionId = (String)request.getAttribute("admisionId");
	String estimationId = (String)request.getAttribute("estimationId");
	String dateIni = (String) request.getAttribute("dateIni");
	String dateEnd = (String)request.getAttribute("dateEnd");
	
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
		<div id="content" style="min-height: 600px;">  
			<h2>Reportes Farmacia - Pacientes</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoga el módulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								     <option value="0">Seleccionar</option>
									<option value="1" >Usuarios</option>
									<option value="2" >Especialistas</option>
									<option value="3" >Responsables de Pago</option>
									<option value="4" >Farmacia - Admin</option>
									<option value="5" selected>Farmacia - Pacientes</option>
									<option value="6" >Banco de Sangre</option>
									<option value="7" >Ecosonografía</option>
									<option value="8" >Rayos X</option>
									<option value="9" >Laboratorio</option>
									<option value="10" >Interconsultas</option>
									<option value="11" >Descuentos</option>
									<option value="12" >Facturas</option>
									<option value="13" >Admisión</option>
									<option value="14" >Honorarios Médicos</option>
									<option value="15" >Libro de Ventas</option>
									<option value="16" >Facturación detallada</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="ListPatientSupplyReportsServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Presentación:</b></td><td>
									<select name="supplyForm" style="width: 119px;">
										<option value="-">Todos</option>
										<% for (int i = 0 ; i < u.size(); i++){ 
											SupplyForm sp = u.get(i);
										%>
											<option value="<%= sp.getSupplyFormID() %>" <%= (String.valueOf(sp.getSupplyFormID()).equals(supplyF)) ? "selected" : "" %>> <%= sp.getName() %></option> 
										<% } %>
									</select>
									<td><b>Area Suministro:</b></td><td>
										<select name="supplyArea" style="width: 119px;">
											<option value="-">Todas</option>
										<% for (int i = 0 ; i < a.size(); i++){ 
											SupplyArea sp  = a.get(i);
										%>
											<option value="<%= sp.getSupplyAreaID() %>" <%= (String.valueOf(sp.getSupplyAreaID()).equals(supplyArea)) ? "selected" : "" %>> <%= sp.getName() %></option> 
										<% } %>
									</select>
									</td>
									<td><b>Tipo:</b></td><td>
									<select name="type" style="width: 119px;">
										<option value="-"> Todos </option>
										<option value="1" <%= ( "1".equals(type)) ? "selected" : "" %> > Fármaco </option>
										<option value="2" <%= ( "2".equals(type)) ? "selected" : "" %>>  Suministro </option>
									</select></td>
						
								</tr>
								<tr>
								    <td><b>Regulado:</b></td>
								    <td>  
									<select name="isRegulated">
										<option value="-">Ambos</option>
										<option value="1" <%= ( "1".equals(isRegulated)) ? "selected" : "" %>>Si</option>
										<option value="0" <%= ( "0".equals(isRegulated)) ? "selected" : "" %>>No</option>
									</select>
									</td>
									<td><b># Admisión:</b></td><td>  <input type="text" name="admissionId" size="20" value="<%= (admisionId != null) ? admisionId : "" %>"></td>
									<td><b># Presupuesto :</b></td><td>  <input type="text" name="estimationId" size="20" value="<%= (estimationId != null) ? estimationId : "" %>"></td>
								</tr>
								<tr>
									<td><b>Cédula Paciente :</b></td><td>  <input type="text" name="identityCard" size="20" value="<%= (identityCard != null) ? identityCard : "" %>"></td>
									<td><b>Sexo:</b></td>
									<td> 
									<select name="gender">
										<option value="-">Ambos</option>
										<option value="F" <%= (gender != null && gender.equals("F")) ? "selected" : "" %> >F</option>
										<option value="M" <%= (gender != null && gender.equals("M")) ? "selected" : "" %>>M</option>
									</select>
									</td>
									<td><b>Paciente:</b></td><td>  
									<select name="isAdult">
										<option value="-">Ambos</option>
										<option value="1" <%= ( "1".equals(isAdult)) ? "selected" : "" %>>Adulto</option>
										<option value="0" <%= ( "0".equals(isAdult)) ? "selected" : "" %>>Infante</option>
									</select>
									<td>  
								</tr>
								<tr>
								<td><b>Suministros Desde:</b></td><td><input  type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="20" value="<%= (dateIni != null) ? dateIni : "" %>" /></td>
								<td><b>Suministros Hasta:</b></td><td> <input  type="text" name="txtDateEnd" id="txtDateEnd" maxlength="50" size="20" value="<%= (dateEnd != null) ? dateEnd : "" %>"/></td>
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
											<th>Tipo</th>
											<th>Fecha</th>
											<th>Área del Suministro</th>
											<th>Suministro</th>
											<th>Cantidad</th>
											<th>Precio</th>
											<th>Total</th>
										</tr>
									</thead>
									<tbody>	
									<tbody>	
									<% 	if (mfList != null && mfList.size() > 0 ){
											for (int i = 0; i < mfList.size(); i++){ 
											PatientSupply us = mfList.get(i); 
									%>
										<tr>
											<td><%= us.getPatient().getIdentityCard() %></td>
											<td><%= us.getPatient().getFirstName() + " " + us.getPatient().getLastName() %></td>
											<td><%= us.getPatient().getGender() %></td>
											<td><%= (us.getPatient().getIsAdult()== 1)? "Adulto": "Infante" %></td>
											<td><%= us.getSupplyDate() %></td>
											<td><%= us.getSupply().getSupplyAreaName() %></td>
											<td><%= us.getSupply().getName() %></td>
											<td><%= us.getSupply().getAmount() %></td>
											<td><%= us.getSupply().getUnitPrice() %></td>
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