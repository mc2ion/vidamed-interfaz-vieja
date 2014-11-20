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
	            "sZeroRecords": "No hay ningún registro que coincida con su búsqueda",
	            "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ registros",
	            "sInfoEmpty": "Mostrando 0 a 0 de 0 registros",
	            "sInfoFiltered": "(filtrando de _MAX_ registros totales)",
	            "sEmptyTable": "No hay insumos disponibles",
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
        	
        </div>         
      	<jsp:include page="./upperMenu.jsp" />        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
			<ul>
            	<li class="menuitem"><a href="ListSupplyAreasServlet">Ver Áreas Insumos</a></li>
            	<li class="menuitem"><a href="CreateSupplyServlet?supplyAreaID=<%= supplyAreaID %>" style="margin-left:15px;">Crear Insumo</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Insumos:</h2><br/>
			<div class="info-text"><%= info_text %></div>
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
									<% 	for (int i = 0; i<supplies.size(); i++) { 
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
				<h3 id="see_id" class="sprited" > Eliminar Insumo</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el insumo '<span class="cliente"></span>'? </span> <br><br>
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