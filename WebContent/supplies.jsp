<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%@ page import="domain.Supply" %>
<%@ page import="java.util.ArrayList" %>
<%
	@SuppressWarnings("unchecked")
	ArrayList<Supply> supplies = (ArrayList<Supply>)request.getAttribute("supplies");
	Long supplyAreaID = (Long) request.getAttribute("supplyAreaID");
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Insumos</title>
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
	var idSupply;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2) {
		idSupply = var1;
		$('.cliente').text(var2);
		
	};
	
	function setV(f){
		f.elements['supplyID'].value = idSupply;
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
                <li><a href="ListAdmissionDischargesServlet">Altas Admisi�n<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
			<ul>
            	<li class="menuitem"><a href="ListSupplyAreasServlet">Ver �reas Insumos</a></li>
            	<li class="menuitem"><a href="CreateSupplyServlet?supplyAreaID=<%= supplyAreaID %>" style="margin-left:15px;">Crear Insumo</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Insumos:</h2>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Nombre</th>
										<th>Cantidad</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<% if (supplies.size() == 0)  { %>
											<tr class="gradeA"><td colspan="4">No hay insumos disponibles</td></tr>
									<% }
								   	   else { 
								   			for (int i = 0; i<supplies.size(); i++) { 
								   				Supply s = supplies.get(i);
									%>
												<tr class="gradeA">
													<td><%= s.getSupplyID() %></td>
													<td><%= s.getName() %></td>
													<td><%= s.getAmount() %></td>
													<td>
														<a href="EditSupplyServlet?supplyID=<%= s.getSupplyID() %>" style="color: transparent" >
															<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
														</a>
														<a id="go" rel="leanModal" href="#deleteSupply" style="color: #f7941e; font-weight: bold;" 
															onclick="return loadVars(<%= s.getSupplyID() %>,'<%= s.getName() %>');" >
															<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
														</a> 
														<br>
													</td>
												</tr>
									<%		}
								   		}
								   	%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="spacer"></div>
       	</div>
		</div>
		<div id="deleteSupply">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Insumo</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar el insumo '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveSupplyServlet?supplyAreaID=<%= supplyAreaID %>" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="supplyID" class="good_input" name="supplyID"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>