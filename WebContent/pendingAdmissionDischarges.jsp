<%@page import="domain.PendingAdmissionDischarges"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%@page import="domain.PaymentResponsible"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	

	@SuppressWarnings("unchecked")
	ArrayList<PendingAdmissionDischarges> admiList = (ArrayList<PendingAdmissionDischarges>)request.getAttribute("admissions");
	
	Long cashPayment = (Long)request.getAttribute("cashPayment");
	
	@SuppressWarnings("unchecked")
	ArrayList<PaymentResponsible> resp = (ArrayList<PaymentResponsible>)request.getAttribute("responsibles");
	
	String responsibles = "<select name=\"paymentId\" id=\"paymentId\" required><option value=\"\">Seleccionar</option>";
	for (int i = 0; i < resp.size(); i++){
		PaymentResponsible p = resp.get(i);
		String info = p.getName();
		responsibles = responsibles + "<option value=\""+p.getId()+"\">"+info+"</option>";
	}
	responsibles += "</select>";
	
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
	<title>Altas Admisión Pendientes</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" charset="utf-8">
	$(function() {
		$(document).on("click", ".add", function(event){
			var rowCount = $('#mrp table >tbody >tr').length;
			var hide = '';
			
			$('.add').addClass("hide");
			$('.remove').removeClass("hide");			
			rowCount++;
			
			if(rowCount == 3){
				hide = 'hide';
			}
			
			$('#mrp table tbody').append('<tr><td><%= responsibles %></td><td><input type="text" id="additionalKeyNumber" name="additionalKeyNumber" /></td><td><input type="number" id="additionalCoverageAmount" name="additionalCoverageAmount" step="0.01" required /></td><td><input type="text" id="additionalGuaranteeLetter" name="additionalGuaranteeLetter" /></td><td><a class="add ' + hide + '"><img src="./images/add.png" /></a><a class="remove"><img src="./images/delete.png" /></a></td></tr>');
		});
		
		$(document).on("click", ".remove", function(event){
			this.closest("tr").remove();
			$("#mrp table tbody tr").last().find(".add").removeClass("hide");
			
	      	if($("#mrp table tbody tr").length==1){
				$("#mrp table tbody tr").last().find(".remove").addClass("hide");
			}
		});
	});
	
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
		
		$('#imrp').on("change", function(){
			if(this.checked){
				$('#mrp').removeClass("hide");
				$('#mrp').addClass("show");
			} else {
				$('#mrp').addClass("hide");
				$('#mrp').removeClass("show");
			}
		});
	} );
	</script>
	<script type="text/javascript">
	var idUser;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2, var3, var4) {
		idUser = var1;
		$('.cliente').text(var2);
		if(var3 != <%= cashPayment %>){
			$('#seguro').css('display', 'block');
			$('#discharge').removeClass('short-alert');
			$('#discharge').addClass('large-alert');
			$('#prname').text(var4);
		} else {
			$('#seguro').css('display', 'none');
			$('#discharge').removeClass('large-alert');
			$('#discharge').addClass('short-alert');
		}
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
            <div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Altas Admisión Pendientes:</h2><br/>
			<div class="info-text"><%= text %></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>Médico Tratante</th>
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
											<a href="ShowAdmissionDischargesServlet?id=<%= ad.getAdmissionID() %>" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#discharge" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= ad.getAdmissionID() %>,'<%= pName %>','<%= ad.getPaymentResponsibleID() %>','<%= ad.getPaymentResponsibleName() %>');" >
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
		<div id="discharge" class="short-alert">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Alta de Admisión</h3>
				<br><br>
				<span>¿Está seguro que desea darle el alta de admisión a <span class="cliente"></span>? </span> <br><br>
				<span style="color: red; font-size: small; font-style: italic;">
					Recuerde que debe verificar los servicios de Rayos X, Laboratorio y Servicios Médicos del paciente antes de darle de alta.
				</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="SetAdmissionDischargeServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div id="seguro">
						<div>Responsable de Pago: <span id="prname"></span></div>
						<br>
						<div>N° Clave: <input type="text" id="keyNumber" name="keyNumber" /></div>
						<br>
						<div>Monto Cobertura: <input type="number" id="coverageAmount" name="coverageAmount" step="0.01" /></div>
						<br>
						<div>N° Carta Aval: <input type="text" id="guaranteeLetter" name="guaranteeLetter" /></div>
						<br>
						<div><input type="checkbox" id="imrp" name="imrp" value="1">Multiples Responsables de Pago</div>
						<br>
						<div id="mrp" class="hide">
							<table>
								<thead>
									<tr>
										<th>Responsable de Pago</th>
										<th>N° Clave</th>
										<th>Monto Cobertura</th>
										<th>N° Carta Aval</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<%= responsibles %>
										</td>
										<td>
											<input type="text" id="additionalKeyNumber" name="additionalKeyNumber" />
										</td>
										<td>
											<input type="number" id="additionalCoverageAmount" name="additionalCoverageAmount" step="0.01" required />
										</td>
										<td>
											<input type="text" id="additionalGuaranteeLetter" name="additionalGuaranteeLetter" />
										</td>
										<td>
											<a class="add"><img src="./images/add.png" /></a>
											<a class="remove hide"><img src="./images/delete.png" /></a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<br>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>