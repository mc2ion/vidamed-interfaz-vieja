<%@page import="domain.Unit"%>
<%@page import="domain.Specialist"%>
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
	ArrayList<Specialist> mfList = (ArrayList<Specialist>)request.getAttribute("pp");
	
	@SuppressWarnings("unchecked")
	ArrayList<Unit> uList = (ArrayList<Unit>)request.getAttribute("u");
	
	String nameF = (String)request.getAttribute("name");
	String lastnameF = (String)request.getAttribute("lastname");
	String identityCard = (String)request.getAttribute("identityCard");
	String rif = (String)request.getAttribute("rif");
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
			<h2>Reportes Especialistas</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoga el m�dulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								    <option value="0">Seleccionar</option>
									<option value="1" >Usuarios</option>
									<option value="2" selected>Especialistas</option>
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
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="ListSpecialistReportsServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la b�squeda por cualquiera de los siguientes par�metros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Unidad:</b></td>
									<td>
										<select name="unit" style="width: 152px;">
											<option value="-">Todas</option>
											<% for (int i=0; i < uList.size(); i++){
												Unit u = uList.get(i);
												String selected = "";
												if (unitId != null && Long.valueOf(unitId) == u.getUnitID())
													selected = "selected";
											%>
											<option value="<%= u.getUnitID() %>" <%= selected %>> <%= u.getName() %></option>
											<% } %>
									</select>
									</td>
									<td><b>C�dula:</b></td><td> <input  type="text" name="identityCard" maxlength="50" size="20" value="<%= (identityCard != null) ? identityCard : "" %>"/></td>
									<td><b>Rif:</b></td><td><input type="text" name="rif" size="20" value="<%= (rif != null) ? rif : "" %>"></td>
								</tr>
								<tr>
									<td><b>Nombre:</b></td><td>  <input type="text" name="eName" size="20" value="<%= (nameF != null) ? nameF : "" %>"></td>
									<td><b>Apellido:</b></td><td>  <input type="text" name="eLastname" size="20" value="<%= (lastnameF != null) ? lastnameF : "" %>"></td>
									<td><b>Sexo:</b></td><td>
									<select name="gender">
										<option value="-">Ambos</option>
										<option value="F" <%= (gender != null && gender.equals("F")) ? "selected" : "" %> >F</option>
										<option value="M" <%= (gender != null && gender.equals("M")) ? "selected" : "" %>>M</option>
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
											<th>C�dula</th>
											<th>Rif</th>
											<th>Nombre</th>
											<th>Sexo</th>
											<th>Email</th>
											<th>Fecha Nacimiento</th>
										</tr>
									</thead>
									<tbody>	
									<% 	if (mfList != null && mfList.size()> 0){
											for (int i = 0; i < mfList.size(); i++){ 
											Specialist u = mfList.get(i); 
									%>
										<tr>
											<td><%= u.getIdentityCard() %></td>
											<td><%= (u.getRif() != null) ? u.getRif() : "" %></td>
											<td><%= u.getFirstName() + " " + u.getLastName() %></td>
											<td><%= u.getSex() %></td>
											<td><%= u.getEmail() %></td>
											<td><%= u.getBirthdate() %></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="6" style="text-align: center;">No hay datos disponibles</td></tr>
									
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