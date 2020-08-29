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
	ArrayList<Supply> mfList = (ArrayList<Supply>)request.getAttribute("pp");

	@SuppressWarnings("unchecked")
	ArrayList<SupplyForm> u =  (ArrayList<SupplyForm>)request.getAttribute("u");

	@SuppressWarnings("unchecked")
	ArrayList<SupplyArea> a = (ArrayList<SupplyArea>)request.getAttribute("a");
	
	String supplyF 		= (String) request.getAttribute("supplyF");
	String supplyArea 	= (String)request.getAttribute("supplyArea");
	String nameS	 	= (String)request.getAttribute("name");
	String type 		= (String)request.getAttribute("type");
	String activeC 		= (String)request.getAttribute("activeC");
	String manufacture 	= (String)request.getAttribute("manufacture");
	String senior 		= (String)request.getAttribute("senior");
	String minior 		= (String)request.getAttribute("minior");
	String isRegulated 	= (String)request.getAttribute("isRegulated");


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
			<h2>Reportes Farmacia - Admin</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoja el módulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								   <option value="0">Seleccionar</option>
									<option value="1" >Usuarios</option>
									<option value="2" >Especialistas</option>
									<option value="3" >Responsables de Pago</option>
									<option value="4" selected>Farmacia - Admin</option>
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
									<option value="16" >Facturación detallada</option>
									<option value="17" >An&aacute;lisis Vencimiento</option>
									<option value="18" >Relaci&oacute;n de Facturaci&oacute;n</option>
									<option value="19" >An&aacute;lisis Vencimiento Resumido</option>
									<option value="20" >Registros de Pacientes</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="ListSupplyReportsServlet" style="margin-top: -10px;" method="post" >
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
									<td><b>Nombre:</b></td><td><input type="text" name="name" size="20" value="<%= (nameS != null) ? nameS : "" %>"></td>
								</tr>
								<tr>
									<td><b>Tipo:</b></td><td>
									<select name="type" style="width: 119px;">
										<option value="-"> Todos </option>
										<option value="1" <%= ( "1".equals(type)) ? "selected" : "" %> > Fármaco </option>
										<option value="2" <%= ( "2".equals(type)) ? "selected" : "" %>> Suministro </option>
									</select></td>
									<td><b>Componente Activo:</b></td><td>  <input type="text" name="activeC" size="20" value="<%= (activeC != null) ? activeC : "" %>"></td>
									<td><b>Fabricante:</b></td><td>  <input type="text" name="manufacture" size="20" value="<%= (manufacture != null) ? manufacture : "" %>"></td>
								</tr>
								<tr>
									<td><b>Cantidad Mayor Que:</b></td><td>  <input type="text" name="senior" size="20" value="<%= (senior != null) ? senior : "" %>"></td>
									<td><b>Cantidad Menor Que:</b></td><td>  <input type="text" name="minior" size="20" value="<%= (minior != null) ? minior : "" %>"></td>
									<td><b>Regulado:</b></td><td>  
									<select name="isRegulated">
										<option value="-">Ambos</option>
										<option value="1" <%= ( "1".equals(isRegulated)) ? "selected" : "" %>>Si</option>
										<option value="0" <%= ( "0".equals(isRegulated)) ? "selected" : "" %>>No</option>
									</select>
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
											<th>Nombre</th>
											<th>Área del Suministro</th>
											<th>Descripción</th>
											<th>Compuesto Activo</th>
											<th>Cantidad</th>
											<th>Precio</th>
											<th>¿Regulado?</th>
										</tr>
									</thead>
									<tbody>	
									<tbody>	
									<% 	if (mfList != null && mfList.size() > 0 ){
											for (int i = 0; i < mfList.size(); i++){ 
											Supply us = mfList.get(i); 
									%>
										<tr>
											<td><%= us.getName() %></td>
											<td><%= us.getSupplyAreaName() %></td>
											<td><%= us.getDescription() %></td>
											<td><%= us.getActiveComponent() %></td>
											<td><%= us.getAmount() %></td>
											<td><%= us.getUnitPrice() %></td>
											<td><%= (us.getIsRegulated() == 0) ? "No" : "Si" %></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="7" style="text-align: center;">No hay datos disponibles</td></tr>
									
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