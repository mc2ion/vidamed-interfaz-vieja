<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Escoger Responsable de Pago</title>
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
				{ "bSearchable": false, "asSorting": false, "sWidth": "10%"  },
				null,
				null,
				null,
				null
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
				if (first.indexOf("CreditNote") > 0){
					$("#admission").attr('class', 'active');
					if (first == "editCreditNoteEstimation")
						$("#form").attr('action', 'editCreditNoteEstimation.jsp');
				}
				else if (first.indexOf("Admission") > 0){
					$("#admission").attr('class', 'active');
					if (first == "editAdmissionEstimation")
						$("#form").attr('action', 'editAdmissionEstimation.jsp');
				}
				else if (first.indexOf("Pharmacy") > 0){
					$("#supplyAreas").attr('class', 'active');
					if (first == "editPharmacyEstimation")
						$("#form").attr('action', 'editPharmacyEstimation.jsp');
				}
				else if (first.indexOf("Estimation") > 0){
					$("#estimation").attr('class', 'active');
					if (first == "editEstimation"){
						$("#form").attr('action', 'editEstimation.jsp');
					}
					else if (first == "createEstimation")
						$("#form").attr('action', 'createEstimation.jsp');
				}
				else if (first.indexOf("Hospitalization") > 0){
					$("#hospitalization").attr('class', 'active');
					if (first == "editHospitalization")
						$("#form").attr('action', 'edithospitalization.jsp');
					
				}
				else if (first.indexOf("Patient") > 0){
					$("#admission").attr('class', 'active');
					if (first == "admitPatient")
						$("#form").attr('action', 'admitPatient.jsp');
					
				}
			}
				
		});
		
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
        	<img alt="logo" src="./images/logo.png"/>
        </div>         
      	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="pendingAdmissionDischarges.jsp">Altas Admisi�n<span class="badge yellow">3</span></a></li>
		 		<li><a href="pendingCreditNotes.jsp">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="pendingCreditNotesReview.jsp">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="pendingInvoices.jsp">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="pendingRequest.jsp">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="pendingPharmacyDischarges.jsp">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="billing.jsp">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="mainMenu.jsp">Home</a></div>	
	    	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Escoger responsable del pago:</h2><br>
			<p> Por favor seleccione el responsable de pago en la columna izquierda de la tabla y luego haga clic en "Seleccionar" </p>
			<form action="" method="get" id="form" style="display: inline;">
	
			<div id="dt_example">
					<div id="container">
					
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>Escoger</th>
										<th>ID</th>
										<th>Nombre</th>
										<th>Direcci�n</th>
										<th>Tel�fono</th>
										
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>
											<input type="checkbox" name="insurance" value="Pago en Efectivo"><br>
										</td>
										<td>1</td>
										<td>Pago en Efectivo</td>
										<td>N/A</td>
										<td>N/A</td>
									</tr>
									<tr class="gradeA">
										<td>
											<input type="checkbox" name="insurance" value="La Previsora"><br>
										</td>
										<td>2</td>
										<td>La Previsora</td>
										<td>Plaza Venezuela. Direcci�n: Av. Francisco Solano con Av. Las Acacias, Torre La Previsora, PB, Plaza Venezuela, Caracas</td>
										<td>0212-7935632</td>
									</tr>
									<tr class="gradeA">
										<td>
											<input type="checkbox" name="insurance" value="Multinacional de Seguros C.A"><br>
										</td>
										<td>3</td>
										<td>Multinacional de Seguros, C.A</td>
										<td>Avenida Bland�n con Mohedano, Torre Multinacional de Seguros, La Castellana, Caracas</td>
										<td>0212-6203200</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div><br>
					
					<div id="botonera" style="margin-top: -10px;">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Seleccionar" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="submit" class="button" value="Regresar" />		
						</div>	
					</div>
				</div>
				</form>
				<div class="spacer"></div>
        	</div>
       	</div>
		
	</body>
</html>