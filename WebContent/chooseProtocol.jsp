<%@page import="domain.Protocol"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<Protocol> pp = (ArrayList<Protocol>) request.getAttribute("pp");

%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Protocolos</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$('#example').dataTable( {
			"iDisplayLength": 7,
			"bLengthChange": false,
			"sScrollY": "250px",
			"bPaginate": false,
			"aoColumns": [
				null,
				null,
				null,
				{ "bSearchable": false, "asSorting": false, "sWidth": "18%" }
			],
			"oLanguage": {
	            "sLengthMenu": "Mostrar _MENU_ registros",
	            "sZeroRecords": "No hay ningún registro que coincida con su búsqueda",
	            "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ registros",
	            "sInfoEmpty": "Mostrando 0 a 0 de 0 registros",
	            "sInfoFiltered": "(filtrando de _MAX_ registros totales)",
	            "sEmptyTable": "No hay datos disponibles en la tabla",
	            "sLoadingRecords": "Por favor, espere - cargando...",
	            "sSearch": "Buscar:"
        	}
		} );
	} );
	</script>
	<script type="text/javascript">
	var idUser;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2) {
		idUser = var1;
		$('.cliente').text(var2);
		
	};
	
	function setV(f){
		f.elements['userId'].value = idUser;
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
		<div id="content">  
			<h2>Protocolos:</h2>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<form action="ChooseProtocolServlet" method="post">
								<table class="display" id="example">
									<thead>
										<tr>
											<th>ID</th>
											<th>Nombre</th>
											<th>Descripción</th>
											<th>Seleccionar</th>
										</tr>
									</thead>
									<tbody>		
										<% for (int i=0; i< pp.size(); i++){
											Protocol p = pp.get(i);
										%>	
										<tr class="gradeA">
											<td><%= p.getProtocolID() %></td>
											<td><%= p.getName() %></td>
											<td><%= (p.getDescription() != null) ? p.getDescription() : "-" %></td>
											<td><input type="radio" name="protocol" value="<%= p.getProtocolID() %>" /> </td>
										</tr>
										<% } %>
									</tbody>
								</table>
								<div id="botonera" style="margin-top: -3px;">
									<div id="botonP" style="display: inline; margin-right: 30px;">
												<input type="submit"  class="button"  name="sbmtButton" value="Escoger" />
									</div>	
									<div id="botonV" style="display: inline;">
											<input type="button" class="button" value="Cancelar" onClick="javascript:history.back();" />		
									</div>	
								</div>
								
							</form>
						</div>
					</div>
				</div>
				<div class="spacer"></div>
       	</div>
		</div>
	</body>
</html>