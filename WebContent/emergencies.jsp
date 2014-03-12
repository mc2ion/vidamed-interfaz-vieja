<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Emergencia</title>
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
                <li><a href="ListAdmissionDischargesServlet">Altas Admisi�n<span class="badge yellow">3</span></a></li>
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
			<h2>Emergencia:</h2>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>Ubicaci�n</th>
										<th>Cama</th>
										<th>Fecha Ingreso</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>1001</td>
										<td>Ana Rojas</td>
										<td>Planta Baja</td>
										<td>Camilla 1</td>
										<td>20/06/2013 07:35</td>
										<td>
											<a href="ShowEmergencyServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a href="EditEmergencyServlet" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#dischargeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Ana Rojas');" >
												<img alt="logo" src="./images/check.png"  height="16" width="16" title="Dar de Alta" />
											</a>
											<a id="go" rel="leanModal" href="#hospitalizeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Ana Rojas');" >
												<img alt="logo" src="./images/hospitalize.png"  height="18" width="18" title="Hospitalizar"/>
											</a> 
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Ana Rojas');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<a href="PrintStatementServlet" style="color: transparent" >
												<img alt="logo" src="./images/movements.png"  height="16" width="16" title="Corte de Cuenta" />
											</a>
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1002</td>
										<td>Luis Mujica</td>
										<td>Planta Baja</td>
										<td>Cupo 6</td>
										<td>20/06/2013 08:42</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#dischargeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1002,'Luis Mujica');" >
												<img alt="logo" src="./images/check.png"  height="16" width="16" title="Dar de Alta" />
											</a>
											<a id="go" rel="leanModal" href="#hospitalizeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1002,'Luis Mujica');" >
												<img alt="logo" src="./images/hospitalize.png"  height="18" width="18" title="Hospitalizar"/>
											</a> 
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1002,'Luis Mujica');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/movements.png"  height="16" width="16" title="Corte de Cuenta" />
											</a>
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1003</td>
										<td>Miguel �lvarez</td>
										<td>Planta Baja</td>
										<td>Camilla 17</td>
										<td>20/06/2013 08:55</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#dischargeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1003,'Miguel �lvarez');" >
												<img alt="logo" src="./images/check.png"  height="16" width="16" title="Dar de Alta" />
											</a>
											<a id="go" rel="leanModal" href="#hospitalizeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1003,'Miguel �lvarez');" >
												<img alt="logo" src="./images/hospitalize.png"  height="18" width="18" title="Hospitalizar"/>
											</a> 
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1003,'Miguel �lvarez');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/movements.png"  height="16" width="16" title="Corte de Cuenta" />
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
				<h3 id="see_id" class="sprited" > Eliminar Emergencia</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar del sistema la emergencia de <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListEmergenciesServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="dischargeUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Dar de Alta</h3>
				<br><br>
				<span>�Est� seguro que desea darle de alta a <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListEmergenciesServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					Indique Raz�n: 
					<select>
						<option value="1">Alta Administrativa</option>
						<option value="2">Alta M�dica</option>
						<option value="3">Alta por Defunci�n</option>
						<option value="4">Alta por Traslado</option>
						<option value="4">Alta Contraindicaci&oacute;n M&eacute;dica</option>
					</select>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="hospitalizeUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Hospitalizar</h3>
				<br><br>
				<span>�Qu� acci�n desea realizar sobre los gastos del paciente <span class="cliente"></span>? </span> <br><br>
				<form id="gastos" style="text-align: center">
					<select>
						<option value="-">Seleccionar</option>
						<option value="F">Generar una factura</option>
						<option value="T">Trasladar los gastos actuales</option>
					</select>
				</form>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListEmergenciesServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>