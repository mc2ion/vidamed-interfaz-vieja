<%@page import="domain.User"%>
<%@ page import="domain.PermissionsList"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%@ page import="domain.SupplyArea" %>
<%@ page import="java.util.ArrayList" %>
<%
	@SuppressWarnings("unchecked")
	ArrayList<SupplyArea> supplyAreas = (ArrayList<SupplyArea>)request.getAttribute("supplyAreas");

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
	            "sEmptyTable": "No hay �reas de insumos disponibles",
	            "sLoadingRecords": "Por favor, espere - cargando...",
	            "sSearch": "Buscar:"
        	}
		} );
	} );
	</script>
	<script type="text/javascript">
	var idSupplyArea;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2) {
		idSupplyArea = var1;
		$('.cliente').text(var2);
		
	};
	
	function setV(f){
		f.elements['supplyAreaID'].value = idSupplyArea;
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
            	<li class="menuitem"><a href="CreateSupplyAreaServlet">Crear �rea Insumos</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>�reas de Insumos:</h2><br/>
			<div class="info-text"><%= info_text %></div>
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
									<% 	for (int i = 0; i<supplyAreas.size(); i++) { 
								   			SupplyArea sa = supplyAreas.get(i);
									%>			
											<tr class="gradeA">
												<td><%= sa.getSupplyAreaID() %></td>
												<td><%= sa.getName() %></td>
												<td>
													<a href="ListSuppliesServlet?supplyAreaID=<%= sa.getSupplyAreaID() %>" style="color: transparent" >
														<img alt="logo" src="./images/meds.png"  height="18" width="18" title="Ver Insumos" />
													</a>
													<a href="EditSupplyAreaServlet?supplyAreaID=<%= sa.getSupplyAreaID() %>" style="color: transparent" >
														<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
													</a>
													<% if(!perm){ %>
													<a id="go" rel="leanModal" href="#deleteSupplyArea" style="color: #f7941e; font-weight: bold;" 
														onclick="return loadVars(<%= sa.getSupplyAreaID() %>,'<%= sa.getName() %>');" >
														<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
													</a> 
													<% } %>
													<br>
												</td>
											</tr>
									<% 	} %>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="spacer"></div>
       	</div>
		</div>
		<div id="deleteSupplyArea">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar �rea Insumos</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar el �rea de insumos '<span class="cliente"></span>' y los insumos asociados? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveSupplyAreaServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="supplyAreaID" class="good_input" name="supplyAreaID"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>