<%@page import="domain.User"%>
<%@page import="domain.PendingEstimationDiscount"%>
<%@ page import="java.util.ArrayList" %>
<%@page import="domain.Estimation"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	String info_text = "";
	String info = (String) session.getAttribute("info");
	if (info != null ){
		info_text = info;
	}
	session.removeAttribute("info");
	@SuppressWarnings("unchecked")
	ArrayList<PendingEstimationDiscount> pending  =  (ArrayList<PendingEstimationDiscount>) request.getAttribute("pending");
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Solicitudes Pendientes</title>
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
	
	function loadVars(var1, var2, var3) {
		id = var1;
		$('.cliente').text(var2);
		$('.monto').text(var3);
		
	};
	
	function setV(f){
		f.elements['id'].value = id;
		return true;
	}
	</script>
</head>
<body>
	<div id="container">
		<div id="header">
        	
        </div>        
        <nav>
			      <ul>
			      	 <li><a href="#">Bienvenido, <%= name %></a></li>
			        <li><a href="ListRequestsServlet">Solicitudes<span class="badge red">2</span></a></li>
			      </ul>
		    </nav> 
      	<jsp:include page="./upperMenu.jsp" />        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
	    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Solicitudes Pendientes:</h2><br/>
			<div class="info-text"><%= info_text %></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>Descuento</th>
										<th># Presupuesto</th>
										<th>Fecha</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>		
									<% for (int i = 0; i < pending.size(); i++){
										PendingEstimationDiscount estimation = pending.get(i);
										Long id 		= estimation.getDiscountID();
										String pacName 	= estimation.getFirstName() + " " + estimation.getLastName();
										String amount 	= estimation.getAmount(); 
									%>	
									<tr class="gradeA">
										<td><%= id %></td>
										<td><%= pacName %></td>
										<% if (estimation.getType().trim().equalsIgnoreCase("P")){ %>
										<td><%= amount %>%</td>
										<% }else{ %>
										<td>Bs. <%= amount %></td>
										<%} %>
										<td><%= Estimation.leftPadStringWithChar(estimation.getEstimationID().toString(),9,'0') %></td>
										<td><%= estimation.getRequestDate() %></td>
										<td>
											<a href="ShowDiscountServlet?discountId=<%= id %>" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#refreshUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= id %>,'<%= pacName %>', '<%= amount %>');" >
												<img alt="logo" src="./images/check.png"  height="16" width="16" title="Aceptar"/>
											</a> 
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= id %>,'<%= pacName %>','<%= amount %>');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Rechazar"/>
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
		<div id="deleteUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Rechazar Descuento</h3>
				<br><br>
				<span>¿Está seguro que desea rechazar el descuento de Bs. <span class="monto"></span>  para el paciente <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="DiscountActionServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="id" class="good_input" name="id"  value=""/>
					<input type="hidden"  class="buttonPopUpDelete"  name="sbmtButton" value="Rechazar"  />
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="button" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="refreshUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Aceptar Descuento</h3>
				<br><br>
				<span>¿Desea aceptar el descuento de Bs. <span class="monto"></span>  para el paciente <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="DiscountActionServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="id" class="good_input" name="id"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>