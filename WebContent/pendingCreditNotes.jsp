<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Facturación</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
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
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        <nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="pendingAdmissionDischarges.jsp">Altas Admisión<span class="badge yellow">3</span></a></li>
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
        	<div id="content" style="position:absolute;">	
	        	<h2>Prefacturas por Generar:</h2><br>
	        	<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>Médico Tratante</th>
										<th>Responsable Pago</th>
										<th>Total</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>1001</td>
										<td>Ana Rojas</td>
										<td>Beatriz Perez</td>
										<td>Multinacional de Seguros</td>
										<td>Bs. 20501</td>
										<td>
											<a id="go" rel="leanModal" href="#printUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'1001');" >
												<img alt="logo" src="./images/print.png"  height="16" width="16" title="Imprimir"/>
											</a>  
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1002</td>
										<td>Luis Mujica</td>
										<td>Maritza Chacón</td>
										<td>La Previsora</td>
										<td>Bs. 12345</td>
										<td>
											<a id="go" rel="leanModal" href="#printUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'1001');" >
												<img alt="logo" src="./images/print.png"  height="16" width="16" title="Imprimir"/>
											</a> 
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1003</td>
										<td>Miguel Álvarez</td>
										<td>Aura Guillén</td>
										<td>Seguros Caroní</td>
										<td>Bs. 19283</td>
										<td>
											<a id="go" rel="leanModal" href="#printUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'1001');" >
												<img alt="logo" src="./images/print.png"  height="16" width="16" title="Imprimir"/>
											</a> 
											<br>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="spacer"></div>
			</div>
		</div>
		<div id="printUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Imprimir Prefactura</h3>
				<br><br>
				<span>¿Desea imprimir la prefactura n° <span class="cliente"></span>?</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="printCreditNote.jsp" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>