<%@page import="domain.PatientMedicalAdvice"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<PatientMedicalAdvice> supplies = (ArrayList<PatientMedicalAdvice>) request.getAttribute("advice");
	
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
	<title>Consultas Paciente</title>
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
	var v2, v3;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2, var3) {
		idUser = var1;
		$('.cliente').text(var1);
		v2 = var2;
		v3 = var3;
	};
	
	function setV(f){
		f.elements['userId'].value = idUser;
		f.elements['id'].value = v2;
		f.elements['name'].value = v3;
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
            	<li class="menuitem"><a href="/ListInterServlet">Ver Pacientes</a></li>
            	<li class="menuitem"><a href="/AddPatientServiceServlet?id=<%=adminId%>&name=<%=patName%>">Agregar Consulta</a></li>
            </ul>
			<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Consultas <%=patName%>:</h2><br/>
			<div class="info-text"><%=text_result%></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>Id</th>
										<th>Unidad</th>
										<th>Especialista</th>
										<th>Honorario</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>		
									<%
												for (int i=0; i< supplies.size(); i++){
													PatientMedicalAdvice s = supplies.get(i);
													String spName = s.getSpecialist().getFirstName() + " " +  s.getSpecialist().getLastName();
											%>	
									<tr class="gradeA">
										<td><%= s.getPatientMedicalAdviceID() %></td>
										<td><%= s.getUnitName() %></td>
										<td><%= spName %></td>
										<td><%= s.getMedicalFeed() %></td>
										<td>
											<a href="#" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= s.getPatientMedicalAdviceID() %>,'<%= adminId %>', '<%= patName %>');" >
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
				<h3 id="see_id" class="sprited" > Eliminar Consulta</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar la consulta #<span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemovePatientMedicalAdviceServlet" method="post"  onsubmit="return setV(this)">
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