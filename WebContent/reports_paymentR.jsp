<%@page import="domain.BussinessRules"%>
<%@page import="domain.PaymentResponsible"%>
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
	ArrayList<PaymentResponsible> mfList = (ArrayList<PaymentResponsible>)request.getAttribute("pp");
	
	@SuppressWarnings("unchecked")
	ArrayList<BussinessRules> brList = (ArrayList<BussinessRules>)request.getAttribute("br");
	
	String nameB = (String) request.getAttribute("name");
	String bRule = (String)request.getAttribute("bRule");

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
			<h2>Reportes Responsable de Pago</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoga el módulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								     <option value="0">Seleccionar</option>
									<option value="1" >Usuarios</option>
									<option value="2" >Especialistas</option>
									<option value="3" selected>Responsables de Pago</option>
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
									<option value="16" >Facturación detallada</option>
									<option value="17" >An&aacute;lisis Vencimiento</option>
									<option value="18" >Relaci&oacute;n de Facturaci&oacute;n</option>
									<option value="19" >An&aacute;lisis Vencimiento Resumido</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="ListPaymentResponsibleReportsServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Nombre:</b></td><td><input  type="text" name="name" maxlength="50" size="20" value="<%= (nameB != null) ? nameB : "" %>" /></td>
									<td><b>Regla de Negocio:</b></td><td> 
									<select name="br">
										<option value="-">Todas</option>
										<% for (int i = 0; i < brList.size(); i++){ 
											BussinessRules b = brList.get(i);
											System.out.println(bRule + " " + b.getId() );
											String selected = "";
											if (bRule != null && Long.valueOf(bRule) == b.getId())
												selected = "selected";
											
										%>
											<option value="<%= b.getId() %>" <%= selected %>> <%= b.getName() %> </option> 
										<% } %>
									</select>
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
											<th>Id</th>
											<th>Responsable de Pago</th>
											<th>Regla de Negocio</th>
											<th>Dirección</th>
											<th>Número telefónico</th>
											<th>Contacto</th>
										</tr>
									</thead>
									<tbody>		
									<% 	if (mfList != null && mfList.size() > 0 ){
											for (int i = 0; i < mfList.size(); i++){ 
											PaymentResponsible u = mfList.get(i); 
									%>
										<tr>
											<td><%= u.getId() %></td>
											<td><%= u.getName() %></td>
											<td><%= u.getRuleName() %></td>
											<td><%= (u.getAddress() != null)? u.getAddress() : "-" %></td>
											<td><%= (u.getPhone() != null)? u.getPhone() : "-" %></td>
											<td><%= (u.getContactName() != null)? u.getContactName() : "-" %></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="5" style="text-align: center;">No hay datos disponibles</td></tr>
									
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