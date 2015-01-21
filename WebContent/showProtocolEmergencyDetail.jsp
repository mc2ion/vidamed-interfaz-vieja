<%@page import="domain.BussinessMicro"%>
<%@page import="domain.ProtocolScale"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<ProtocolScale> ps = (ArrayList<ProtocolScale>)request.getAttribute("est");
	
	@SuppressWarnings("unchecked")
	ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>)request.getAttribute("bm");
	String id = (String) request.getParameter("id");
	
	String nameProtocol = request.getParameter("n");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Detalle protocolo - emergencia</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
		<script>
		  $(function() {
		    $( "#accordion" ).accordion();
		  });
		  </script>		
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul id="menuInside">
	            	<li class="menuitem"><a href="ListEmergenciesServlet">Ver Emergencias</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
        		<h3 style="color:#006C92;">Detalle protocolo "<%= nameProtocol %>" en emergencia n° <%= request.getParameter("estimationID") %>:</h3>
				<%
		       			for (int i = 0; i < bm.size(); i++){ 
		       				BussinessMicro b = bm.get(i);
		       	%>
				    <br/><br/><h3 style="margin-bottom:7px;"><%= b.getName() %></h3>
					<div>
				    <table class="table-simple">
				    	<%
							for (int j = 0; j < ps.size(); j++){ 
								ProtocolScale p = ps.get(j);
								if (p.getBussinessRuleMicroID() == b.getId()){
						%>
						<% if (p.getTotal() != null) { %>
						<tr id="tr<%=j%>" >
				    			<td class='lft'  style="vertical-align:top;"><%= p.getName()%></td>
								<td> Bs. <%= p.getTotal()%></td>
						</tr>
						<% } %>
						<% }
						}
						%>
				    </table>
					</div>
				  <% } %>
				<div id="botonera2"  style="width: 120px;">
					<input type="button"  class="button"  name="sbmtButton" value="Regresar" onclick="history.go(-1);" />
				</div><br>
			</div>
		</div>
	</body>
	<style>
		.table-simple td {
			padding: 7px 0px;
			border-bottom: 1px dotted rgb(231, 231, 231);
		}
		td.lft{width:80%;}
	</style>
</html>