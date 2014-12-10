<%@page import="domain.Supply"%>
<%@page import="domain.BussinessMicro"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%@page import="domain.ProtocolScale"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%
@SuppressWarnings("unchecked")
ArrayList<ProtocolScale> ps = (ArrayList<ProtocolScale>)request.getAttribute("ps");
@SuppressWarnings("unchecked")
ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>)request.getAttribute("bm");
String id = (String) request.getParameter("id");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Protocolo</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<script src="./js/jquery-1.9.1.min.js"></script>
	    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<script type="text/javascript" src="./js/functions.js"></script>
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListProtocolsServlet">Ver Protocolos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
		       	<form id="SignupForm" action="ListAdmissionsServlet">
		       		<%
		       			for (int i = 0; i < bm.size(); i++){ 
		       				BussinessMicro b = bm.get(i);
		       		%>
		       		    <br/><h3 class='nts'><%= b.getName() %></h3><br/>
						<table class="table-simple">
						<%
							for (int j = 0; j < ps.size(); j++){ 
								ProtocolScale p = ps.get(j);
								if (p.getBussinessRuleMicroID() == b.getId()){
									if (p.getIsMandatory() == 1){
							%>
								<tr id="tr<%=j%>">
								<td><%= p.getName()%></td>
								<% if (p.getGeneratedCostTypeID() == 3){
									if (p.getTotal() == null){
								%>
									<td><a class='button-gray' href='./AddDrugsServlet?id=<%= p.getProtocolScaleID()%>&protocolID=<%= id%>'>Agregar Suministros</a></td>
								<%}else{ %>
									<td>Bs. <%= p.getTotal() %> <a class='button-gray' href='./EditDrugsServlet?id=<%= p.getProtocolScaleID()%>&protocolID=<%= id%>'>Editar Suministros</a></td>
								
								<% }
								}else if (p.getGeneratedCostTypeID() == 10 || p.getGeneratedCostTypeID() == 9 ) {%>
									<td><span style='font-size:11px;'>Este costo se calculará al crear un presupuesto.</span></td>
								<%}else if (p.getGeneratedCostTypeID() == 6) {%>
									<td><span style='font-size:11px;'><%= p.getGeneratedCostTypeName()%>. Este costo se calculará al crear un presupuesto.</span></td>
								<%} else if (p.getGeneratedCostTypeID() != 9) {
								%>
								<td><% if (p.getTotal() != null) { %> Bs. <%= p.getTotal()%><%}%></td>
								<%	
								}
								%>
								</tr>
						<% 
								   }
								}
							}
						%>
						
						</table>
					<% } %>
			    	<p style="width:100%; text-align:center; margin-top:20px;">
			            <a href="/ListProtocolsServlet">Aceptar</a>
			            <a href="/ListProtocolsServlet">Agregar Servicios Adicionales</a>
			        </p>
			        </form>
				</div>
			</div>
	</body>
	<style>
		.table-simple td{width:50%;}
	</style>
	
</html>