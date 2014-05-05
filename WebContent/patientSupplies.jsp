<%@page import="domain.PatientSupply"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<PatientSupply> supplies = (ArrayList<PatientSupply>) request.getAttribute("supplies");
	
	String patName = (String) request.getAttribute("patName");
	String adminId 	= (String) request.getAttribute("adminId");
	
	String text_result = (String) session.getAttribute("text");
	if (text_result == null)
		text_result = "";
	session.removeAttribute("text");
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Suministros Paciente</title>
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
	var v3, v4;
	
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2, var3, var4) {
		idUser = var1;
		$('.cliente').text(var2);
		v3 = var3;
		v4 = var4;
	};
	
	function setV(f){
		f.elements['userId'].value = idUser;
		f.elements['id'].value = v3;
		f.elements['name'].value = v4;
		return true;
	}
	</script>
</head>
<body>
	<div id="container">
		<div id="header">
        	<img alt="logo" src="./images/logo.png"/>
        </div>         
      	<jsp:include page="./upperMenu.jsp" />        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
	    	<ul>
            	<li class="menuitem"><a href="ListSupplyServlet">Ver Pacientes</a></li>
            	<li class="menuitem"><a href="AddPatientSupplyServlet?id=<%=adminId%>&name=<%=patName%>">Agregar Suministros</a></li>
            </ul>
			<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Suministros <%=patName%>:</h2><br/>
			<div class="info-text"><%=text_result%></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>Id</th>
										<th>Suministro</th>
										<th>Cantidad</th>
										<th>Total</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>		
									<%
										for (int i=0; i< supplies.size(); i++){
										PatientSupply s = supplies.get(i);
									%>	
									<tr class="gradeA">
										<td><%= s.getPatientSupplyID() %></td>
										<td><%= s.getSupplyName() %></td>
										<td><%= s.getAmount() %></td>
										<td><%= s.getTotal() %></td>
										<td>
											<a href="EditPatientSupplyServlet?id=<%=adminId%>&name=<%=patName%>&spId=<%= s.getPatientSupplyID() %>" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= s.getPatientSupplyID() %>,'<%= s.getSupplyName() %>',<%= adminId %>, '<%= patName %>');" >
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
		<div id="deleteUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Servicio</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el suministro <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemovePatientSupplyServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<input type="hidden" id="id" class="good_input" name="id"  value=""/>
					<input type="hidden" id="name" class="good_input" name="name"  value=""/>
					
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		
		
	</body>
</html>