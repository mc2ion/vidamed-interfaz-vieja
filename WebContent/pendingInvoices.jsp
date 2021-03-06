<%@page import="domain.PendingBills"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<PendingBills> bills = (ArrayList<PendingBills>) request.getAttribute("bills");
	
	String result = (String) session.getAttribute("info");
	String text = "";
	if (result != null)
		text = result;
	session.removeAttribute("info");
	
	Long cashPayment = (Long)request.getAttribute("cashPayment");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Facturaci�n</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
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
	
	function loadVars(var1, var2, var3, var4) {
		//idUser = var1;
		$('.cliente').text(var4);
		$('#admId').attr('value', var1);
		$('#factId').attr('value', var2);
		$('#prefactId').attr('value', var4);
		console.log("test:", var3, <%= cashPayment %>, var3 == <%= cashPayment %>);
		
		if(var3 == <%= cashPayment %>){
			$("#formats option[value=PrintInvoiceReportsServlet]").hide();
		} else {
			$("#formats option[value=PrintInvoiceReportsServlet]").show();
		}
	};
	
	function setV2(f){
		return true;
	};
	
	function loadVars2(var1, var2, var3) {
		idUser = var1;
		$('.cliente').text(var2);	
		$('.pid').text(var3);		
	};
	
	function setV2(f){
		f.elements['userId'].value = idUser;
		return true;
	};
	
	function formatSelected(f){
		var opt = $('#formats').val();
		if(opt=='PrintInvoiceCompactServlet'){
			$('#correlativeNumberField').css('display','block');
		}else{
			$('#correlativeNumberField').css('display','none');
		}
		$('#printForm').attr('action', opt);
		return true;
	};
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
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Facturas por Generar:</h2><br>
	        	<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Paciente</th>
										<th>M�dico Tratante</th>
										<th>Responsable Pago</th>
										<th>Total</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>			
									<% for (int i = 0; i < bills.size(); i++){
										PendingBills b = bills.get(i);	
										String pName = b.getPatient().getFirstName() + " " + b.getPatient().getLastName();
										String eName = b.getSpecialist().getFirstName() + " " +  b.getSpecialist().getLastName();
										
										
									%>
									<tr class="gradeA">
										<td><%= b.getCreditNoteID() %></td>
										<td><%= pName %></td>
										<td><%= eName %></td>
										<td><%= b.getPaymentResposible().getName() %></td>
										<td>Bs. <%= (b.getTotalWithDiscount() == null) ? b.getTotal() : b.getTotalWithDiscount() %></td>
										<td>
											<a id="go" rel="leanModal" href="#printUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars('<%= b.getAdmissionID() %>','<%= b.getBillID() %>','<%= b.getPaymentResposible().getId() %>','<%= b.getCreditNoteID() %>');" >
												<img alt="logo" src="./images/print.png"  height="16" width="16" title="Imprimir"/>
											</a>    
											<a id="go" rel="leanModal" href="#discount" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars2('<%= b.getBillID() %>', '<%= pName  %>','<%= b.getCreditNoteID() %>');" >
												<img alt="logo" src="./images/check.png"  height="16" width="16" title="Generada"/>
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
		<div id="printUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Imprimir Factura</h3>
				<br>
				<span>Seleccione en qu� formato desea imprimir la factura n� <span class="cliente"></span>:</span> <br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<!-- Hay que hacer ambas versiones para imprimir -->
				<form action="PrintInvoiceCompactServlet" method="post"  onsubmit="return setV(this)" id="printForm" style="text-align: center;">
					<input type="hidden" id="admId" class="good_input" name="admId"  value=""/>
					<input type="hidden" id="factId" class="good_input" name="factId"  value=""/>
					<input type="hidden" id="prefactId" class="good_input" name="prefactId"  value=""/>
					<input type="hidden" id="f" class="good_input" name="f"  value="in"/>
					<select onchange="return formatSelected(this)" id="formats">
						<option value="PrintInvoiceCompactServlet">Compacto</option>
						<option value="PrintInvoiceServlet">Detallado</option>
						<option value="PrintInvoiceServicesServlet">Servicios Auxiliares</option>
						<option value="PrintInvoiceSuppliesServlet">Material M&eacute;dico y F&aacute;rmacos</option>
						<option value="PrintInvoiceReportsServlet">Reportes</option>
					</select><br><br>
					<div id="correlativeNumberField">
						N� de Correlativo: <input type="number" name="correlativeNumber" id="correlativeNumber" />
					</div>
					<br>
					<input type="submit"  class="buttonPopUpDelete2"  name="sbmtButton" value="Aceptar" style="position: static;"  />
		 		</form>
			</div>
		</div>
		<div id="discount">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Generada</h3><br><br>
				<span>�Est� seguro que la factura n� <span class="pid"></span> del paciente <span class="cliente"></span> est� generada (fue impresa)?</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="GenerateBillServlet" method="post"  onsubmit="return setV2(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<input type="hidden" id="id" class="good_input" name="id"  value="<%= user.getUserID() %>"/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
				
			</div>
		</div>
	</body>
</html>