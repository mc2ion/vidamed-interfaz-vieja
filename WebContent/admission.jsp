<%@page import="domain.AdmissionStatus"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Admission"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<Admission> admissionList  =  (ArrayList<Admission>) request.getAttribute("admissions");
	@SuppressWarnings("unchecked")
	ArrayList<AdmissionStatus> admissionStatus = (ArrayList<AdmissionStatus>) request.getAttribute("status");
	
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
	<title>Admisión</title>
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
            	<li class="menuitem"><a href="AdmitPatientFormServlet">Admitir Paciente</a></li>
            </ul>
            <div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Admisión:</h2><br/>
			<div class="info-text"><%= info_text %></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Cédula</th>
										<th>Paciente</th>
										<th>Tipo</th>
										<th>Responsable Pago</th>
										<th>Status</th>
										<th>Ubicación</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>		
									<%
										for (int i = 0; i< admissionList.size(); i++){ 
											Admission admin = admissionList.get(i);
											int isAdult = admin.getIsAdult();
											String type = "Pediátrico";
											if (isAdult == 1)
												type = "Adulto";
											Long id = admin.getAdmissionID() ;
											String patient = admin.getFirstName() + " " + admin.getLastName() ;
									%>
									<tr class="gradeA">
										<td><%= id %></td>
										<td><%=  admin.getIdentityCard() %></td>
										<td><%= patient %></td>
										<td><%= type %></td>										
										<td><%= admin.getResponsibleName() %></td>
										<td><%= admin.getStatusName() %></td>
										<td><%= admin.getReasonName() %></td>
										<td>
											<a id="go" rel="leanModal" href="#editStatus" style="color: #f7941e; font-weight: bold;"
											onclick="return loadVars(<%= id %>,'<%= patient %>');">
												<img alt="logo" src="./images/edit.png" height="16" width="16" title="Editar"/>
											</a> 
											<a href="ShowAdmissionServlet?id=<%= id %>" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= id %>,'<%= patient %>');" >
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
				<h3 id="see_id" class="sprited" > Eliminar Admisión</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar del sistema la admisión de <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveAdmissionServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userID" class="good_input" name="userID"  value=""/>
					<input type="hidden" id="function" class="good_input" name="function"  value="admission"/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="editStatus">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Editar Status</h3>
				<br><br>
				<span>Seleccione el nuevo status</span> <br><br>
				<form action="EditAdmissionStatusServlet" method="post" onsubmit="return setV(this)" id="gastos" style="text-align: center">
					<input type="hidden" id="userID" class="good_input" name="userID"  value=""/>
					<select name="status">
					<option value="-">Seleccionar</option>
					<% for (int i = 0; i < admissionStatus.size(); i++){
						AdmissionStatus status = admissionStatus.get(i);
						%>
						<option value="<%= status.getId() %>"><%= status.getName() %></option>
					<% } %>
					</select>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<div class="btn-fld">
					<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
				</div>
		 		</form>
			</div>
		</div>
	</body>
</html>