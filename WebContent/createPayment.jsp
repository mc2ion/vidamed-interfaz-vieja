<%@page import="domain.CashBoxSalePoint"%>
<%@page import="domain.PaymentResponsible"%>
<%@page import="domain.Bank"%>
<%@page import="domain.PaymentMethod"%>
<%@page import="domain.PaymentTypes"%>
<%@page import="domain.Admission"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
		
	String id = request.getParameter("cashBoxID");
	
	String cedId 	= request.getParameter("cedId");
	String cedNumber = request.getParameter("cedNumber");
	String search   = request.getParameter("search");
	
	@SuppressWarnings("unchecked")
	ArrayList<Admission> cb = (ArrayList<Admission>) request.getAttribute("cb");
	
	@SuppressWarnings("unchecked")
	ArrayList<PaymentTypes> pt = (ArrayList<PaymentTypes>) request.getAttribute("pt");
	
	@SuppressWarnings("unchecked")
	ArrayList<PaymentMethod> pm = (ArrayList<PaymentMethod>) request.getAttribute("pm");
	
	@SuppressWarnings("unchecked")
	ArrayList<Bank> b = (ArrayList<Bank>) request.getAttribute("b");
	
	@SuppressWarnings("unchecked")
	ArrayList<PaymentResponsible> pr = (ArrayList<PaymentResponsible>) request.getAttribute("pr");
	
	@SuppressWarnings("unchecked")
	ArrayList<CashBoxSalePoint> sp = (ArrayList<CashBoxSalePoint>) request.getAttribute("sp");
	
	@SuppressWarnings("unchecked")
	ArrayList<Admission> a = (ArrayList<Admission>) request.getAttribute("cb");
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Registrar Pago</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>	
		<script>
		function findPatient(){
			div1 = document.getElementById('patient');
			div1.style.display = "block";
		}
		
		function displayPaymentFields(combo) {
			sel = combo.options[combo.selectedIndex].value;
			bank = document.getElementById('bank');
			bankTo = document.getElementById('bankTo');
			bankLabel = document.getElementById('bankLabel');
			bankFromLabel = document.getElementById('bankFromLabel');
			transference = document.getElementById('transference');
			check = document.getElementById('check');
			sellPoint = document.getElementById('sellPoint');
			insurance = document.getElementById('insurance');
			pass = document.getElementById('aval');
			if(sel == 2 || sel == 0){
				bank.style.display = "none";
				bankTo.style.display = "none";
				bankLabel.style.display = "none";
				bankFromLabel.style.display = "none";
				check.style.display = "none";
				sellPoint.style.display = "none";
				insurance.style.display = "none";
				pass.style.display = "none";
				transference.style.display = "none";
			} else if(sel == 4 || sel == 5){
				bank.style.display = "block";
				bankTo.style.display = "none";
				bankLabel.style.display = "block";
				bankFromLabel.style.display = "none";
				check.style.display = "none";
				sellPoint.style.display = "block";
				insurance.style.display = "none";
				pass.style.display = "none";
				transference.style.display = "none";
			} else if(sel == 1){
				bank.style.display = "block";
				bankTo.style.display = "none";
				bankLabel.style.display = "block";
				bankFromLabel.style.display = "none";
				check.style.display = "block";
				sellPoint.style.display = "none";
				insurance.style.display = "none";
				pass.style.display = "none";
				transference.style.display = "none";
			} else if(sel == 3){
				bank.style.display = "none";
				bankTo.style.display = "none";
				bankLabel.style.display = "none";
				bankFromLabel.style.display = "none";
				check.style.display = "none";
				sellPoint.style.display = "none";
				insurance.style.display = "block";
				pass.style.display = "none";
				transference.style.display = "none";
			} else if(sel == 6){
				bank.style.display = "none";
				bankTo.style.display = "none";
				bankLabel.style.display = "none";
				bankFromLabel.style.display = "none";
				check.style.display = "none";
				sellPoint.style.display = "none";
				insurance.style.display = "none";
				pass.style.display = "block";
				transference.style.display = "none";
			} else if(sel == 7){
				bank.style.display = "block";
				bankTo.style.display = "block";
				bankLabel.style.display = "none";
				bankFromLabel.style.display = "block";
				check.style.display = "none";
				sellPoint.style.display = "none";
				insurance.style.display = "none";
				pass.style.display = "none";
				transference.style.display = "block";
			}
		}
		</script>
		<script>
			$(function() {    
            	$('#sbmtButton').click(function(event) { 
            		var patternNumber = new RegExp('^\\d+$');
            		var patternDouble = new RegExp('^[0-9]+(\.[0-9]+)?$');
					if ( $('input[name=adId]:checked').length == 0){
						alert("Debe seleccionar una 'Admisión' para poder agregar el pago");
            			return;
					}
            		else if($('#paymentType').val() == '0') {
            			alert("Debe seleccionar un valor para el campo 'Tipo'");
            			return;
            		}
            		else if ($('#paymentMethod').val() == '0') {
            			alert("Debe seleccionar un valor para el campo 'Forma'");
            			return;
            		}
            		else if ($('#paymentMethod').val() == '1') {
            			if ($('#bankId').val() == '0') {
            				alert("Debe seleccionar un valor para el campo 'Banco'");
                			return;
            			}
            			else if ($('#checkId').val() == '') {
            				alert("El campo 'N° de Cheque' no puede ser dejado en blanco");
                			return;
            			}
            			else if (!$('#checkId').val().match(patternNumber)) {
            				alert("El campo 'N° de Cheque' sólo debe contener números, sin letras, ni puntos, ni espacios en blanco");
                			return;
            			}
            			else if ($('#amount').val() == '') {
            				alert("El campo 'Monto' no puede ser dejado en blanco");
                			return;
            			}
            			else if (!$('#amount').val().match(patternDouble)) {
            				alert("El campo 'Monto' debe ser un valor numérico. Ejemplo: 1234.56");
                			return;
            			}
            		}
            		else if ($('#paymentMethod').val() == '2') {
            			if ($('#amount').val() == '') {
            				alert("El campo 'Monto' no puede ser dejado en blanco");
                			return;
            			}
            			else if (!$('#amount').val().match(patternDouble)) {
            				alert("El campo 'Monto' debe ser un valor numérico. Ejemplo: 1234.56");
                			return;
            			}
            		}
            		else if ($('#paymentMethod').val() == '3') {
            			if ($('#insuranceId').val() == '0') {
            				alert("Debe seleccionar un valor para el campo 'Compañía de Seguro'");
                			return;
            			}
            			else if ($('#amount').val() == '') {
            				alert("El campo 'Monto' no puede ser dejado en blanco");
                			return;
            			}
            			else if (!$('#amount').val().match(patternDouble)) {
            				alert("El campo 'Monto' debe ser un valor numérico. Ejemplo: 1234.56");
                			return;
            			}
            		}
            		else if ($('#paymentMethod').val() == '4' || $('#paymentMethod').val() == '5') {
            			if ($('#bankId').val() == '0') {
            				alert("Debe seleccionar un valor para el campo 'Banco'");
                			return;
            			}
            			else if ($('#salesPoint').val() == '0') {
            				alert("Debe seleccionar un valor para el campo 'Punto de Venta'");
                			return;
            			}
            			else if ($('#aprob').val() == '') {
            				alert("El campo 'N° de Aprobación' no puede ser dejado en blanco");
                			return;
            			}
            			else if (!$('#aprob').val().match(patternNumber)) {
            				alert("El campo 'N° de Aprobación' sólo debe contener números, sin letras, ni puntos, ni espacios en blanco");
                			return;
            			}
            			else if ($('#amount').val() == '') {
            				alert("El campo 'Monto' no puede ser dejado en blanco");
                			return;
            			}
            			else if (!$('#amount').val().match(patternDouble)) {
            				alert("El campo 'Monto' debe ser un valor numérico. Ejemplo: 1234.56");
                			return;
            			}
            		}
            		else if ($('#paymentMethod').val() == '6') {
            			if ($('#pass').val() == '') {
            				alert("El campo 'Clave' no puede ser dejado en blanco");
                			return;
            			}
            			else if ($('#amount').val() == '') {
            				alert("El campo 'Monto' no puede ser dejado en blanco");
                			return;
            			}
            			else if (!$('#amount').val().match(patternDouble)) {
            				alert("El campo 'Monto' debe ser un valor numérico. Ejemplo: 1234.56");
                			return;
            			}
            		} else if ($('#paymentMethod').val() == '7') {
            			if ($('#bankId').val() == '0') {
            				alert("Debe seleccionar un valor para el campo 'Banco Emisor'");
                			return;
            			} else if ($('#bankToId').val() == '0') {
            				alert("Debe seleccionar un valor para el campo 'Banco Receptor'");
                			return;
            			} else if ($('#transferenceId').val() == '') {
            				alert("El campo 'N° de Referencia' no puede ser dejado en blanco");
                			return;
            			} else if ($('#amount').val() == '') {
            				alert("El campo 'Monto' no puede ser dejado en blanco");
                			return;
            			} else if (!$('#amount').val().match(patternDouble)) {
            				alert("El campo 'Monto' debe ser un valor numérico. Ejemplo: 1234.56");
                			return;
            			}
            		}
            		$('#form1').submit();
            	});
			});
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
	            	<li class="menuitem"><a href="ListCashBoxesServlet">Ver Cajas</a></li>
            		<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Registrar Pago:</h2>
				<br>
				<% if (search == null){ %>
				<fieldset>
					<form action="CreatePaymentServlet" method="get">
						<input type="hidden" name="cashBoxID" value="<%= id %>"/>
						<label for="name">Cédula Paciente:</label>
						<select id="cedId" name="cedId">
							<option value="V-" >V</option>
							<option value="E-" >E</option>
						</select> &nbsp;<input name="cedNumber" type="text" style="width: 135px;">
						<input type="submit" name="search" value="Buscar" /><br><br>
					</form>
		      </fieldset>
			  <% }else{ %>
					<fieldset>
						<form action="CreatePaymentServlet" method="get">
							<input type="hidden" name="cashBoxID" value="<%= id %>"/>
							<label for="name">Cédula Paciente:</label>
							<select id="cedId" name="cedId">
								<option value="V-" <%= (cedId.equals("V-")) ? "selected" : "" %> >V</option>
								<option value="E-" <%= (cedId.equals("E-")) ? "selected" : "" %> >E</option>
							</select> &nbsp;<input name="cedNumber" type="text" value="<%= cedNumber %>" style="width: 135px;">
							<input type="submit" name="search" value="Buscar" /><br><br>
						</form>
					</fieldset>
					<form name="form1" id="form1" action="CreatePaymentServlet" method="post">
					<input type="hidden" name="cashBoxID" value="<%= id %>"/>
					<%
					if (a.size() > 0 ){
					%>
					<div>
						<h3> Seleccione la admisión correspondiente:</h3><br/>
						<table class="display" id="example">
							<thead>
								<tr>
									<th></th>
									<th>Admisión</th>
									<th>Adulto</th>
									<th>Cédula</th>
									<th>Nombre</th>
									<th>Fecha Admisión</th>
									<th>Total</th>
									<th>Total Pagado</th>
								</tr>
							</thead>
							<tbody>	
								<% 	for (int i = 0; i< a.size(); i++) {
										Admission e = a.get(i);
										String n = e.getFirstName() + " " + e.getLastName();
								%>		
									<tr class="gradeA">
										<td><input type="radio" name="adId" value="<%= e.getAdmissionID()%>" /></td>
										<td><%= e.getAdmissionID() %></td>
										<td><%= (e.getIsAdult() == 1) ? "Si" : "No" %></td>
										<td><%= e.getIdentityCard() %></td>
										<td><%= n %></td>
										<td><%= e.getAdmissionDate() %></td>
										<td><%= e.getTotal() %></td>
										<td><%= e.getTotalPaid() %></td>
									</tr>
								<% } %>
							</tbody>
						</table><br/>
						<fieldset>
							<div id="patient">
								<label for="name">Tipo:</label>
								<select style="width:111px;" name="paymentType" id="paymentType">
									<option value="0">Seleccionar</option>
									<% for (int i=0; i< pt.size(); i++){ 
										PaymentTypes pte = pt.get(i); 
									%>
									<option value="<%=pte.getId() %>"><%= pte.getName() %></option>
									<% } %>
								</select> <br><br>
								<label for="name">Forma:</label>
								<select onchange="displayPaymentFields(this);" name="paymentMethod" id="paymentMethod">
									<option value="0">Seleccionar</option>
									<% for (int i=0; i< pm.size(); i++){ 
										PaymentMethod pme = pm.get(i); 
									%>
									<option value="<%=pme.getId() %>"><%= pme.getName() %></option>
									<% } %>
								</select> <br><br>
								<div id="aval" style="display:none;">
									<label for="name">Clave:</label>
									<input type="text" name="pass" id="pass" style="width: 135px;"><br><br>
								</div>
								<div id="bank" style="display:none;">
									<label for="name" id="bankLabel">Banco:</label>
									<label for="name" style="display:none;" id="bankFromLabel">Banco Emisor:</label>
									<select name="bank" id="bankId">
										<option value="0">Seleccionar</option>
										<% for (int i=0; i< b.size(); i++){ 
											Bank be = b.get(i); 
										%>
										<option value="<%= be.getId() %>"><%= be.getName() %></option>
										<% } %>
									</select> <br><br>
								</div>
								<div id="bankTo" style="display:none;">
									<label for="name">Banco Receptor:</label>
									<select name="bankTo" id="bankToId">
										<option value="0">Seleccionar</option>
										<% for (int i=0; i< b.size(); i++){ 
											Bank be = b.get(i); 
										%>
										<option value="<%= be.getId() %>"><%= be.getName() %></option>
										<% } %>
									</select> <br><br>
								</div>
								<div id="transference" style="display:none;">
									<label for="name">N° de Referencia:</label>
									<input type="text" name="transference" id="transferenceId" style="width: 135px;"> <br><br>
								</div>
								<div id="check" style="display:none;">
									<label for="name">N° de Cheque:</label>
									<input type="text" name="check" id="checkId" style="width: 135px;"> <br><br>
								</div>
								<div id="sellPoint" style="display:none;">
									<label for="name">Punto de Venta:</label>
									<select name="salesPoint" id="salesPoint">
										<option value="0" >Seleccionar</option>
										<% for (int i=0; i< sp.size(); i++){ 
											CashBoxSalePoint spe = sp.get(i); 
										%>
										<option value="<%= spe.getCashBoxID() %>"><%= spe.getName() %></option>
										<% } %>
									</select> <br><br>
									<label for="name">N° de Aprobación:</label>
									<input type="text" name="aprob" id="aprob" style="width: 135px;"> <br><br>
								</div>
								<div id="insurance" style="display:none;">
									<label for="name">Compañía de Seguro:</label>
									<select name="insurance" id="insuranceId">
										<option value="0">Seleccionar</option>
										<% for (int i=0; i< pr.size(); i++){ 
											PaymentResponsible pre = pr.get(i); 
										%>
										<option value="<%= pre.getId() %>"><%= pre.getName() %></option>
										<% } %>
									</select> <br><br>
								</div>
								<label for="name">Monto:</label>
								<input type="text" name="amount" id="amount" style="width: 135px;"> <br><br>
							</div>
						</fieldset>
					</div>
					<div id="botonera">
							<div id="botonP" style="display: inline; margin-right: 30px;">
										<input type="button" class="button" id="sbmtButton" name="sbmtButton" value="Agregar" />
							</div>	
							<div id="botonV" style="display: inline;">
								<a href="./ListCashBoxesServlet" class="button" > Regresar </a>
							</div>	
					</div><br>
					<%}else{ %>
						<br/><h3> No hay admisiones que coincidan con la cédula introducida </h3><br/><br/><br/>
						<div id="botonera">
							<div id="botonV" style="display: inline;">
								<a href="./ListCashBoxesServlet" class="button" > Regresar </a>
							</div>	
						</div><br>
					<% } %>
					</form>
			  <% } %>
			</div>
		</div>
	</body>
</html>