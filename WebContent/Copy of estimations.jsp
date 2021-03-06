<%@page import="domain.Estimation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<Estimation> est = (ArrayList<Estimation>) request.getAttribute("est");
	
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
	<title>Presupuestos</title>
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
		$('.num').text(var1);
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
        	
        </div>         
      	<jsp:include page="./upperMenu.jsp" />        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
	    	<ul>
            	<li class="menuitem"><a href="CreateEstimationFormServlet">Crear Presupuesto</a></li>
            </ul>
			<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Presupuestos:</h2>
			<div class="info-text"><%= info_text %></div>
			
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>Tipo</th>
										<th>Descuento</th>
										<th>Total</th>
										<th>Total Con Descuento</th>
										<th>Fecha</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<% for (int i=0; i< est.size(); i++){
										Estimation p = est.get(i);
									%>	
									<tr class="gradeA">
										<td style="width:5%"><%= p.getId() %></td>
										<td><%= p.getFirstName() + " " + p.getLastName() %></td>
										<td><%= (p.getIsAdult() != null && p.getIsAdult().equals("1")) ? "Adulto" : "Pedi�trico" %></td>
										<td><%= p.getDiscount() %></td>
										<td><%= (p.getTotal()!= null) ? p.getTotal() : "-" %></td>
										<td><%= (p.getTotalWithDiscount()!= null) ? p.getTotalWithDiscount() : "No Aplica" %></td>
										<td><%= p.getEditionDate() %></td>
										<td>
											<a href="ShowEstimationServlet?function=estimations&id=<%= p.getId() %>" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#printUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars('<%= p.getId() %>','<%= p.getFirstName() + " " + p.getLastName() %>');" >
												<img alt="logo" src="./images/print.png"  height="16" width="16" title="Imprimir"/>
											</a> 
											<a href="EditEstimationServlet?id=<%= p.getId() %>" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#refreshEstimation" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars('<%= p.getId() %>','<%= p.getFirstName() + " " + p.getLastName() %>');" >
												<img alt="logo" src="./images/refresh.png"  height="16" width="16" title="Actualizar"/>
											</a> 
											<% if (!p.getDiscount().equals("pending")){ %>
											<a id="go" rel="leanModal" href="#discount" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars('<%= p.getId() %>','<%= p.getFirstName() + " " + p.getLastName() %>');" >
												<img alt="logo" src="./images/movements.png"  height="16" width="16" title="Solicitar Descuento"/>
											</a> 
											<% } %>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars('<%= p.getId() %>','<%= p.getFirstName() + " " + p.getLastName() %>');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<br>
										</td>
									</tr>
									<% } %>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="spacer"></div>
        	</div>
       	</div>
		<div id="printUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Imprimir Presupuesto</h3>
				<br><br>
				<span>Seleccione en qu� formato desea imprimir el presupuesto n� <span class="cliente"></span>: </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="PrintEstimationCompatServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete2"  name="sbmtButton" value="Compacto"  />
					</div>
		 		</form>
				<form action="PrintEstimationDetailServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete3"  name="sbmtButton" value="Detallado"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="deleteUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Presupuesto</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar el presupuesto n� <span class="num"></span> del cliente <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveEstimationServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="discount">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Solicitar Descuento</h3><br><br>
				Por favor, indique la siguiente informaci�n.
				<form action="AskForEstimationDiscount" method="post"  onsubmit="return setV(this)">
					<div class="text">
					<div class="leftColum"><b>Descuento:</b></div>
						<select name="typeDiscount">
							<option value="P">%</option>
							<option value="Monto">Bs.</option>
						</select>
						<input type="text" size='10' name="amount"/>
					<br>
					<div class="leftColum"><b>Justificaci�n:</b></div><textarea style="width: 138px;" name="justify"></textarea><br>
					</div>
					<div id="signup-header">
					<a class="close_x" id="close_x_aux"  href="#"></a>
					</div>
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpAux"  name="sbmtButton" value="Solicitar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="refreshEstimation">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Actualizar Presupuesto</h3>
				<br><br>
				<span>�Desea actualizar fecha y costos del presupuesto seleccionado? </span> <br><br>
				<span class="help">Recuerde que una vez actualizado, si este presupuesto posee un descuento aprobado, ser� enviado nuevamente a verificaci�n para que sea revisado y re-aprobado de acuerdo a los nuevos montos.</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="UpdateEstimationServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
	<style>
	table.display td { padding: 3px 0px;} 
	.dataTables_scrollHeadInner {width: 790px !important;} 
	</style>
</html>