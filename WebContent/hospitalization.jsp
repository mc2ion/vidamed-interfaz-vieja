<%@page import="domain.DischargeType"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%@page import="domain.Hospitalization"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	@SuppressWarnings("unchecked")
	ArrayList<Hospitalization> hospList  =  (ArrayList<Hospitalization>) request.getAttribute("hospitalizations");
	
	@SuppressWarnings("unchecked")
	ArrayList<DischargeType> disc  =  (ArrayList<DischargeType>) request.getAttribute("discharges");
	
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
	<title>Hospitalización</title>
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
				{ "bSearchable": false, "asSorting": false }
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
		$('.idf').text(var1);
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
			<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Hospitalización:</h2><br/>
			<div class="info-text"><%= info_text %></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>Ubicación</th>
										<th>Cama</th>
										<th>Fecha Ingreso</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>		
									<% for (int i= 0; i< hospList.size() ; i++){
										Hospitalization hosp = hospList.get(i);
										String patName = hosp.getPatient().getFirstName() + " " + hosp.getPatient().getLastName();
										
									%>	
									<tr class="gradeA">
										<td><%= hosp.getId() %></td>
										<td><%= patName %></td>
										<td><%= hosp.getLocation().getName() %></td>
										<td><%= hosp.getBed().getName() %></td>
										<td><%= hosp.getAdmissionDate() %></td>
										<td>
											<a href="ShowHospitalizationServlet?id=<%= hosp.getId() %>" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a href="EditHospitalizationServlet?id=<%= hosp.getId() %>" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#dischargeUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= hosp.getId() %>,'<%=patName %>');" >
												<img alt="logo" src="./images/check.png"  height="16" width="16" title="Dar de Alta" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= hosp.getId() %>,'<%=patName %>');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<a href="PrintStatementServlet?id=<%= hosp.getId() %>" style="color: transparent" >
												<img alt="logo" src="./images/movements.png"  height="16" width="16" title="Corte de Cuenta" />
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
				<h3 id="see_id" class="sprited" > Eliminar Hospitalización</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar del sistema la hospitalización #<span class="idf"></span>  de <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveAdmissionServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userID" class="good_input" name="userID"  value=""/>
					<input type="hidden" id="function" class="good_input" name="function"  value="hospitalization"/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="dischargeUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Dar de Alta</h3>
				<br><br>
				<span>¿Está seguro que desea darle de alta a <span class="cliente"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="DischargePatientServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userID" class="good_input" name="userID"  value=""/>
					<input type="hidden" id="function" class="good_input" name="function"  value="hospitalization"/>
					Indique Razón: 
					<select name="dischargeID">
						<% for (int i=0; i< disc.size(); i++){ 
							DischargeType dType = disc.get(i);
						%>
						<option value="<%= dType.getId() %>"><%= dType.getName() %></option>
						<% } %>
					</select>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>