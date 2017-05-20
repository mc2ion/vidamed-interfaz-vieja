<%@page import="domain.PaymentResponsibleCollectionHeader"%>
<%@page import="domain.PaymentResponsibleCollection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<% 
DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
DateFormat hourFormat = new SimpleDateFormat("hh:mm:ss a");
Date date = new Date();
String dateTxt = dateFormat.format(date);
String hour    = hourFormat.format(date);
PaymentResponsibleCollectionHeader header = (PaymentResponsibleCollectionHeader)request.getAttribute("header");
ArrayList<PaymentResponsibleCollection> payments = (ArrayList<PaymentResponsibleCollection>) request.getAttribute("payments");
ArrayList<PaymentResponsibleCollection> subtotals = (ArrayList<PaymentResponsibleCollection>) request.getAttribute("subtotals");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Relaci&oacute;n de Cobranzas a Empresa</title>
		<script type="text/javascript">
		
		function printPageContentB() {
			div = document.getElementById('botonera');
			div.style.display = "none";
			window.print();
		}
		
		function unPrintPageContentB() {
			div = document.getElementById('botonera');
			div.style.display = "block";
		}
		
		</script>
		<style type="text/css">
		
		html, body {
			height: 100%;
		}
		
		#especial{
			margin-left: 8%;
			margin-right: 8%;
			text-align: left;
			font-family: Arial, Helvetica, sans-serif;
			color: #061C37;
			background: #fff;
		}
		input{
			border: none;
		}
		
		label, span {
			font-weight: bold;
		}
		
		.header {
			width: 100%;
			font-size: 10px;
		}
		
		.header div {
			display: inline;
		}
		
		.date div {
			text-align: right;
			width: 50%;
		}
		
		hr { 
		  background-color: black; 
		  height: 1px;
		}
		
		#sweetTable, #invisibleTable {
			width: 100%;
			border-collapse: collapse;
		}
		
		#sweetTable th, #totalTr2 td {
			text-align: left;
			padding-top: 5px;
			padding-bottom: 4px;
			background-color: #006c92;
			color: #fff;
			font-weight: bold;
		}
		
		#invisibleTable th {
			text-align: left;
			padding-top: 5px;
			padding-bottom: 4px;
			background-color: white;
			color: black;
			font-weight: bold;
		}
		
		#totalTr td {
			background-color: #1EB1DD;	
			font-weight: bold;
		}	
		
		#totalTr3 td {
			background-color:#A5E0F1;	
			font-weight: bold;
		}	
		
		#sweetTable td, #sweetTable th {
			border: 1px solid #006c92;
			padding: 1px 7px 1px 7px;
			font-size: 10px;
			vertical-align: top;
		}
		
		#invisibleTable td, #invisibleTable th {
			border: none;
			padding: 1px 7px 1px 7px;
			font-size: 10px;
		}
		*
		{
		  margin: 0 auto 0 auto;
		 text-align:left;
		 
		 }
		 ul.a {list-style-type:circle;
		 font-size:6px;}
		 
		 .wrapper {
			min-height: calc(100% - 6em);
			margin: 0 auto -10em;
			padding-top: 6em;
		}
		.footer, .push {
			height: 10em;
		}
		
		.subtitle {
			font-weight: bold;
			text-decoration: underline;
		}
		
		.subtotal {
			background-color: #5eb1e9;
		}
		
		.subtotal td:first-of-type {
			text-align: right;		
		}
		</style>
		<script > 
		<!-- 
		
		function inhabilitar(){ 
		   	return true;
		} 
		
		document.oncontextmenu=inhabilitar;
		
		// --> 
		</script>
	</head>
	<body id="especial">
		<div class="wrapper">
		<div id="printHeader" class="header">
			<div style="width:100%;text-align:right;float:left;"><b>Fecha: </b> <%= dateTxt %></div>       	
        </div><br>
		<div style="text-align:right;width:100%;font-size:11px;"><b>Hora: </b><%= hour %></div> <br>
		<% String fact = "RELACION DE COBRANZAS A EMPRESA"; %>
		
		<div id="title" style="font-size:14px; font-weight: bold;text-align:center;"> <%= fact %> </div>
		<hr />
		<% 
			String headerTxt = "Documento de Pago Nro " + header.getDocumentNumber() + " del " + header.getBank() + " de fecha " + header.getPaymentDate();
		%>
		<div class="header" style="width:50%;text-align:left;float:left;">
			<%= headerTxt %>   	
        </div>
        <div class="header" style="width:50%;text-align:right;float:right;">
			<%= header.getPaymentDate() %>   	
        </div><br>
		<div class="header" style="width:33%;display:inline-block;text-align:left;">
			<b>Monto Cheque </b> Bs <%= header.getDif() %>     	
        </div>
        <div class="header" style="width:33%;display:inline-block;text-align:left;">
			<b>Total Retenciones </b> Bs <%= header.getRetention() %>     	
        </div>
        <div class="header" style="width:33%;display:inline-block;text-align:left;">
			<b>Total Emisi&oacute;n de Pago </b> Bs <%= header.getCoverageAmount() %>     	
        </div><br>
        <div class="header">
			NRO DE RECIBO:   	
        </div><br>
        <table id="sweetTable">
			<tbody>
				<tr>
					<th style="width:40%">Nro Factura</th>
					<th style="width:10%">Monto a Cobrar</th>
					<th style="width:10%">Monto Abonado</th>
					<th style="width:10%">Retenciones ISLR</th>
					<th style="width:10%">Otras Retenciones</th>
					<th style="width:10%">Monto Pronto Pago</th>
					<th style="width:10%">Reintegro</th>
				</tr>
				<tr>
					<td colspan="7">Responsable del Pago: <%= header.getPaymentResponsibleName().toUpperCase() %></td>
				</tr>				
				<% 
				Integer reasonID = null;
				Integer index = 0;
				PaymentResponsibleCollection p = null, s = null;
				String reasonName = payments.get(0).getReasonName();
				
				for (int i = 0 ; i < payments.size(); i++){ 
					p = payments.get(i);
					s = subtotals.get(index);
					
					if(reasonID != null && reasonID != p.getReasonID()){
				%>
				<tr class="subtotal">
					<td>SUB-TOTALES <%= reasonName.toUpperCase() %></td>
					<td><%= s.getCoverageAmount() %></td>
					<td><%= s.getCoverageAmount() %></td>
					<td><%= s.getRetention() %></td>
					<td><%= s.getOtherRetention() %></td>
					<td><%= s.getPromptPaymentAmount() %></td>
					<td><%= s.getRefund() %></td>
				</tr>
				<%
						index++;
					}
					
					if(reasonID != p.getReasonID()){
						reasonID = p.getReasonID();
				%>
				<tr>
					<td colspan="7" class="subtitle"><%= p.getReasonName().toUpperCase() %></td>
				</tr>
				<%
					}
				%>
					<tr>
						<td><%= p.getBillID() %></td>
						<td><%= p.getCoverageAmount() %></td>
						<td><%= p.getCoverageAmount() %></td>
						<td><%= p.getRetention() %></td>
						<td><%= p.getOtherRetention() %></td>
						<td><%= p.getPromptPaymentAmount() %></td>
						<td><%= p.getRefund() %></td>
					</tr>
				<% 
					reasonName = p.getReasonName();
				} 
				s = subtotals.get(index);
				%>	
					<tr class="subtotal">
						<td>SUB-TOTALES <%= p.getReasonName().toUpperCase() %></td>
						<td><%= s.getCoverageAmount() %></td>
						<td><%= s.getCoverageAmount() %></td>
						<td><%= s.getRetention() %></td>
						<td><%= s.getOtherRetention() %></td>
						<td><%= s.getPromptPaymentAmount() %></td>
						<td><%= s.getRefund() %></td>
					</tr>			
			</tbody>
		</table>
		<br>	
		<div id="botonera">
			<form onsubmit="printPageContentB();">
				<div id="botonP" style="display:inline-block;">
					<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" style="margin-left:30%;" onclick="printPageContentB();unPrintPageContentB();return false" />
				</div>	
				<div id="botonV" style="display:inline-block;">
					<a class="button" href="./ListAccountsServlet" style="margin-left:40%;">Regresar</a>		
				</div>	
			</form>
		</div>
		<div class="push"></div>
        </div>			
	</body>
</html>