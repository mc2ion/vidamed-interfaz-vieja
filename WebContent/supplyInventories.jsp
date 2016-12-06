<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%@ page import="domain.SupplyInventory" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="domain.PermissionsList"%>
<%
	@SuppressWarnings("unchecked")
	ArrayList<SupplyInventory> supplyInventories = (ArrayList<SupplyInventory>)request.getAttribute("supplyInventories");
	Long supplyAreaID = (Long) request.getAttribute("supplyAreaID");
	Long supplyID = (Long) request.getAttribute("supplyID");
	
	String info_text = "";
	String info = (String) session.getAttribute("info");
	if (info != null ){
		info_text = info;
	}
	session.removeAttribute("info");
	boolean perm = PermissionsList.hasPermission(request, PermissionsList.pharmacyAdminRestricted);
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Inventarios</title>
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
	            "sEmptyTable": "No hay inventarios disponibles",
	            "sLoadingRecords": "Por favor, espere - cargando...",
	            "sSearch": "Buscar:"
        	}
		} );
	} );
	</script>
	<script type="text/javascript">
	var idSupplyInventory;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2) {
		idSupplyInventory = var1;
		$('.cliente').text(var2);
		
	};
	
	function setV(f){
		f.elements['supplyInventoryID'].value = idSupplyInventory;
		return true;
	}
	</script>
</head>
<body>
	<div id="container">
		<div id="header">
        	
        </div>         
      	<jsp:include page="./upperMenu.jsp" />        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
			<ul>
            	<li class="menuitem"><a href="ListSupplyAreasServlet">Ver Áreas Insumos</a></li>
            	<li class="menuitem"><a href="ListSuppliesServlet?supplyAreaID=<%= supplyAreaID %>" style="margin-left:15px;">Ver Insumos</a></li>
            	<li class="menuitem"><a href="CreateSupplyInventoryServlet?supplyID=<%= supplyID %>&supplyAreaID=<%= supplyAreaID %>" style="margin-left:15px;">Crear Inventario</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Inventarios:</h2><br/>
			<div class="info-text"><%= info_text %></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Fabricante</th>
										<th>Número Lote</th>
										<th>Fecha Vencimiento</th>
										<th>Cantidad</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<% 	for (int i = 0; i<supplyInventories.size(); i++) { 
								   			SupplyInventory s = supplyInventories.get(i);
									%>
											<tr class="gradeA">
												<td><%= s.getSupplyInventoryID() %></td>
												<td><%= s.getManufacturer() %></td>
												<td><%= s.getLotNumber() %></td>
												<td><%= s.getExpirationDate() %></td>
												<td><%= s.getAmount() %></td>
												<td>
												<% if(!perm){ %>
													<a href="EditSupplyInventoryServlet?supplyInventoryID=<%= s.getSupplyInventoryID() %>&supplyID=<%= s.getSupplyID() %>&supplyAreaID=<%= supplyAreaID %>" style="color: transparent" >
														<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
													</a>
													<a id="go" rel="leanModal" href="#deleteSupply" style="color: #f7941e; font-weight: bold;" 
														onclick="return loadVars(<%= s.getSupplyInventoryID() %>,'<%= s.getSupplyInventoryID() %>');" >
														<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
													</a> 
												<% } %>
													<br>
												</td>
											</tr>
									<%	} %>
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
				<h3 id="see_id" class="sprited" > Eliminar Inventario</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el inventario n° '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveSupplyInventoryServlet?supplyAreaID=<%= supplyAreaID %>&supplyID=<%= supplyID %>" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="supplyInventoryID" class="good_input" name="supplyInventoryID"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>