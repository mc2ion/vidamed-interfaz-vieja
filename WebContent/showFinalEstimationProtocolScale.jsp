<%@page import="domain.BussinessMicro"%>
<%@page import="domain.ProtocolScale"%>
<%@page import="domain.Protocol"%>
<%@page import="domain.ClinicType"%>
<%@page import="domain.Unit"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.PaymentResponsible"%>
<%
	String estimationID 	= (String) request.getAttribute("estimationID" );
	String protocolID 		= (String) request.getAttribute("protocoloID" );
	
	@SuppressWarnings("unchecked")
	ArrayList<ProtocolScale> ps = (ArrayList<ProtocolScale>)request.getAttribute("ps");
	
	@SuppressWarnings("unchecked")
	ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>)request.getAttribute("bm");
%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Presupuesto</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	
	        </div>  
	     	<jsp:include page="./upperMenu.jsp" />       
			<div id="menu">
			
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListEstimationsServlet">Ver Presupuestos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>           
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
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
							%>
								<tr id="tr<%=j%>" >
									<td class='lft'  style="vertical-align:top;"><%= p.getName()%></td>
									<td><% if (p.getTotal() != null) { %> Bs. <%= p.getTotal()%><% } %></td>
								</tr>
								<%
								}
							}
						%>
						
						</table>
					<% } %>
			    	<div style="width:100%; text-align:center; margin-top:20px;">
			            <form action="CreateFinalEstimationProtocolServlet" method="post">
							<input type="hidden" name="estimationid" value="<%= estimationID %>"/>
							<input type="submit" value="Finalizar"/>
						</form>
						<form action="CreateFinalEstimationProtocolServlet" method="get">
							<input type="hidden" name="estimationid" value="<%= estimationID %>"/>
							<input type="submit" value="Agregar otro protocolo"/>
						</form>
			        </div>
			
       	</div>
		</div>
	</body>
	<style>
		.w200{width:145px; display:inline-block;}
		.table-simple td {
			padding: 7px 0px;
			border-bottom: 1px dotted rgb(231, 231, 231);
		}
		td.lft{width:340px;}
	</style>
</html>