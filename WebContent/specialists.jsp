<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%@ page import="domain.Specialist" %>
<%@ page import="domain.Unit" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
	@SuppressWarnings("unchecked")
	ArrayList<Specialist> specialists = (ArrayList<Specialist>)request.getAttribute("specialists");
	@SuppressWarnings("unchecked")
	HashMap<Long, ArrayList<Unit>> specialistUnits = (HashMap<Long, ArrayList<Unit>>)request.getAttribute("specialistUnits");
	
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
	<title>Especialistas</title>
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
	            "sEmptyTable": "No hay especialistas disponibles",
	            "sLoadingRecords": "Por favor, espere - cargando...",
	            "sSearch": "Buscar:"
        	}
		} );
	} );
	</script>
	<script type="text/javascript">
	var idSpecialist;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2) {
		idSpecialist = var1;
		$('.cliente').text(var2);
		
	};
	
	function setV(f){
		f.elements['specialistID'].value = idSpecialist;
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
                <li><a href="ListAdmissionDischargesServlet">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
			<ul>
            	<li class="menuitem"><a href="CreateSpecialistServlet">Crear Especialista</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Especialistas:</h2><br/>
			<div class="info-text"><%= info_text %></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Nombre</th>
										<th>Apellido</th>
										<th>Unidad(es)</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>	
									<% 	for (int i = 0; i<specialists.size(); i++) { 
									   		Specialist spec = specialists.get(i);
									   		ArrayList<Unit> units = (ArrayList<Unit>)specialistUnits.get(spec.getId());
									   		String unitNames = "";
									   		for (int j = 0; j<units.size(); j++) {
									   			unitNames += ", " + units.get(j).getName();
									   		}
									   		unitNames = unitNames.length() < 2 ? unitNames : unitNames.substring(2);
									%> 		
											<tr class="gradeA">
												<td><%= spec.getId() %></td>
												<td><%= spec.getFirstName() %></td>
												<td><%= spec.getLastName() %></td>
												<td><%= unitNames %></td>
												<td>
													<a href="EditSpecialistServlet?specialistID=<%= spec.getId() %>" style="color: transparent" >
														<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
													</a>
													<a id="go" rel="leanModal" href="#deleteSpecialist" style="color: #f7941e; font-weight: bold;" 
														onclick="return loadVars(<%= spec.getId() %>,'<%= spec.getFirstName() + " " + spec.getLastName() %>');" >
														<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
													</a> 
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
		<div id="deleteSpecialist">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Especialista</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el especialista '<span class="cliente"></span>' y su información asociada? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveSpecialistServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="specialistID" class="good_input" name="specialistID"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>