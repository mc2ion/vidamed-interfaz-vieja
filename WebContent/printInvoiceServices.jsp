<%@page import="domain.Cost"%>
<%@page import="domain.Admission"%>
<%@page import="domain.BussinessMicro"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="domain.Protocol"%>
<%@page import="domain.Service"%>
<%@page import="domain.Estimation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.Estimation"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%

String est 	= (String) request.getAttribute("factId");
String f 	= (String) request.getAttribute("f");
Admission e = (Admission)request.getAttribute("admission");

@SuppressWarnings("unchecked")
ArrayList<Protocol> protocols = (ArrayList<Protocol>) request.getAttribute("protocols");

@SuppressWarnings("unchecked")
ArrayList<Service> costs = (ArrayList<Service>) request.getAttribute("costs");

DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
DateFormat hourFormat = new SimpleDateFormat("hh:mm:ss a");
Date date = new Date();
String dateTxt = dateFormat.format(date);
String hour    = hourFormat.format(date);

String dateE = e.getAdmissionDate();
String dateS = e.getDischargeDate();
String[] split = null;
String de = "";
if (dateE != ""){
	split = dateE.split(" ");
	de 	= split[0];
}
@SuppressWarnings("unchecked")
ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) request.getAttribute("bm");

%>

<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<% if (f.equals("cn")){ %>
		<title>Imprimir Prefactura</title>
		<% } else { %>	
		<title>Imprimir Factura</title>
		<% } %>	
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
			background-image:url(null);
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
			min-height: 100%;
			height: auto !important;
			height: 100%;
			margin: 0 auto -4em;
		}
		.footer, .push {
			height: 4em;
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
		<% String fact = "FACTURA"; if (f.equals("cn")) fact = "PREFACTURA"; %>
		
		<div id="title" style="font-size:14px; font-weight: bold;text-align:center;"> <%= fact %> <%= Estimation.leftPadStringWithChar(est, 9, '0') %> </div>
		<hr />
		<div class="header">
		<% 
			String name 	= e.getFirstName() + " " + e.getLastName();
			String cedula 	= e.getIdentityCard();
			String policyIdentity = e.getEstimation().getPolicyHolderIdentityCard();
			String policyName = e.getEstimation().getPolicyHolderName();
		%>
			<div><b>Nombre del Paciente: </b> <%= name %></div><br/>
			<div><b>Cédula de Identidad: </b> <%= cedula %></div><br/>
		<% if(policyName != null) {%>
			<div><b>Asegurado Principal: </b> <%= policyName %></div><br/>
		<% } 
		   if(policyIdentity != null) {
		%>
			<div><b>Cédula de Asegurado: </b> <%= policyIdentity %></div><br/>
		<% } %>
			<div><b>Fecha Entrada: </b> <%= dateE %></div><br/>
			<div><b>Fecha Salida: </b> <%= dateS %></div>
		</div><br>
		<div class="header">
			<b>Médico Tratante: </b><%= e.getSpecialist().getFirstName() +  " " + e.getSpecialist().getLastName() %>    	
        </div><br>
		<div class="header">
			<b>Responsable de Pago: </b><%= e.getResponsibleName() %>     	
        </div>
        <div class="header">
			<b>Direcci&oacute;n: </b><%= e.getResponsibleAddress() %>     	
        </div>
        <div class="header">
			<b>RIF: </b><%= e.getResponsibleRIF() %>     	
        </div><br>
        <%
        if(e.getKeyNumber()!=null && !e.getKeyNumber().equalsIgnoreCase("")){
        %>
        <div class="header">
			<b>N° Clave: </b><%= e.getKeyNumber() %>     	
        </div>
        <%
        }
        if(e.getCoverageAmount()!=null && !e.getCoverageAmount().equals(0.0)){
        %>
        <div class="header">
			<b>Monto de la Cobertura: </b><%= e.getCoverageAmount() %>     	
        </div>
        <%
        }
        if(e.getGuaranteeLetter()!=null && !e.getGuaranteeLetter().equalsIgnoreCase("")){
        %>        
		<div class="header">
			<b>N° Carta Aval: </b><%= e.getGuaranteeLetter() %>     	
        </div><br>
        <%
        }
        %>
        <table id="sweetTable">
			<tbody>
				<tr>
					<th style="width:10%">Número</th>
					<th style="width:45%">Diagnóstico</th>
					<th style="width:45%">Protocolo</th>
				</tr>				
				<% for (int i = 0 ; i < protocols.size(); i++){ 
					Protocol p = protocols.get(i);
				%>
					<tr>
						<td><%= p.getProtocolID() %></td>
						<td><%= p.getDiagnosis() %></td>
						<td><%= p.getName() %></td>
					</tr>
				<% } %>				
			</tbody>
		</table>
		<br>
		<table id="sweetTable">
			<tbody>
			<% 
			long serviceType = 0L;
			double subtotal = 0.00;
			double total = 0.00;

			for (int j = 0; j < costs.size(); j++){
				Service ct = costs.get(j);
				if(ct.getServiceTypeID() == serviceType){
					double d = Double.valueOf(ct.getPrice());
					subtotal = subtotal + d;
				} else {
					if(serviceType != 0L){
			%>
			<tr id="totalTr" style="border: 1px solid #1EB1DD;">
				<td colspan="3" style="text-align:right;">*** SUB-TOTAL ***</td>
				<td style="width:20%;text-align:right;"><%= Estimation.format.format(subtotal) %></td>
			</tr>
			<%		
					}
			%>
			<tr>
				<th><%= ct.getServiceTypeName() %></th>
				<th style="width:20%;text-align:right;">Cantidad</th>
				<th style="width:20%;text-align:right;">Precio Uni.</th>
				<th style="width:20%;text-align:right;">Precio Bs.F.</th>
			</tr>
			<% 
					total = total + subtotal;
					subtotal = Double.valueOf(ct.getPrice());
					serviceType = ct.getServiceTypeID();
				} 
			%>
			<tr>
				<td style="width:50%"><%= ct.getName() %></td>
				<td style="width:20%;text-align:right;"><%= ct.getAmout() %></td>
				<td style="width:20%;text-align:right;"><%= Estimation.format.format(Double.valueOf(ct.getUnitPrice())) %></td>
				<td style="width:20%;text-align:right;"><%= Estimation.format.format(Double.valueOf(ct.getPrice())) %></td>
			</tr>		
			<%
			}
			total = total + subtotal;
			%>
			<tr id="totalTr" style="border: 1px solid #1EB1DD;">
				<td colspan="3" style="text-align:right;">*** SUB-TOTAL ***</td>
				<td style="width:20%;text-align:right;"><%= Estimation.format.format(subtotal) %></td>
			</tr>
			<tr id="totalTr2">
				<td colspan="3" style="text-align:right;">*** TOTAL SERVICIOS AUXILIARES ***</td>
				<td style="width:20%;text-align:right;"><%= Estimation.format.format(total) %></td>
			</tr>
			</tbody>
			</table>				
		<br>
		<div style="text-align:center;font-weight:bold;font-size:11px;">CENTRO MÉDICO QUIRÚRGICO VIDAMED		
		<br>Departamento Administrativo</div>
		<br>	
		<div id="botonera">
				<form onsubmit="printPageContentB();">
				<div id="botonP" style="display:inline-block;">
							<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" style="margin-left:30%;" onclick="printPageContentB();unPrintPageContentB();return false" />
				</div>	
				<div id="botonV" style="display:inline-block;">
							<input type="button" class="button" value="Regresar"  onClick="javascript:history.back();" style="margin-left:40%;" />		
				</div>	
				</form>
			</div>
		<div class="push"></div>
        </div>			
	</body>
</html>