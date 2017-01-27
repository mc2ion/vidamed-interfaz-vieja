<%@page import="domain.UserReport"%>
<%@page import="domain.Admission"%>
<%@ page import="domain.User" %>
<%@ page import="domain.UserUnit" %>
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
	ArrayList<UserReport> mfList = (ArrayList<UserReport>)request.getAttribute("pp");
	
	@SuppressWarnings("unchecked")
	ArrayList<UserUnit> a = (ArrayList<UserUnit>)request.getAttribute("a");
	
	String dateIni = (String) request.getAttribute("dateIni");
	String dateEnd = (String)request.getAttribute("dateEnd");
	String nameF = (String)request.getAttribute("name");
	String identityCard = (String)request.getAttribute("identityCard");
	String unitId = (String)request.getAttribute("unitId");
	String gender = (String)request.getAttribute("gender");
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
		<div id="content">  
			<h2>Reportes Usuarios</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoga el módulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								  	<option value="0">Seleccionar</option>
									<option value="1" selected>Usuarios</option>
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
									<option value="13" >Admisión</option>
									<option value="14" >Honorarios Médicos</option>
									<option value="15" >Libro de Ventas</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="ListUserReportsServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Desde:</b></td><td><input  type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="20" value="<%= (dateIni != null) ? dateIni : "" %>" /></td>
									<td><b>Hasta:</b></td><td> <input  type="text" name="txtDateEnd" id="txtDateEnd" maxlength="50" size="20" value="<%= (dateEnd != null) ? dateEnd : "" %>"/></td>
									<td><b>Nombre Usuario:</b></td><td><input type="text" name="userName" size="20" value="<%= (nameF != null) ? nameF : "" %>"></td>
								</tr>
								<tr>
									<td><b>Cédula:</b></td><td>  <input type="text" name="identityCard" size="20" value="<%= (identityCard != null) ? identityCard : "" %>"></td>
									<td><b>Sexo:</b></td>
									<td> 
									<select name="gender">
										<option value="-">Ambos</option>
										<option value="F" <%= (gender != null && gender.equals("F")) ? "selected" : "" %> >F</option>
										<option value="M" <%= (gender != null && gender.equals("M")) ? "selected" : "" %>>M</option>
									</select>
									</td>
									<td><b>Unidad:</b></td>
									
									<td>  
									<select name="unitId" style="width: 135px;">
										<option value="-">Todos</option>
										<%
											for (int  i = 0; i < a.size(); i++){
												UserUnit u = a.get(i);
										%>
										<option value="<%= u.getUserUnitID() %>" <%= (String.valueOf(u.getUserUnitID()).equals(unitId)) ? "selected" : "" %> ><%= u.getName() %></option>
										<% } %>
									</select>
									</td>
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
											<th>Fecha Ingreso</th>
											<th>Nombre Usuario</th>
											<th>Cédula</th>
											<th>Sexo</th>
											<th>Id Unidad</th>
											<th>Unidad</th>
											<th>Salario</th>
										</tr>
									</thead>
									<tbody>	
									<% 	if (mfList != null && mfList.size() > 0 ){
											for (int i = 0; i < mfList.size(); i++){ 
											UserReport u = mfList.get(i); 
									%>
										<tr>
											<td><%= u.getStartDate() %></td>
											<td><%= u.getUserName() %></td>
											<td><%= u.getIdentityCard() %></td>
											<td><%= u.getGender() %></td>
											<td><%= u.getUserUnitID() %></td>
											<td><%= (u.getUnitName() != null) ? u.getUnitName(): "-" %></td>
											<td><%= (u.getSalary() != null) ? u.getSalary(): "-" %></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="7" style="text-align: center;">No hay datos disponibles</td></tr>
									
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