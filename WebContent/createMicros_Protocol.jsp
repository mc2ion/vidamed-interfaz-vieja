<%@page import="domain.Supply"%>
<%@page import="domain.BussinessMicro"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%@page import="domain.ProtocolScale"%>
<%
	User user = (User) session.getAttribute("user");
	int valoresFaltantes = 0;
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
		<script type="text/javascript">
    		function continueFunction (var1) {
    			if (var1 > 0) {
    				alert("Debe completar todos los valores faltantes del protocolo");
    				return false;
    			}
    			return true;
    		}
		</script>
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
        	<div id="content" style="position: absolute; left: 0; top: 75px;">
        		<%
        			String micro = ps.get(0).getBussinessRuleMicroName();
        			System.out.println("++micro:"+micro);
        			if((ps.get(0).getIsMandatory()==1) || (ps.get(0).getIsMandatory()==0 && ps.get(0).getIsSelected()==1)){
				%>
				<br/><h3 class='nts'><%= micro %></h3><br/>
				<table class="table-simple">
				<%        	
        			}
        			for(int k = 0; k < ps.size(); k++){
        				ProtocolScale p = ps.get(k);
        				if(!micro.equalsIgnoreCase(p.getBussinessRuleMicroName()) && ((p.getIsMandatory()==1) || (p.getIsMandatory()==0 && p.getIsSelected()==1))){
        					micro = p.getBussinessRuleMicroName();
        		%>
        		</table>
        		<br/><h3 class='nts'><%= micro %></h3><br/>
				<table class="table-simple">
        		<%
        				}
        				if (p.getIsMandatory() == 1){
        		%>
					<tr id="tr<%=k%>">
						<td class='lft'><%= p.getName()%></td>
				<% 
							if (p.getGeneratedCostTypeID() == 3){
								if (p.getTotal() == null){
									valoresFaltantes++;
				%>
						<td>---</td>
						<td>
							<a class='button-gray' href='./AddDrugsServlet?id=<%= p.getProtocolScaleID()%>&protocolID=<%= id%>'>Agregar Suministros</a>
						</td>
				<%
								}else{ 
				%>
						<td>Bs. <%= p.getTotal() %></td>
						<td> <a class='button-gray' href='./EditDrugsServlet?id=<%= p.getProtocolScaleID()%>&protocolID=<%= id%>'>Editar Suministros</a></td>
				<% 
								}
							} else if (p.getGeneratedCostTypeID() == 12){
								if(p.getTotal() == null){
									valoresFaltantes++;
				%>
						<td>---</td>
						<td>
							<a class='button-gray' href='./AddServicesServlet?id=<%= p.getProtocolScaleID()%>&protocolID=<%= id%>&serviceTypeID=<%= p.getCost().substring(0, 1) %>'>Agregar Servicios</a>
						</td>
				<%
								}else{
				%>
						<td>Bs. <%= p.getTotal() %></td>
						<td> <a class='button-gray' href='./EditServicesServlet?id=<%= p.getProtocolScaleID()%>&protocolID=<%= id%>&serviceTypeID=<%= p.getCost().substring(0, 1) %>'>Editar Servicios</a></td>
				<%
								}
							} else if (p.getTotal() == null) {%>
						<td>
							<span style='font-size:11px;'>(<%= p.getGeneratedCostTypeName()%>). Este costo se calcular� al crear un presupuesto.</span>
						</td>
						<td></td>
				<%
							} else {
				%>
						<td><% if (p.getTotal() != null) { %> Bs. <%= p.getTotal()%><%}%></td><td></td>
				<%	
							}
				%>
					</tr>
				<% 
						}else if (p.getIsMandatory() == 0 && p.getIsSelected() == 1){
				%>
					<tr>
						<td class='lft'><%= p.getName()%></td>
				<% 
							if (p.getGeneratedCostTypeID() == 3){
								if (p.getTotal() == null){
									valoresFaltantes++;
				%>
						<td>---</td>
						<td>
							<a class='button-gray' href='./AddDrugsServlet?id=<%= p.getProtocolScaleID()%>&protocolID=<%= id%>'>Agregar Suministros</a>
						</td>
				<%
								}else{ 
				%>
						<td>Bs. <%= p.getTotal() %></td>
						<td> 
							<a class='button-gray' href='./EditDrugsServlet?id=<%= p.getProtocolScaleID()%>&protocolID=<%= id%>'>Editar Suministros</a>
						</td>
				<% 
								}
							} else if (p.getGeneratedCostTypeID() == 12){
								if (p.getTotal() == null){
									valoresFaltantes++;
				%>
						<td>---</td>
						<td>
							<a class='button-gray' href='./AddServicesServlet?id=<%= p.getProtocolScaleID()%>&protocolID=<%= id%>&serviceTypeID=<%= p.getCost().substring(0, 1) %>'>Agregar Servicios</a>
						</td>
				<%
								}else{
				%>
						<td>Bs. <%= p.getTotal() %></td>
						<td> 
							<a class='button-gray' href='./EditServicesServlet?id=<%= p.getProtocolScaleID()%>&protocolID=<%= id%>&serviceTypeID=<%= p.getCost().substring(0, 1) %>'>Editar Servicios</a>
						</td>
				<%
								}
							} else if (p.getTotal() == null) {
				%>
						<td>
							<span style='font-size:11px;'><%= p.getGeneratedCostTypeName()%>. Este costo se calcular� al crear un presupuesto.</span>
						</td>
						<td></td>
				<%
							} else{
				%>
						<td><% if (p.getTotal() != null) { %> Bs. <%= p.getTotal()%><%}%></td><td></td>
				<%	
							}
				%>
					</tr>
				<% 
        				}
        			}
        		%>	
        		</table>
			    	<p style="width:100%; text-align:center; margin-top:20px;">
			            <a href="./ListProtocolsServlet?s=1" class="button" onclick="return continueFunction(<%= valoresFaltantes %>);">Aceptar</a> �
			            <a href="./AddServiceProtocolServlet?id=<%= id %>" class="button" style="margin-left: 5px;" onclick="return continueFunction(<%= valoresFaltantes %>);">Agregar Servicios Adicionales</a>
			        </p>
				</div>
			</div>
	</body>
	<style>
		.table-simple td{width:33%;}
		.table-simple td { padding: 7px 0px; border-bottom: 1px dotted rgb(231, 231, 231); }
	</style>
	
</html>