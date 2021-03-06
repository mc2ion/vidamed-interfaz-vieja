<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<!DOCTYPE>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Presupuestos</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		var oTable = $('#example').dataTable( {
			"iDisplayLength": 7,
			"bLengthChange": false,
			"sScrollY": "250px",
			"bPaginate": false,
			"aoColumns": [
				{ "bSearchable": false, "asSorting": false },
				null,
				null,
				null,
				null,
				null,
				{ "bSearchable": false, "asSorting": false, "sWidth": "18%" }
			],
			"oLanguage": {
	            "sLengthMenu": "Mostrar _MENU_ registros",
	            "sZeroRecords": "No hay ning�n registro que coincida con su b�squeda",
	            "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ registros",
	            "sInfoEmpty": "Mostrando 0 a 0 de 0 registros",
	            "sInfoFiltered": "(filtrando de _MAX_ registros totales)",
	            "sEmptyTable": "No hay datos disponibles en la tabla",
	            "sLoadingRecords": "Por favor, espere - cargando...",
	            "sSearch": "Buscar:"
        	}
		} );
		oTable.fnSort( [ [1,'asc'] ] );
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
	    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Buscar Presupuestos:</h2>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th></th>
										<th>ID</th>
										<th>Paciente</th>
										<th>Especialista</th>
										<th>Protocolo</th>
										<th>Fecha</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>
											<input type="radio" name="presupuesto" value="12345"><br>
										</td>
										<td>1001</td>
										<td>Ana Rojas</td>
										<td>Ricardo Garc�a</td>
										<td>Histerectom�a</td>
										<td>17/06/2013</td>
										<td>
											<a href="ShowEstimationForAdmissionServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
										</td>
									</tr>
									<tr class="gradeA">
										<td>
											<input type="radio" name="presupuesto" value="12345"><br>
										</td>
										<td>1002</td>
										<td>Luis Mujica</td>
										<td>Pedro P�rez</td>
										<td>Colecistectom�a</td>
										<td>17/06/2013</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
										</td>
									</tr>
									<tr class="gradeA">
										<td>
											<input type="radio" name="presupuesto" value="12345"><br>
										</td>
										<td>1003</td>
										<td>Miguel �lvarez</td>
										<td>Jes�s Rom�n</td>
										<td>Apendicectom�a</td>
										<td>17/06/2013</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div><br>
					<form style="display: inline;">
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" style="margin-left:30%;" onClick="javascript:history.back();" style="margin-left:40%;" />		
						</div>	
					</form>
					<form action="AdmitPatientServlet?id=1" method="post" style="display: inline;">
						<input type="submit"  class="button"  name="sbmtButton" value="Seleccionar" style="margin-left:20%; "/>
					</form>
				</div>
				
				<div class="spacer"></div>
        	</div>
       	</div>
		
	</body>
</html>