<%@page import="domain.PendingAdmissionDischarges"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	

	@SuppressWarnings("unchecked")
	ArrayList<PendingAdmissionDischarges> admiList = (ArrayList<PendingAdmissionDischarges>)request.getAttribute("admissions");
	
	String result = (String) session.getAttribute("info");
	String text = "";
	if (result != null)
		text = result;
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Altas Admisi�n Pendientes</title>
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
            	<li class="menuitem"><a href="ListAdmissionsServlet">Ver Admisiones</a></li>
            </ul>
            <div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Altas Admisi�n Pendientes:</h2><br/>
			<div class="info-text"><%= text %></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>M�dico Tratante</th>
										<th>Fecha Ingreso</th>
										<th>Fecha Egreso</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>		
									<% for (int i=0; i< admiList.size(); i++){
										PendingAdmissionDischarges ad = admiList.get(i);
										String pName = ad.getPatient().getFirstName() + " " + ad.getPatient().getLastName();
										String eName = ad.getSpecialist().getFirstName()+ " " + ad.getSpecialist().getLastName();
										
										%>	
									<tr class="gradeA">
										<td><%= ad.getAdmissionID() %></td>
										<td><%= pName %></td>
										<td><%= eName %></td>
										<td><%= ad.getAdmissionDate() %></td>
										<td><%= ad.getDischargeDate() %></td>
										<td>
											<a href="EditAdmissionEstimationServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#dischargeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= ad.getAdmissionID() %>,'<%= pName %>');" >
												<img alt="logo" src="./images/check.png"  height="16" width="16" title="Dar de Alta" />
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
		<div id="dischargeUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Alta de Admisi�n</h3>
				<br><br>
				<span>�Est� seguro que desea darle el alta de admisi�n a <span class="cliente"></span>? </span> <br><br>
				<span style="color: red; font-size: small; font-style: italic;">
					Recuerde que debe verificar los servicios de Rayos X, Laboratorio y Servicios M�dicos del paciente antes de darle de alta.
				</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="SetAdmissionDischargeServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>