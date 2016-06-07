<%@page import="domain.PatientEstimationService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<PatientEstimationService> services = (ArrayList<PatientEstimationService>) request.getAttribute("services");
	
	String patName = (String) request.getAttribute("patName");
	String adminId 	= (String) request.getAttribute("adminId");
	String servId = (String) request.getAttribute("servId");
	String function = (String) request.getAttribute("function");
	String scaleId = (String) request.getAttribute("scaleId");
	
	String text_result = (String) session.getAttribute("text");
	if (text_result == null)
		text_result = "";
	session.removeAttribute("text");
	
	String sec = (String) request.getAttribute("sec");
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Servicios Presupuestados</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$('.display').dataTable( {
			"iDisplayLength": 7,
			"bLengthChange": false,
			"bPaginate": false,
			"bFilter": false,
			"bInfo": false,
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
	var v3, v4;
	
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2, var3, var4) {
		idUser = var1;
		$('.ids').text(var1);
		$('.cliente').text(var2);
		v3 = var3;
		v4 = var4;
	};
	
	function setV(f){
		f.elements['userId'].value = idUser;
		f.elements['id'].value = v3;
		f.elements['name'].value = v4;
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
            	<li class="menuitem"><a href="<%=function%>">Ver Pacientes</a></li>
            </ul>
			<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Servicios Presupuestados:</h2><br/>
			<div class="info-text"><%=text_result%></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Servicio</th>
										<th>Cantidad</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>	
						<%
								for (int i=0; i< services.size(); i++){
									PatientEstimationService s = services.get(i);
						%>
									<tr class="gradeA">
										<td><%= s.getServiceID() %></td>
										<td><%= s.getServiceName() %></td>
										<td><%= s.getAmount() %></td>
										<td>
											<a href="AddPatientServiceServlet?id=<%=adminId%>&name=<%=patName%>&servId=<%=servId%>&spId=<%= s.getServiceID() %>&scaleId=<%= scaleId %>&sec=add&spName=<%= s.getServiceName() %>" style="color: transparent" >
												<img alt="logo" src="./images/add.png"  height="16" width="16" title="Agregar" />
											</a>
										</td>
									</tr>
						<%
								}
						%>
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