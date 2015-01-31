<%@page import="domain.PendingCreditNotesReview"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	

	@SuppressWarnings("unchecked")
	ArrayList<PendingCreditNotesReview> cnList = (ArrayList<PendingCreditNotesReview>)request.getAttribute("creditNotes");
	
	String result = (String) session.getAttribute("info");
	String text = "";
	if (result != null)
		text = result;
	session.removeAttribute("info");
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Prefacturas por Revisar</title>
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
	    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Prefacturas por Revisar:</h2><br/>
			<div class="info-text"><%= text %></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>Responsable Pago</th>
										<th>Total</th>
										<th>Contacto</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>		
									<% for(int i=0; i<cnList.size(); i++){
										PendingCreditNotesReview p = cnList.get(i);
										String pName = p.getPatient().getFirstName() + " " + p.getPatient().getLastName();
										String prName = p.getPaymentResposible().getName();
										String cName = p.getContactName();
										String cNumber = p.getContactNumber();
										if (cName == null)
											cName = "No Disponible";
										if (cNumber == null)
											cNumber = "No Disponible";
									%>	
									<tr class="gradeA">
										<td><%= p.getCreditNoteID() %></td>
										<td><%= pName %></td>
										<td><%= prName %></td>
										<td>Bs. <%=(p.getTotalWithDiscount() != null) ? p.getTotalWithDiscount() : p.getTotal() %></td>
										<td><%= cName %>/ <%= cNumber %></td>
										<td>
											<a href="ShowCreditNoteEstimationServlet?id=<%= p.getAdmissionID() %>&factId=<%= p.getCreditNoteID() %>" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<a id="go" rel="leanModal" href="#discount" style="color: #f7941e; font-weight: bold;" onclick="return loadVars(<%= p.getAdmissionID() %>,'');" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Aplicar Descuento" />			
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= p.getCreditNoteID() %>,'<%= pName %>');" >
												<img alt="logo" src="./images/refresh.png"  height="16" width="16" title="Reenviar Prefactura" />
											</a>
											<a id="go" rel="leanModal" href="#generateInvoice" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars(<%= p.getCreditNoteID() %>,'<%= pName %>');" >
												<img alt="logo" src="./images/check.png" height="16" width="16" title="Generar Factura"/>
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
				<h3 id="see_id" class="sprited" > Reenviar Prefactura</h3>
				<br><br>
				<span>¿Está seguro que desea reenviar la prefactura de <span class="cliente"></span> al responsable de pago? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ForwardCreditNoteServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="generateInvoice">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Generar Factura</h3>
				<br><br>
				<span>¿Está seguro que desea generar la factura definitiva de <span class="cliente"></span> para el responsable de pago?</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="CreateBillServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<input type="hidden" id="userReviewId" class="good_input" name="userReviewId"  value="<%= user.getUserID() %>"/>
					
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="discount">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Aplicar Descuento</h3><br><br>
				Por favor, indique la siguiente información.
				<form action="ApplyDiscountServlet" method="post"  onsubmit="return setV(this)">
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="text">
						<div class="leftColum"><b>Descuento:</b></div>
							<select name="type">
								<option value="P">%</option>
								<option value="M">Bs.</option>
							</select>
							<input type="text" pattern="^[0-9]+(\.[0-9]+)?$" name="amount" size='10' required title="Este campo es numerico y no puede ser dejado en blanco"/>
						<br>
						<div class="leftColum"><b>Justicación:</b></div><textarea name="justification" style="width: 148px;" required title="El campo 'Justificación' no puede ser dejado en blanco"></textarea><br>
					</div>
					<div id="signup-header">
						<a class="close_x" id="close_x_aux"  href="#"></a>
					</div>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpAux"  name="sbmtButton" value="Aplicar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>