<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Prefacturas por Revisar</title>
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
                <li><a href="pendingAdmissionDischarges.jsp">Altas Admisi�n<span class="badge yellow">3</span></a></li>
		 		<li><a href="pendingCreditNotes.jsp">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="pendingCreditNotesReview.jsp">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="pendingInvoices.jsp">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="pendingRequest.jsp">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="pendingPharmacyDischarges.jsp">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="billing.jsp">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>          
        <div id="menu">
			<div class="menuitemHome" ><a href="mainMenu.jsp">Home</a></div>	
	    	<ul>
            	<li class="menuitem"><a href="admission.jsp">Ver Admisiones</a></li>
            </ul>
            <div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Prefacturas por Revisar:</h2>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>Responsable Pago</th>
										<th>Total</th>
										<th>Contacto</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>1001</td>
										<td>Ana Rojas</td>
										<td>Multinacional de Seguros</td>
										<td>Bs. 20501</td>
										<td>Beatriz Perez / 0212-2340017 ext 114</td>
										<td>
											<a href="editCreditNoteEstimation.jsp" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Ana Rojas');" >
												<img alt="logo" src="./images/refresh.png"  height="16" width="16" title="Reenviar Prefactura" />
											</a>
											<a id="go" rel="leanModal" href="#generateInvoice" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Ana Rojas');" >
												<img alt="logo" src="./images/check.png" height="16" width="16" title="Generar Factura"/>
											</a> 
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1002</td>
										<td>Luis Mujica</td>
										<td>La Previsora</td>
										<td>Bs. 12345</td>
										<td>Maritza Chac�n / 02127819239 ext 216</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1002,'Luis Mujica');" >
												<img alt="logo" src="./images/refresh.png"  height="16" width="16" title="Reenviar Prefactura" />
											</a>
											<a id="go" rel="leanModal" href="#generateInvoice" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1002,'Luis Mujica');" >
												<img alt="logo" src="./images/check.png" height="16" width="16" title="Generar Factura"/>
											</a>
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1003</td>
										<td>Miguel �lvarez</td>
										<td>Seguros Caron�</td>
										<td>Bs. 19283</td>
										<td>Aura Guill�n / 02122831781 ext 506</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1003,'Miguel �lvarez');" >
												<img alt="logo" src="./images/refresh.png"  height="16" width="16" title="Reenviar Prefactura" />
											</a>
											<a id="go" rel="leanModal" href="#generateInvoice" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1003,'Miguel �lvarez');" >
												<img alt="logo" src="./images/check.png" height="16" width="16" title="Generar Factura"/>
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
		<div id="deleteUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Reenviar Prefactura</h3>
				<br><br>
				<span>�Est� seguro que desea reenviar la prefactura de <span class="cliente"></span> al responsable de pago? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="pendingCreditNotesReview.jsp" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="generateInvoice">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Generar Factura</h3>
				<br><br>
				<span>�Est� seguro que desea generar la factura definitiva de <span class="cliente"></span> para el responsable de pago?</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="pendingCreditNotesReview.jsp" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>