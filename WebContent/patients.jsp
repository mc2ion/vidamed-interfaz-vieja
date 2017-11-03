<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<!DOCTYPE HTML>
<%@ page import="domain.Patient" %>
<%@ page import="java.util.ArrayList" %>
<%
	@SuppressWarnings("unchecked")
	ArrayList<Patient> patients = (ArrayList<Patient>)request.getAttribute("patients");
	String patientname				= (String)request.getAttribute("patientname");
	String identityCard 			= (String)request.getAttribute("identitycard");
	String str = "", num = "";
	if (identityCard != null && identityCard != ""){
		str = identityCard.substring(0,2);
		num = identityCard.substring(2);
	}
%>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Pacientes</title>
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
	var rId;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2) {
		rId = var1;
		$('.ids').text(var1);
		$('.cliente').text(var2);
		
	};
	
	function setV(f){
		f.elements['rId'].value = rId;
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
			<h2>Pacientes:</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListPatientsServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Paciente:</b></td><td><input  type="text" name="patientname" maxlength="100" size="20" value="<%= (patientname != null) ? patientname : "" %>" /></td>
									<td><b>C&eacute;dula de Identidad:</b></td>
									<td>
										<select name="txtCedId" id="txtCedId">
											<option value="V-" <%= (str.equals("V-"))?"selected":"" %>>V</option>
											<option value="E-" <%= (str.equals("E-"))?"selected":"" %>>E</option>
										</select>
										<input type="text" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" value="<%= num %>"/>
									</td>
									<td><b></b></td><td></td>
								</tr>
							</table>	
							<input type="submit" class="buttonGreen lessPadding"   style="float: right; margin-right:40px; margin-top: 5px;" value="Buscar">
							</fieldset>
  						</div>	
  						</form>
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Tipo</th>
										<th>G&eacute;nero</th>
										<th>C&eacute;dula de Identidad</th>
										<th>Nombre</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>			
									<% 
									if (patients.size() != 0) { 
										for (int i = 0; i<patients.size(); i++) { 
											Patient patient = patients.get(i);
									%>
									<tr class="gradeA">
										<td><%= patient.getPatientID() %></td>
										<td><%= (patient.getIsAdult()==0)?"Pediátrico":"Adulto" %></td>
										<td><%= (patient.getGender().equals("F"))?"Femenino":"Masculino" %></td>
										<td><%= patient.getIdentityCard() %></td>
										<td><%= patient.getFirstName() + " " + patient.getLastName() %></td>									
										<td>
											<a href="EditPatientServlet?rId=<%=patient.getPatientID() %>" style="color: transparent;" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars('<%=patient.getPatientID() %>','<%=patient.getFirstName() + " " + patient.getLastName() %>');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<br>
										</td>
									</tr>
									<% 		}
										} %>
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
				<h3 id="see_id" class="sprited" > Eliminar Paciente</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el paciente #<span class="ids"></span> "<span class="cliente"></span>"? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemovePatientServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="rId" class="good_input" name="rId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>