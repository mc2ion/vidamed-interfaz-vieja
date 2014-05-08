<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%@ page import="domain.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
	@SuppressWarnings("unchecked")
	ArrayList<User> users = (ArrayList<User>)request.getAttribute("users");
	@SuppressWarnings("unchecked")
	HashMap<Long, String> userUnits = (HashMap<Long, String>)request.getAttribute("userUnits");
	
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
	<title>Usuarios</title>
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
	            "sEmptyTable": "No hay usuarios disponibles",
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
		f.elements['userID'].value = idUser;
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
            	<li class="menuitem"><a href="CreateUserServlet">Crear Usuario</a></li>
            </ul>
			<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Usuarios:</h2><br/>
			<div class="info-text"><%= info_text %></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Cédula</th>
										<th>Nombre</th>
										<th>Apellido</th>
										<th>Unidad</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>	
									<% 	for (int i = 0; i< users.size(); i++) {
											User u = users.get(i);
											String unitName = userUnits.get(u.getUserUnitID());
									%>		
											<tr class="gradeA">
												<td><%= u.getUserID() %></td>
												<td><%= u.getIdentityCard() %></td>
												<td><%= u.getFirstName() %></td>
												<td><%= u.getLastName() %></td>
												<td><%= unitName == null ? "" : unitName %></td>
												<td>
													<a href="EditUserServlet?userID=<%= u.getUserID() %>" style="color: transparent" >
														<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
													</a>
													<a href="EditUserPasswordServlet?userID=<%= u.getUserID() %>" style="color: transparent" >
														<img alt="logo" src="./images/editPassword2.png"  height="16" width="16" title="Contraseña"/>
													</a>
													<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
														onclick="return loadVars(<%= u.getUserID() %>,'<%= u.getUserID() %>');" >
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
				<h3 id="see_id" class="sprited" > Eliminar Usuario</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el usuario n° <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveUserServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userID" class="good_input" name="userID"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>