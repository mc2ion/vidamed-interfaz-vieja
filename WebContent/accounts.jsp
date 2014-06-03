<%@page import="domain.PendingAccounts"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<PendingAccounts> pList = (ArrayList<PendingAccounts>)request.getAttribute("pAccounts");
	
	
	String info_text = "";
	String info = (String) session.getAttribute("info");
	if (info != null ){
		info_text = info;
	}
	session.removeAttribute("info");
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Cuentas pendientes</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
		<script type="text/javascript">
		var idUser;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
		});
		
		function loadVars(var1, var2) {
			idUser = var1;
			$('.fId').text(var1);
			$('.name').text(var2);
		};
		
		function setV(f){
			f.elements['userId'].value = idUser;
			return true;
		}
		</script>
		
		<script type="text/javascript" charset="utf-8">
		$(document).ready(function() {
		/*$('#example').dataTable( {
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
	            "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ registros",
	            "sInfoEmpty": "Mostrando 0 a 0 de 0 registros",
	            "sInfoFiltered": "(filtrando de _MAX_ registros totales)",
	            "sEmptyTable": "No hay datos disponibles en la tabla",
	            "sLoadingRecords": "Por favor, espere - cargando...",
	            "sSearch": "Buscar:"
        	}
		} );*/
		
		oTable = $('#example2').dataTable( {
			"iDisplayLength": 7,
			"bLengthChange": false,
			"sScrollY": "250px",
			"bPaginate": false,
			"aoColumns": [
				{"asSorting": false},
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
		oTable.fnSort( [ [1,'desc'] ] );
	} );
	</script>
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Cuentas pendientes:</h2><br/>
			<div class="info-text"><%= info_text %></div>
				<!--<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Por cobrar</a></li>-->
					    <!-- <li><a href="#tabs-2">Por pagar</a></li> -->
					
			  		<!--</ul>
  					<div id="tabs-1">-->
  						
  						<table class="display" id="example2">
								<thead>
									<tr>
										<th>Seleccionar</th>
										<th>No. de Factura</th>
										<th>Fecha Emisión</th>
										<th>Seguro</th>
										<th>Monto</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>		
									<% for (int i = 0; i < pList.size(); i++ ){ 
										PendingAccounts p = pList.get(i);
									%>	
									<tr class="gradeA">
										<td><input type="checkbox" name="selFact" value="1"></td>
										
										<td><%= p.getBillID() %></td>
										<td><%= p.getGenerationDate() %></td>
										<td><%= p.getPaymentResposible().getName() %></td>
										<td>Bs. <%= p.getTotal() %></td>
										<td>
											<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(<%= p.getBillID() %>, '<%= p.getPaymentResposible().getName() %>');" >
											<img alt="logo" src="./images/check.png" height="16" width="16" title="Cobrada"/>
											</a>
											<a href="ShowCashServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<br>
										</td>
									</tr>
									<% } %>
								</tbody>
							</table>
  					<!--</div>
  					 <div id="tabs-2">
  						
  						<table  class="display" id="example">
								<thead>
									<tr>
										<th>No. de Factura</th>
										<th>Cliente</th>
										<th>Cédula o Rif</th>
										<th>Monto</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>			
									<tr class="gradeA">
										<td>168710</td>
										<td>Centro Médico Quirúrgico</td>
										<td>J-71623768-8</td>
										<td>Bs. 1500</td>
										<td>
											<a id="go" rel="leanModal" href="#closeCashW" style="color: #f7941e; font-weight: bold;" >
												<img alt="logo" src="./images/close.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a href="ShowCashServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#deteleCash" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Ana Rojas');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<br>
										</td>
									</tr>
									<tr class="gradeA">
										<td>26673986</td>
										<td>Ana Rojas</td>
										<td>V-193646278</td>
										<td>Bs. 4500</td>
										<td>
											<a id="go" rel="leanModal" href="#openCashW" style="color: #f7941e; font-weight: bold;" >
												<img alt="logo" src="./images/open.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#deteleCash" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(1001,'Ana Rojas');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<br>
										</td>
									</tr>
									
								</tbody>
							</table>
  					</div> 
  				</div> -->
			</div>
		</div>
		<div id="refreshUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Actualizar Presupuesto</h3>
				<br><br>
				<span>¿Desea actualizar fecha y costos del presupuesto seleccionado? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListEstimationsServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="closeAccount">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Pago Cobrado</h3>
				<br><br>
				<span>¿Está seguro que el pago #<span class="fId"></span> del seguro <b><span class="name"></span></b> fue cobrado? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="PayPendingAccountServlet" method="post" onsubmit="return setV(this)" >
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>