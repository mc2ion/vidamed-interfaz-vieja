<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<!DOCTYPE HTML>
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
         		<li><a href="#">Bienvenido, <%= name %></a></li>
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
            	<li class="menuitem"><a href="ListSupplyAreasServlet">Ver Áreas Insumos</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Altas Farmacia Pendientes:</h2>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>Médico Tratante</th>
										<th>Fecha Ingreso</th>
										<th>Fecha Egreso</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>1001</td>
										<td>Ana Rojas</td>
										<td>Ricardo López</td>
										<td>01/10/2013 09:00 pm</td>
										<td>02/10/2013 12:00 pm</td>
										<td>
											<a href="EditPharmacyEstimationServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#dischargeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Ana Rojas');" >
												<img alt="logo" src="./images/check.png"  height="16" width="16" title="Dar de Alta" />
											</a>
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1002</td>
										<td>Luis Mujica</td>
										<td>José Herrera</td>
										<td>02/10/2013 09:00 am</td>
										<td>02/10/2013 01:35 pm</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#dischargeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1002,'Luis Mujica');" >
												<img alt="logo" src="./images/check.png"  height="16" width="16" title="Dar de Alta" />
											</a>
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>1003</td>
										<td>Miguel Álvarez</td>
										<td>Ana Rodriguez</td>
										<td>02/10/2013 09:10 am</td>
										<td>02/10/2013 11:13 am</td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#dischargeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1003,'Miguel Álvarez');" >
												<img alt="logo" src="./images/check.png"  height="16" width="16" title="Dar de Alta" />
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
		<div id="dischargeUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Alta de Farmacia</h3>
				<br><br>
				<span>¿Está seguro que desea darle el alta de farmacia a <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListPharmacyDischargesServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>