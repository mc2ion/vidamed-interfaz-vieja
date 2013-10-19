<!DOCTYPE >
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Farmacia</title>
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
            	<li class="menuitem"><a href="createSupplyArea.jsp">Crear �rea Insumos</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>�reas de Insumos:</h2>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Nombre</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>1001</td>
										<td>F�rmacos</td>
										<td>
											<a href="supplies.jsp" style="color: transparent" >
												<img alt="logo" src="./images/meds.png"  height="18" width="18" title="Ver Farmacia" />
											</a>
											<a href="editSupplyArea.jsp" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'F�rmacos');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1002</td>
										<td>Material M�dico Quir�rgico</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/meds.png"  height="18" width="18" title="Ver Farmacia" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1002,'Material M�dico Quir�rgico');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
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
				<h3 id="see_id" class="sprited" > Eliminar �rea Insumos</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar el �rea de insumos '<span class="cliente"></span>' y los insumos asociados? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="supplyAreas.jsp" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>