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
	<title>Agregar Servicio</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		var oTable = $('#example').dataTable( {
			"iDisplayLength": 7,
			"bLengthChange": false,
			"sScrollY": "230px",
			"bPaginate": false,
			"aoColumns": [
				{ "bSearchable": false, "asSorting": false, "sWidth": "10%"  },
				null,
				null,
				null
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
	<script type="text/javascript">
		$(document).ready(function() {
			
			function getUrlVars() {
			    var vars = {};
			    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
			        vars[key] = value;
			    });
			    return vars;
			}

			var first = getUrlVars()["function"];
			if (first != null){
				first = first.replace(/\+/g, ' ');
				if (first.indexOf("Estimation") > 0){
					$("#estimation").attr('class', 'active');
					if (first == "editEstimation")
						$("#form").attr('action', 'EditEstimationServlet#tabs-3');
					else if(first == "createEstimation")
						$("#form").attr('action', 'CreateEstimationServlet#tabs-3');
				}
				else if (first.indexOf("Hospitalization") > 0){
					$("#hospitalization").attr('class', 'active');
					if (first == "editHospitalization")
						$("#form").attr('action', 'EditHospitalizationServlet#tabs-3');
					
				}
				else if (first.indexOf("Patient") > 0){
					$("#admission").attr('class', 'active');
					if (first == "admitPatient")
						$("#form").attr('action', 'AdmitPatientServlet');
					
				}
				else if (first.indexOf("Emergency") > 0){
					$("#emergencies").attr('class', 'active');
					if (first == "editEmergency")
						$("#form").attr('action', 'EditEmergencyServlet#tabs-3');
					
				}
			}
				
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
			<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Agregar Servicio:</h2><br>
			<p>Escoga el servicio que desea agregar haciendo clic en la columna izquierda de la tabla y luego haga clic en "Agregar".</p>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>Escoger</th>
										<th>ID</th>
										<th>Nombre</th>
										<th>Precio</th>
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>
											<input type="radio" name="service" value="Hospitalizacion"><br>
										</td>
										<td>1001</td>
										<td>Hospitalización</td>
										<td>6.363,20</td>
									</tr>
									<tr class="gradeA">
										<td>
											<input type="radio" name="protocol" value="Tratamiento Medico"><br>
										</td>
										<td>1002</td>
										<td>Tratamiento Médico</td>
										<td>2.265,99</td>
									</tr>
									<tr class="gradeA">
										<td>
											<input type="radio" name="protocol" value="Operacion"><br>
										</td>
										<td>1003</td>
										<td>Operación</td>
										<td>3.075,00</td>
									</tr>
								</tbody>
							</table>
							<div id="botonera">
							<form id="form" action="">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<input type="submit" class="button" value="Regresar" />		
								</div>	
							</form>
							</div><br>
						</div>
					</div>
				</div>
				<div class="spacer"></div>
       	</div>
       	</div>
		
	</body>
</html>