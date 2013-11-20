<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Cajas</title>
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
				{ "bSearchable": false, "asSorting": false, "sWidth": "18%" }
			],
			"oLanguage": {
	            "sLengthMenu": "Mostrar _MENU_ registros",
	            "sZeroRecords": "No hay ningún registro que coincida con su búsqueda",
	            "sInfo": " ",
	            "sInfoEmpty": " ",
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
		$('.caja').text(var2);
		
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
            	<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        </div>        
			 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Cajas:</h2>
			<div id="printCashBox"><a href="SearchCashBoxFormServlet" id="printCashBoxText" >Imprimir cierre de cajas</a></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Nombre</th>
										<th>Status</th>
										<th>Monto Inicial</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>1001</td>
										<td>Caja Principal</td>
										<td>Abierta</td>
										<td>Bs. 100</td>
										<td>
											<a id="go" rel="leanModal" href="#closeCashW" style="color: #f7941e; font-weight: bold;"
											onclick="return loadVars(1001,'Principal');" >
												<img alt="logo" src="./images/close.png"  height="16" width="16" title="Cerrar Caja" />
											</a>
											<a href="CreatePaymentServlet" style="color: transparent" >
												<img alt="logo" src="./images/movements.png"  height="16" width="16" title="Registrar Pago" />
											</a>
											<a href="ShowCashBoxServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a href="EditCashBoxServlet" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar Caja" />
											</a>
											<a id="go" rel="leanModal" href="#deleteCash" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Principal');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1002</td>
										<td>Caja Imagen</td>
										<td>Cerrada</td>
										<td>-</td>
										<td>
											<a id="go" rel="leanModal" href="#openCashW" style="color: #f7941e; font-weight: bold;"
											onclick="return loadVars(1001,'Imagen');"  >
												<img alt="logo" src="./images/open.png"  height="16" width="16" title="Abrir Caja" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar Caja" />
											</a>
											<a id="go" rel="leanModal" href="#deleteCash" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Imagen');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1003</td>
										<td>Caja Radiología</td>
										<td>Cerrada</td>
										<td>-</td>
										<td>
											<a id="go" rel="leanModal" href="#openCashW" style="color: #f7941e; font-weight: bold;"
											onclick="return loadVars(1001,'Radiología');"  >
												<img alt="logo" src="./images/open.png"  height="16" width="16" title="Abrir Caja" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar Caja" />
											</a>
											<a id="go" rel="leanModal" href="#deleteCash" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Radiología');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1004</td>
										<td>Caja Laboratorio</td>
										<td>Cerrada</td>
										<td>-</td>
										<td>
											<a id="go" rel="leanModal" href="#openCashW" style="color: #f7941e; font-weight: bold;"
											onclick="return loadVars(1001,'Laboratorio');"  >
												<img alt="logo" src="./images/open.png"  height="16" width="16" title="Abrir Caja" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar Caja" />
											</a>
											<a id="go" rel="leanModal" href="#deleteCash" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Laboratorio');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1001</td>
										<td>Caja Administrativa</td>
										<td>Abierta</td>
										<td>Bs. 100</td>
										<td>
											<a id="go" rel="leanModal" href="#closeCashW" style="color: #f7941e; font-weight: bold;"
											onclick="return loadVars(1001,'Administrativa');" >
												<img alt="logo" src="./images/close.png"  height="16" width="16" title="Cerrar Caja" />
											</a>
											<a href="CreateDepositServlet" style="color: transparent" >
												<img alt="logo" src="./images/movements.png"  height="16" width="16" title="Registrar Pago" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
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
		<div id="openCashW">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Abrir Caja</h3>
				<div class="text">
					<div class="leftColum"><b>Caja:</b></div><span class="caja"></span> <br>
					<div class="leftColum"><b>Status:</b></div>Cerrada<br>
					<div class="leftColum"><b>Cajero:</b></div>
					<select>
						<option>Ani Lugo</option>
						<option>Pedro García</option>
						<option>Juan Pérez</option>
						<option>Ana María Luna</option>
					</select>
					<br>
					<div class="leftColum"><b>Clave:</b></div><input type="text"/><br>
					<div class="leftColum"><b>Monto:</b></div><input type="text"/><br><br>
					<span>¿Está seguro que desea abrir la caja</span>  <span class="caja"></span>?  
				</div>
				<div id="signup-header">
					<a class="close_x" id="close_x_aux"  href="#"></a>
				</div>
				
				<form action="ListBanksServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpAux"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
				
		
		<div id="closeCashW">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Cerrar Caja</h3>
				<div class="text">
					<div class="leftColum"><b>Caja:</b></div><span class="caja"></span> <br>
					<div class="leftColum"><b>Status:</b></div>Abierta<br>
					<div class="leftColum"><b>Cajero:</b></div>
					<select>
						<option>Ani Lugo</option>
						<option>Pedro García</option>
						<option>Juan Pérez</option>
						<option>Ana María Luna</option>
						
					</select>
					<br>
					<div class="leftColum"><b>Clave:</b></div><input type="text"/><br>
					<div class="leftColum"><b>Monto:</b></div><input type="text"/><br><br>
					<span>¿Está seguro que desea cerrar la caja</span>  <span class="caja"></span>?  
				</div>
				<div id="signup-header">
					<a class="close_x" id="close_x_aux"  href="#"></a>
				</div>
				<form action="ListBanksServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpAux"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="deleteCash">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Caja</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar la caja</span>  <span class="caja"></span>?  <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListBanksServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		
	</body>
</html>