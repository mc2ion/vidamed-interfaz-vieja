<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Cuentas por Cobrar y Pagar</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<script type="text/javascript" charset="utf-8">
		$(document).ready(function() {
			$('#example').dataTable( {
			"iDisplayLength": 5,
			"bLengthChange": false,
			"sScrollY": "200px",
			"bPaginate": false,
			"aoColumns": [
				null,
				null,
				null,
				null,
				{ "bSearchable": false, "asSorting": false, "sWidth": "18%" }
			],
			"oLanguage": {
	            "sLengthMenu": " ",
	            "sZeroRecords": "No hay ningún registro que coincida con su búsqueda",
	            "sInfo": " ",
	            "sInfoEmpty": " ",
	            "sInfoFiltered": " ",
	            "sEmptyTable": "No hay datos disponibles en la tabla",
	            "sLoadingRecords": "Por favor, espere - cargando...",
	            "sSearch": "Buscar:"
        	}
		} );
			
			$('#example2').dataTable( {
				"iDisplayLength": 5,
				"bLengthChange": false,
				"sScrollY": "200px",
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
		            "sLengthMenu": " ",
		            "sZeroRecords": "No hay ningún registro que coincida con su búsqueda",
		            "sInfo": " ",
		            "sInfoEmpty": " ",
		            "sInfoFiltered": " ",
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
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x, .buttonPopUpDelete" });		
		});

		function loadVars(var1, var2, var3, var4) {
			idUser = var1;
			$('.type').text(var2);
			$('.name').text(var3);
			$('.actionAccount').text(var4);

		};

		function setV(f){
			f.elements['userId'].value = idUser;
			return true;
		}
		</script>
		<script>
			$(function() {
				$("#tabs").tabs();
				$("#tabs").tabs("select", window.location.hash);
			});
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
        	<div id="content" style="position:absolute;">	
	        	<h2>Cuentas:</h2><br>
	        	<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Por Cobrar</a></li>
					    <li><a href="#tabs-2">Por Pagar</a></li>
					</ul>
  					<div id="tabs-1">
  						<div style="text-align:right; margin-top: 5px; margin-bottom:20px;">
	  						<a href="CreateReceivableServlet" style="color: #006c92; font-weight: bold;">
								<img alt="logo" src="./images/add.png" height="12" width="12" />Agregar Cuenta por Cobrar
							</a>						
  						</div>
 								<div id="demo">
								<table class="display" id="example">
									<thead>
										<tr>
											<th>ID</th>
											<th>Seleccionar</th>
											<th>Empresa</th>
											<th>Monto</th>
											<th>Fecha Vencimiento</th>
											<th>Acciones</th>
										</tr>
									</thead>
									<tbody>			
										<tr class="gradeA">
											<td>1001</td>
											<td><input type="checkbox" name="account" value="1"/></td>
											<td>Vidamed</td>
											<td>Bs. 15000</td>
											<td>20/08/2013</td>
											<td>
												<a href="EditReceivableServlet" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
												</a>
												<a href="ShowReceivableServlet" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Cobrar', 'Vidamed');" >
													<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
												</a> 
												<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Cobrar', 'Vidamed', 'cobrada');" >
													<img alt="logo" src="./images/check.png" height="16" width="16" title="Cobrada"/>
												</a> 
												<br>
											</td>
										</tr>
										<tr class="gradeA">
											<td>1002</td>
											<td><input type="checkbox" name="account" value="2"/></td>
											<td>La Previsora</td>
											<td>Bs. 5000</td>
											<td>25/11/2013</td>
											<td>
												<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
												</a>
												<a href="#" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Cobrar', 'La Previsora');" >
													<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
												</a> 
												<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Cobrar', 'La Previsora', 'cobrada');" >
													<img alt="logo" src="./images/check.png" height="16" width="16" title="Cobrada"/>
												</a> 
												<br>
											</td>
										</tr>
										<tr class="gradeA">
											<td>1003</td>
											<td><input type="checkbox" name="account" value="3"/></td>
											<td>Multinacional de Seguros</td>
											<td>Bs. 34500</td>
											<td>17/10/2013</td>
											<td>
												<a href="#" style="color: transparent" >
													<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
												</a>
												<a href="#" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Cobrar', 'Multinacional de Seguros');" >
													<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
												</a> 
												<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Cobrar', 'Multinacional de Seguros', 'cobrada');" >
													<img alt="logo" src="./images/check.png" height="16" width="16" title="Cobrada"/>
												</a> 
												<br>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					<div id="tabs-2">
  						<div style="text-align:right; margin-top: 5px; margin-bottom:20px;">
	  						<a href="CreateAccountPayableServlet" style="color: #006c92; font-weight: bold;">
								<img alt="logo" src="./images/add.png" height="12" width="12" />Agregar Cuenta por Pagar
							</a>						
  						</div>
  								<div id="demo">
								<table class="display" id="example2">
									<thead>
										<tr>
											<th>ID</th>
											<th>Empresa</th>
											<th>Monto</th>
											<th>Fecha Vencimiento</th>
											<th>Acciones</th>
										</tr>
									</thead>
									<tbody>			
										<tr class="gradeA">
											<td>1001</td>
											<td>Hospital Online</td>
											<td>Bs. 15000</td>
											<td>20/09/2013</td>
											<td>
												<a href="EditAccountPayableServlet" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
												</a>
												<a href="ShowAccountPayableServlet" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Pagar', 'Hospital Online');">
													<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
												</a> 
												<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Pagar', 'Vidamed', 'pagada');" >
													<img alt="logo" src="./images/check.png" height="16" width="16" title="Pagada"/>
												</a> 
												<br>
											</td>
										</tr>
										<tr class="gradeA">
											<td>1002</td>
											<td>Multinacional de Seguros</td>
											<td>Bs. 5000</td>
											<td>25/11/2013</td>
											<td>
												<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
												</a>
												<a href="#" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Pagar', 'Multinacional de Seguros');" >
													<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
												</a> 
												<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Pagar', 'Multinacional de Seguros', 'pagada');" >
													<img alt="logo" src="./images/check.png" height="16" width="16" title="Pagada"/>
												</a> 
												<br>
											</td>
										</tr>
										<tr class="gradeA">
											<td>1003</td>
											<td>Vidamed</td>
											<td>Bs. 34500</td>
											<td>17/10/2013</td>
											<td>
												<a href="#" style="color: transparent" >
													<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
												</a>
												<a href="#" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Pagar', 'Vidamed');" >
													<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
												</a> 
												<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Pagar', 'Vidamed', 'pagada');" >
													<img alt="logo" src="./images/check.png" height="16" width="16" title="Pagada"/>
												</a> 
												<br>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
					</div>
  				</div>
			</div>
		</div>
		<div id="deleteUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Cuenta Por <span class="type"></span>  </h3>
				<br><br>
				<span>¿Está seguro que desea eliminar la cuenta por <span class="type"></span>  de <span class="name"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form >
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="closeAccount">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Pagar cuenta <span class="type"></span>  </h3>
				<br><br>
				<span>¿Está seguro que la cuenta de <span class="name"></span> fue <span class="actionAccount"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form >
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>