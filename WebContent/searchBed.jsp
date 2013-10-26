<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Escoger Cama</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		var oTable = $('#example').dataTable( {
			"iDisplayLength": 7,
			"bLengthChange": false,
			"sScrollY": "150px",
			"bPaginate": false,
			"aoColumns": [
				{ "bSearchable": false, "asSorting": false, "sWidth": "10%"},
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
		$(document).ready(function() {
			
			function getUrlVars() {
			    var vars = {};
			    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
			        vars[key] = value;
			    });
			    return vars;
			}

			var first = getUrlVars()["function"];
			first = first.replace(/\+/g, ' ');
			if (first != null){
				if (first.indexOf("Emergency") > 0){
					$("#emergencies").attr('class', 'active');
					if (first == "editEmergency")
						$("#form").attr('action', 'EditEmergencyServlet');
				}
				else if (first.indexOf("Hospitalization") > 0){
					$("#hospitalization").attr('class', 'active');
					if (first == "editHospitalization")
						$("#form").attr('action', 'EditHospitalizationServlet');
					
				}
				else if (first.indexOf("Patient") > 0){
					$("#admission").attr('class', 'active');
					if (first == "admitPatient")
						$("#form").attr('action', 'AdmitPatientServlet');
					
				}
			}
				
		});
		
	</script>
	<script type="text/javascript">
	var idUser;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });
		
		$("#next").click(function() {
			$("#beds").css("visibility","visible"); 
			$("#botonReg").hide();
		});
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
        	<img alt="logo" src="./images/logo.png"/>
        </div>         
      	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="ListAdmissionDischargesServlet">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
	    	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        </div>        
         <jsp:include page="./menu.jsp" />
		<div id="content">  
			<form action="" method="get" id="form" style="display: inline;">
				
			<h2>Escoger ubicación de cama:</h2><br>
			<p>Por favor seleccione la ubicación de la cama y haga clic en Siguiente:</p><br>
			<p><b>Ubicación:  </b> 
				<select id="bedLocationId" name="bedLocationId">
								<option value="UCI" >UCI</option>
								<option value="Planta Baja" >Planta Baja</option>
								<option value="Piso 1" >Piso 1</option>
								<option value="Piso 2" >Piso 2</option>
				</select>
				<input id="next" type="button" value="Siguiente">
			</p>
				<div id="botonReg" style="position: absolute; margin-top: 40px; margin-left: 320px;">
					<br><input type="button" class="button" value="Regresar"
						onClick="javascript:history.back();" />
				</div>
			<br><br>
			<div id="beds" style="visibility: hidden;">
				Escoga la cama que desea haciendo clic en la columna izquierda de la tabla y luego haga clic en "Seleccionar":
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
											<td><input type="radio" name="bed" value="Camilla 1"><br>
											</td>
											<td>1</td>
											<td>Camilla 1</td>
											<td>Bs. 0.0</td>

										</tr>
										<tr class="gradeA">
											<td><input type="radio" name="bed" value="Camilla 2"><br>
											</td>
											<td>2</td>
											<td>Camilla 2</td>
											<td>Bs. 0.0</td>

										</tr>
										<tr class="gradeA">
											<td><input type="radio" name="bed" value="Camilla 3"><br></td>
											<td>3</td>
											<td>Camilla 3</td>
											<td>Bs. 0.0</td>

										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<br>
						<div id="botonera">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Seleccionar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<input type="submit" class="button" value="Regresar" />		
								</div>	
						</div>
					</div>
				
			</div>
			</form>
			<div class="spacer"></div>
        	</div>
       	</div>
		
	</body>
</html>