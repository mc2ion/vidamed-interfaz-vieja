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
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Reportes</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
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
			<h2>Reportes</h2>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoja el m�dulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								    <option value="0">Seleccionar</option>
									<option value="1" <%= (modSelect == 1 ? "selected" : "") %>>Usuarios</option>
									<option value="2" <%= (modSelect == 2 ? "selected" : "") %>>Especialistas</option>
									<option value="3" <%= (modSelect == 3 ? "selected" : "") %>>Responsables de Pago</option>
									<option value="4" <%= (modSelect == 4 ? "selected" : "") %>>Farmacia - Admin</option>
									<option value="5" <%= (modSelect == 5 ? "selected" : "") %>>Farmacia - Pacientes</option>
									<option value="6" <%= (modSelect == 6 ? "selected" : "") %>>Banco de Sangre</option>
									<option value="7" <%= (modSelect == 7 ? "selected" : "") %>>Ecosonograf�a</option>
									<option value="8" <%= (modSelect == 8 ? "selected" : "") %>>Rayos X</option>
									<option value="9" <%= (modSelect == 9 ? "selected" : "") %>>Laboratorio</option>
									<option value="10" <%= (modSelect == 10 ? "selected" : "") %>>Interconsultas</option>
									<option value="11" <%= (modSelect == 11 ? "selected" : "") %>>Descuentos</option>
									<option value="12" <%= (modSelect == 12 ? "selected" : "") %>>Facturas</option>
									<option value="13" <%= (modSelect == 13 ? "selected" : "") %>>Admisi�n</option>
									<option value="14" <%= (modSelect == 14 ? "selected" : "") %>>Honorarios M�dicos</option>
									<option value="15" <%= (modSelect == 15 ? "selected" : "") %>>Libro de Ventas</option>
									<option value="16" <%= (modSelect == 16 ? "selected" : "") %>>Facturaci�n Detallada</option>
									<option value="17" <%= (modSelect == 17 ? "selected" : "") %>>An&aacute;lisis Vencimiento</option>
									<option value="18" <%= (modSelect == 18 ? "selected" : "") %>>Relaci&oacute;n de Facturaci&oacute;n</option>
									<option value="19" <%= (modSelect == 19 ? "selected" : "") %>>An&aacute;lisis Vencimiento Resumido</option>
									<option value="20" <%= (modSelect == 20 ? "selected" : "") %>>Registros de Pacientes</option>
									<option value="21" <%= (modSelect == 21 ? "selected" : "") %>>Insumos Facturados</option>
									<option value="22" <%= (modSelect == 22 ? "selected" : "") %>>Insumos Pacientes</option>
								</select>
								<input type="submit" value="Buscar"/>
							</form>
						</div>
					</div>
				</div>
				<div class="spacer"></div>
       	</div>
		</div>
	</body>
</html>