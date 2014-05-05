<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<!DOCTYPE html >
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Agregar Farmacia</title>
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
				{ "bSearchable": false, "asSorting": false, "sWidth": "15%" },
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
						$("#form").attr('action', 'EditEstimationServlet#tabs-4');
					else if(first == "createEstimation")
						$("#form").attr('action', 'CreateEstimationServlet#tabs-4');
				}
				else if (first.indexOf("Hospitalization") > 0){
					$("#hospitalization").attr('class', 'active');
					if (first == "editHospitalization")
						$("#form").attr('action', 'EditHospitalizationServlet#tabs-4');
					
				}
				else if (first.indexOf("Patient") > 0){
					$("#admission").attr('class', 'active');
					if (first == "admitPatient")
						$("#form").attr('action', 'AdmitPatientServlet');
					
				}
				else if (first.indexOf("Emergency") > 0){
					$("#emergencies").attr('class', 'active');
					if (first == "editEmergency")
						$("#form").attr('action', 'EditEmergencyServlet#tabs-4');
					
				}
			}
			
			$('#supplies1').click(function () {
				if ($('#supplies1').is(':checked')) {
				    $("#select1").css("visibility","visible"); 
				} else {
				    $("#select1").css("visibility","hidden"); 
				} 
			});
			
			$('#supplies2').click(function () {
				if ($(this).is(':checked')) {
				    $("#select2").css("visibility","visible"); 
				} else {
				    $("#select2").css("visibility","hidden"); 
				} 
			});
			
			$('#supplies3').click(function () {
				if ($(this).is(':checked')) {
				    $("#select3").css("visibility","visible"); 
				} else {
				    $("#select3").css("visibility","hidden"); 
				} 
			});
				
		});
		
	</script>
</head>
<body>
	<div id="container">
		<div id="header">
        	<img alt="logo" src="./images/logo.png"/>
        </div>         
      	<jsp:include page="./upperMenu.jsp" />        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
			<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Agregar Suministro:</h2><br>
			<p>Escoga el(los) suministro(s) que desea agregar haciendo clic en la columna izquierda de la tabla, seleccione la cantidad deseada y luego haga clic en "Agregar".</p>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>Escoger</th>
										<th>ID</th>
										<th>Nombre</th>
										<th>Área</th>
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>
											<input type="checkbox" name="supplies" id="supplies1" value="12345" >
											<select name="select" id="select1" style="visibility:hidden;">
											 	<option value="value1">1</option> 
											   	<option value="value1">2</option>
											    <option value="value1">3</option>
											    <option value="value1">4</option>
												<option value="value1">5</option>
												<option value="value1">6</option>
												<option value="value1">7</option>
												<option value="value1">8</option>
												<option value="value1">9</option>
												<option value="value1">10</option>
											</select>
										</td>
										
										<td>1001</td>
										<td>Albumina Humana 20% 50 ml</td>
										<td>Albumina Humana 20% 50 ml</td>
									</tr>
									<tr class="gradeA">
										<td>
											<input type="checkbox" name="supplies" id="supplies2" value="12345">
											<select name="select" id="select2" style="visibility:hidden;">
											 	<option value="value1">1</option> 
											   	<option value="value1">2</option>
											    <option value="value1">3</option>
											    <option value="value1">4</option>
												<option value="value1">5</option>
												<option value="value1">6</option>
												<option value="value1">7</option>
												<option value="value1">8</option>
												<option value="value1">9</option>
												<option value="value1">10</option>
											</select>
										</td>
										<td>1002</td>
										<td>Benutrex B12 Ampolla</td>
										<td>Albumina Humana 20% 50 ml</td>
									</tr>
									<tr class="gradeA">
										<td>
											<input type="checkbox" name="supplies" id="supplies3" value="12345">	
											<select name="select" id="select3" style="visibility:hidden;">
											 	<option value="value1">1</option> 
											   	<option value="value1">2</option>
											    <option value="value1">3</option>
											    <option value="value1">4</option>
												<option value="value1">5</option>
												<option value="value1">6</option>
												<option value="value1">7</option>
												<option value="value1">8</option>
												<option value="value1">9</option>
												<option value="value1">10</option>
											</select>
										</td>
										<td>1003</td>
										<td>Daktarin Crema</td>
										<td>Albumina Humana 20% 50 ml</td>
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