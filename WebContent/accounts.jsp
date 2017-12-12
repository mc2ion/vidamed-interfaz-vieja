<%@page import="domain.PendingAccounts"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%@page import="domain.Estimation"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.concurrent.TimeUnit" %>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<PendingAccounts> pList = (ArrayList<PendingAccounts>)request.getAttribute("pAccounts");
	Double total = (Double) request.getAttribute("total");
	
	
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
		<title>Cuentas por Cobrar</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>		
		<!--JS Datapicker-->
		<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			    $( "#date" ).datepicker().datepicker("setDate", new Date());
			});
		</script>
		<script type="text/javascript">
		var idUser;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
		});
		
		function loadVars(var1, var2) {
			idUser = var1;
			$('.fId').text(var1);
			$('.name').text(var2);
		};
		
		function loadVars(var1, var2, var3, var4, var5, var6) {
			idUser = var1;
			$('.fId').text(var1);
			$('.name').text(var2);
			$('.admissionId').val(var3);
			$('.paymentResponsibleId').val(var4);
			$('.hasMultiple').val(var5);
			$('.mainResponsible').val(var6);
		};
		
		function setV(f){
			f.elements['userId'].value = idUser;
			return true;
		}
		</script>
		
		<script type="text/javascript" charset="utf-8">
		$(document).ready(function() {
		/*$('#example').dataTable( {
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
		} );*/
		
		oTable = $('#example2').dataTable( {
			"iDisplayLength": 7,
			"bLengthChange": false,
			"sScrollY": "250px",
			"bPaginate": false,
			"aoColumns": [
				{"bSearchable": false, "asSorting": false},
				{"bSearchable": false, "asSorting": false},
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
		oTable.fnSort( [ [1,'desc'] ] );
	} );
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
        	<div id="content" style="position:absolute;">	
	        	<h2>Cuentas por Cobrar:</h2><br/>
			<div class="info-text"><%= info_text %></div>
				<!--<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Por cobrar</a></li>-->
					    <!-- <li><a href="#tabs-2">Por pagar</a></li> -->
					
			  		<!--</ul>
  					<div id="tabs-1">-->
  						<form id='formFact' method="post" action="PayPendingAccountsServlet">
	  						<div id="printCashBox" class='cuentasP'>
								<label>N&uacute;mero de Documento: </label><input type="text" name="documentnumber" id="documentnumber" size="10">
								<label>Banco: </label><input type="text" name="bank" id="bank" size="25">
								<label>% ISLR: </label><input type="number" name="islr" id="islr" step="0.01" min="0" max="100" required><br>
								<label>Otras Retenciones: </label><input type="number" name="otherRetentions" id="otherRetentions" step="0.01" min="0" required>
								<label>Prontopago: </label><input type="number" name="promptPayment" id="promptPayment" step="0.01" min="0" required>
								<input type="submit" id="printCashBoxText" value="Cuentas Cobradas"></div>
							<div class='cuentasE'>
								<label>Fecha de Envío: </label><input type="text" name="date" id="date" required>
								<input type="submit" value="Cuentas Entregadas"></div>
							<table class="display" id="example2">
								<thead>
									<tr>
										<th>Entregadas</th>
										<th>Cobradas</th>
										<th>No. de Factura</th>
										<th>Fecha Emisión</th>
										<th>Seguro</th>
										<th>Cobertura</th>
										<th>Monto Pendiente</th>
										<th>Fecha Entrega</th>
										<th>Días Vencida</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>		
									<% for (int i = 0; i < pList.size(); i++ ){ 
										PendingAccounts p = pList.get(i);
										Long days = null;
										if(p.getDeliveryDate()!=null){
											SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
											Date deliveryDate = format.parse(p.getDeliveryDate());
											Date today = new Date();
											long difference = today.getTime() - deliveryDate.getTime();
											days = TimeUnit.DAYS.convert(difference, TimeUnit.MILLISECONDS);
										}
										
										String data = p.getBillID().toString()+'_'+p.getHasMultiplePaymentResponsibles()+'_'+p.getMainPaymentResponsible()+'_'+p.getAdmissionID()+'_'+p.getPaymentResposible().getId();
									%>	
									<tr class="gradeA">
										<td>
										<% if(p.getWasDelivered()==0){ %>
											<input type="checkbox" name="sendFact" class='sendF' value="<%= data %>">
										<% } %>
										</td>	
										<td><input type="checkbox" name="selFact" class='selF' value="<%= data %>"></td>										
										<td><%= p.getBillID() %></td>
										<td><%= p.getGenerationDate() %></td>
										<td><%= p.getPaymentResposible().getName() %></td>
										<td><%= (p.getCoverageAmount()==null)?"-":"Bs. " + p.getCoverageAmount() %></td>
										<td>Bs. <%= p.getTotal() %></td>
										<td><%= (p.getDeliveryDate()==null)?"-":p.getDeliveryDate() %></td>
										<td><%= (days==null)?"N/A":days %></td>
										<td>
										<% if(p.getWasDelivered()==0){ %>
											<a id="go" rel="leanModal" href="#deliverBill" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(<%= p.getBillID() %>, '<%= p.getPaymentResposible().getName() %>', <%= p.getAdmissionID() %>, <%= p.getPaymentResposible().getId() %>, <%= p.getHasMultiplePaymentResponsibles() %>, <%= p.getMainPaymentResponsible() %>);" >
											<img alt="logo" src="./images/send.png" height="16" width="16" title="Entregada"/>
											</a>
										<% } %>
											<a id="go" rel="leanModal" href="#payAccount" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(<%= p.getBillID() %>, '<%= p.getPaymentResposible().getName() %>', <%= p.getAdmissionID() %>, <%= p.getPaymentResposible().getId() %>, <%= p.getHasMultiplePaymentResponsibles() %>,<%= p.getMainPaymentResponsible() %>);" >
											<img alt="logo" src="./images/movements.png" height="16" width="16" title="Abonar"/>
											</a>
											<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(<%= p.getBillID() %>, '<%= p.getPaymentResposible().getName() %>', <%= p.getAdmissionID() %>, <%= p.getPaymentResposible().getId() %>, <%= p.getHasMultiplePaymentResponsibles() %>,<%= p.getMainPaymentResponsible() %>);" >
											<img alt="logo" src="./images/check.png" height="16" width="16" title="Cobrada"/>
											</a>
											<a href="ShowCashServlet?billID=<%= p.getBillID() %> " style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a>
											<br>
										</td>
									</tr>
									<% } %>
								</tbody>
							</table>
							</form>
							<br><br>
							<div class="total"><h3>Total Cuentas por Cobrar: Bs. <%= Estimation.format.format(total) %></h3></div>
  			</div>
		</div>
		<div id="deliverBill">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Factura Enviada</h3>
				<br><br>
				<span>¿Está seguro que la factura #<span class="fId"></span> fue enviada a <b><span class="name"></span></b>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="DeliverBillServlet" method="post" onsubmit="return setV(this)" >
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<input type="hidden" id="admissionId" class="good_input admissionId" name="admissionId" value=""/>
					<input type="hidden" id="paymentResponsibleId" class="good_input paymentResponsibleId" name="paymentResponsibleId" value=""/>
					<input type="hidden" id="hasMultiple" class="good_input hasMultiple" name="hasMultiple" value=""/>
					<input type="hidden" id="mainResponsible" class="good_input mainResponsible" name="mainResponsible" value=""/>
					<label>Fecha de Envío: </label><input type="text" name="date" id="date" required/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="closeAccount" style="width: 370px; height: 290px; background: white; padding: 40px 0 10px;">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" style="background: #63b8ee; line-height: 63px;">Pago Cobrado</h3>
				<br><br>
				<span>¿Está seguro que el pago #<span class="fId"></span> del seguro <b><span class="name"></span></b> fue cobrado? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="PayPendingAccountServlet" method="post" onsubmit="return setV(this)" style="padding: 0 20px;">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<input type="hidden" id="admissionId" class="good_input admissionId" name="admissionId" value=""/>
					<input type="hidden" id="paymentResponsibleId" class="good_input paymentResponsibleId" name="paymentResponsibleId" value=""/>
					<input type="hidden" id="hasMultiple" class="good_input hasMultiple" name="hasMultiple" value=""/>
					<input type="hidden" id="mainResponsible" class="good_input mainResponsible" name="mainResponsible" value=""/>
					<label>N&uacute;mero de Documento: </label><input type="text" name="documentnumber" id="documentnumber" size="10"><br>
					<label>Banco: </label><input type="text" name="bank" id="bank" size="25"><br>
					<label>% ISLR: </label><input type="number" name="islr" id="islr" step="0.01" min="0" max="100" required><br>
					<label>Otras Retenciones: </label><input type="number" name="otherRetentions" id="otherRetentions" step="0.01" min="0" required><br>
					<label>Prontopago: </label><input type="number" name="promptPayment" id="promptPayment" step="0.01" min="0" required>
					<div class="btn-fld">
						<input type="submit" class="buttonPopUpDelete5"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="payAccount" style="width: 370px; height: 290px; background: white; padding: 40px 0 10px;">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" style="background: #63b8ee; line-height: 63px;">Abonar a Cuenta</h3>
				<br><br>
				<span>¿Está seguro que desea realizar un abono al pago #<span class="fId"></span> del seguro <b><span class="name"></span></b>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="PayPendingAccountServlet" method="post" onsubmit="return setV(this)" style="padding: 0 20px;">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<input type="hidden" id="admissionId" class="good_input admissionId" name="admissionId" value=""/>
					<input type="hidden" id="paymentResponsibleId" class="good_input paymentResponsibleId" name="paymentResponsibleId" value=""/>
					<input type="hidden" id="hasMultiple" class="good_input hasMultiple" name="hasMultiple" value=""/>
					<input type="hidden" id="mainResponsible" class="good_input mainResponsible" name="mainResponsible" value=""/>
					<label>Monto: </label><input type="number" name="amount" id="amount" step="0.01" min="0" required><br>
					<label>N&uacute;mero de Documento: </label><input type="text" name="documentnumber" id="documentnumber" size="10"><br>
					<label>Banco: </label><input type="text" name="bank" id="bank" size="25"><br>
					<label>% ISLR: </label><input type="number" name="islr" id="islr" step="0.01" min="0" max="100" required><br>
					<label>Otras Retenciones: </label><input type="number" name="otherRetentions" id="otherRetentions" step="0.01" min="0" required><br>
					<label>Prontopago: </label><input type="number" name="promptPayment" id="promptPayment" step="0.01" min="0" required>
					<div class="btn-fld">
						<input type="submit" class="buttonPopUpDelete5"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	<script>
	$('.selF').change(function () {
		var checkedAtLeastOne = false;
		$('input[type="checkbox"]').each(function() {
			if ($(this).is(":checked")) {
				checkedAtLeastOne = true;
			}
			
		});
		if (checkedAtLeastOne == true) {
			$('.cuentasP #islr').prop('required',true);
			$('.cuentasP #otherRetentions').prop('required',true);
			$('.cuentasP #promptPayment').prop('required',true);
			$('.cuentasP').show();
			$('#formFact').prop('action', 'PayPendingAccountsServlet');
			$('.cuentasE').hide(); 
			$('.sendF').prop('checked', false);
			$('.cuentasE #date').prop('requiered', false);
		} else {
			$('.cuentasP').hide();
		}
	});
	
	$('.sendF').change(function () {
		var checkedAtLeastOne = false;
		$('input[type="checkbox"]').each(function() {
			if ($(this).is(":checked")) {
				checkedAtLeastOne = true;
			}
			
		});
		if (checkedAtLeastOne == true) {
			$('.cuentasE #date').prop('requiered', true);
			$('.cuentasE').show();
			$('#formFact').prop('action', 'DeliverBillsServlet');
			$('.cuentasP').hide();
			$('.cuentasP #islr').prop('required',false);
			$('.cuentasP #otherRetentions').prop('required',false);
			$('.cuentasP #promptPayment').prop('required',false);
			$('.selF').prop('checked', false);
		} else {
			$('.cuentasE').hide();
		}
	});
	
	</script>
	</body>
</html>