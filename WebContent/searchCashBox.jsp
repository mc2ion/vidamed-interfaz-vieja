<%@page import="domain.CashBoxReport"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<CashBoxReport> cashBox = (ArrayList<CashBoxReport>) request.getAttribute("cashBox");
	
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Imprimir Cierre de Caja</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
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
	
	function printPageContentB() {
		$('#container').hide();
		$('#printable').show();
		$('body').addClass('bodyAux');
		window.print();
	}
		
	function unPrintPageContentB() {
		$('#container').show();
		$('#printable').hide();
		$('body').removeClass('bodyAux');
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
            	<li class="menuitem"><a href="ListCashBoxesServlet">Ver Cajas</a></li>
           		<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
            </ul>	
	    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Cajas que coinciden con su búsqueda:</h2>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
						 <table id="sweetTable">
								<tbody>	
									<tr>
									<th>Caja</th>
									<th>Fecha</th>
									<th>Cajero</th>
									<th>Responsable Pago</th>
									<th>Tipo</th>
									<th>Forma</th>
									<th>Monto</th>
									<th>Total</th>
								</tr>		
									<% 
										if (cashBox.size() != 0){
											for (int i=0; i< cashBox.size();i++){ 
											CashBoxReport c = cashBox.get(i);
									%>	
										<tr class="gradeA">
											<td><%= c.getName() %></td>
											<td><%= c.getDate() %></td>
											<td><%= c.getCashier().getFirstName() + " " + c.getCashier().getLastName() %></td>
											<td><%= (c.getPaymentResponsible().getName() != null) ? c.getPaymentResponsible().getName() : "-" %></td>
											<td><%= c.getPayment().getPaymentTypeName() %></td>
											<td><%= c.getPayment().getPaymentMethodName() %></td>
											<td>Bs. <%= c.getPayment().getAmount() %></td>
											<td>Bs. <%= c.getTotal() %></td>
										</tr>	
										<% } 
									}else{%>
										<tr class="gradeA"><td colspan="8" style="text-align:center;"> No hay resultados</td></tr>
									<%
										}
									%>		
								</tbody>
						</table>
						</div>
					</div><br>
					<div id="botonera">
						<form onsubmit="printPageContentB();">
							<div id="botonP" style="display: inline; margin-right: 30px;">
										<input type="submit"  class="button"  name="sbmtButton" value="Imprimir"  onclick="printPageContentB();unPrintPageContentB();return false" />
							</div>	
							
							<div id="botonV" style="display: inline;">
										<input type="button" class="button" value="Regresar"  onClick="javascript:history.back();"  />		
							</div>	
						</form>
					</div><br>
				</div>
				<div class="spacer"></div>
        	</div>
       	</div>
		
	<div id="printable" style="display:none">  
		<h2>Cajas que coinciden con su búsqueda:</h2>
		<div id="dt_example">
			<div id="container">
				<div id="demo">
					<table id="sweetTable">
						<tbody>	
							<tr>
								<th>Caja</th>
								<th>Fecha</th>
								<th>Cajero</th>
								<th>Responsable Pago</th>
								<th>Tipo</th>
								<th>Forma</th>
								<th>Monto</th>
								<th>Total</th>
							</tr>		
							<% 
								if (cashBox.size() != 0){
									for (int i=0; i< cashBox.size();i++){ 
									CashBoxReport c = cashBox.get(i);
							%>	
								<tr class="gradeA">
									<td><%= c.getName() %></td>
									<td><%= c.getDate() %></td>
									<td><%= c.getCashier().getFirstName() + " " + c.getCashier().getLastName() %></td>
									<td><%= (c.getPaymentResponsible().getName() != null) ? c.getPaymentResponsible().getName() : "-" %></td>
									<td><%= c.getPayment().getPaymentTypeName() %></td>
									<td><%= c.getPayment().getPaymentMethodName() %></td>
									<td>Bs. <%= c.getPayment().getAmount() %></td>
									<td>Bs. <%= c.getTotal() %></td>
								</tr>	
								<% } 
							}else{%>
								<tr class="gradeA"><td colspan="8" style="text-align:center;"> No hay resultados</td></tr>
							<%
								}
							%>		
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>