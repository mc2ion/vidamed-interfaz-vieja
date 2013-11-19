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
                <li><a href="ListAdmissionDischargesServlet">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>          
        <div id="menu">
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
	    	<ul>
            	<li class="menuitem"><a href="ListAdmissionsServlet">Ver Admisiones</a></li>
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
											<a href="EditCreditNoteEstimationServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#discount" style="color: #f7941e; font-weight: bold;" onclick="return loadVars(1001,'1001');" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Aplicar Descuento" />			
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
										<td>Maritza Chacón / 02127819239 ext 216</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#discount" style="color: #f7941e; font-weight: bold;" onclick="return loadVars(1002,'1002');" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Aplicar Descuento" />			
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
										<td>Miguel Álvarez</td>
										<td>Seguros Caroní</td>
										<td>Bs. 19283</td>
										<td>Aura Guillén / 02122831781 ext 506</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#discount" style="color: #f7941e; font-weight: bold;" onclick="return loadVars(1003,'1003');" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Aplicar Descuento" />			
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1003,'Miguel Álvarez');" >
												<img alt="logo" src="./images/refresh.png"  height="16" width="16" title="Reenviar Prefactura" />
											</a>
											<a id="go" rel="leanModal" href="#generateInvoice" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1003,'Miguel Álvarez');" >
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
				<span>¿Está seguro que desea reenviar la prefactura de <span class="cliente"></span> al responsable de pago? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListCreditNotesReviewServlet" method="post"  onsubmit="return setV(this)">
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
				<span>¿Está seguro que desea generar la factura definitiva de <span class="cliente"></span> para el responsable de pago?</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListCreditNotesReviewServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="discount">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Aplicar Descuento</h3><br><br>
				Por favor, indique la siguiente información.
				<div class="text">
					<div class="leftColum"><b>Descuento:</b></div>
						<select>
							<option value="P">%</option>
							<option value="Monto">Bs.</option>
						</select>
						<input type="text" size='10'/>
					<br>
					<div class="leftColum"><b>Justicación:</b></div><textarea style="width: 138px;"></textarea><br>
				</div>
				<div id="signup-header">
					<a class="close_x" id="close_x_aux"  href="#"></a>
				</div>
				<form action="ListCreditNotesReviewServlet" method="post"  onsubmit="return setV(this)">
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpAux"  name="sbmtButton" value="Aplicar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>