<%@page import="java.text.DecimalFormat"%>
<%@page import="domain.Estimation"%>
<%@page import="domain.Protocol"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%
@SuppressWarnings("unchecked")
Estimation e = (Estimation) request.getAttribute("est");

String est = (String) request.getAttribute("estimationID");

DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
DateFormat hourFormat = new SimpleDateFormat("hh:mm:ss a");
Date date = new Date();
String dateTxt = dateFormat.format(date);
String hour    = hourFormat.format(date);
			
@SuppressWarnings("unchecked")
ArrayList<Protocol> lList = (ArrayList<Protocol>) request.getAttribute("estList");
		
@SuppressWarnings("unchecked")
ArrayList<Protocol> pList = (ArrayList<Protocol>) request.getAttribute("plist");

%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Imprimir Presupuesto</title>	
		<script type="text/javascript">
		
		function printPageContentB() {
			div = document.getElementById('botonera');
			div.style.display = "none";
			div2 = document.getElementById('footList');
			div2.style.display = "block";
			window.print();
		}
		
		function unPrintPageContentB() {
			div = document.getElementById('botonera');
			div.style.display = "block";
			div2 = document.getElementById('footList');
			div2.style.display = "none";
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
			font-size: 11px;
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
			<div style="float:left;width:100%;text-align:right;"><b>Fecha: </b> <%= dateTxt %></div>       	
        </div><br>
		<div style="text-align:right;width:100%;font-size:11px;"><b>Hora: </b><%= hour %></div> <br>
		<div id="title" style="font-size:14px; font-weight: bold;text-align:center;"> PRESUPUESTO # <%= Estimation.leftPadStringWithChar(est, 9, '0') %> </div>
		<br />
		<div class="header">
			<% 
				String name 	= e.getFirstName() + " " + e.getLastName();
				String cedula 	= e.getIdentityCard();
			%>
			<div><b>Nombre del Paciente: </b> <%= e.getFirstName() + " " + e.getLastName() %></div><br/>
			<div><b>Cédula de Identidad: </b> <%= e.getIdentityCard() %></div>       	
        </div><br>
		<div class="header">
			<% 
				if (e.getPolicyHolderName() != null ) { 
					name   =  e.getPolicyHolderName();
					cedula =  e.getPolicyHolderID();
				}
			%>
			<div><b>Asegurado Principal:</b> <%= name %></div><br/>
			<div><b>Cédula de Asegurado:</b> <%= cedula %></div>   
	    </div><br>
		<div class="header">
			<b>Médico Tratante: </b><%= e.getSpecialistName() %>    	
        </div>
		<div class="header">
			<b>Responsable de Pago: </b><%= e.getResponsibleName() %>     	
        </div><br>
        <table id="sweetTable">
			<tbody>
				<tr>
					<th style="width:8%">Número</th>
					<th style="width:15%">Diagnóstico</th>
					<th style="width:77%">Protocolo</th>
				</tr>	
				<% for (int i = 0; i < pList.size(); i++ ){	
					Protocol p = pList.get(i);
				%>			
				<tr>
					<td><%= p.getProtocolID() %></td>
					<td><%= p.getDiagnosis() %></td>
					<td>
					<table id="invisibleTable">
						<tbody>
						<tr>
							<th colspan="2"><%= p.getName() %></th>
							<th style="width:20%;text-align:right;">Precio Bs.S.</th>
						</tr>
						<% for (int j = 0; j < lList.size(); j++){
							if (p.getProtocolID().equals(lList.get(j).getProtocolID())){
							%>
						<tr>
							<td colspan="2"><%= lList.get(j).getBussinessRuleMicroName() %></td>
							<% 
							  /*double amount = Double.parseDouble(lList.get(j).getCost());
							  DecimalFormat formatter = new DecimalFormat("#,###.##");
							  String number = formatter.format(amount) ;*/
							%> 
							<td style="width:20%;text-align:right;"><%= lList.get(j).getCost() %></td>
						</tr>
						<% } 
						} %>
						<tr id="totalTr3">
							<td colspan="2">*** TOTAL PROTOCOLO ***</td>
							<% 
							  /*double amount = Double.parseDouble(pList.get(i).getTotalWithPercentage());
							  DecimalFormat formatter = new DecimalFormat("#,###.##");
							  String number = formatter.format(amount) ;*/
							%> 
							<td style="width:20%;text-align:right;"><%=  pList.get(i).getTotalWithPercentage() %></td>
						</tr>
				</tbody>
			</table>
					</td>
				</tr>					
				<% } %>
				<tr id="totalTr2">
					<td colspan="2">*** SUB-TOTAL ***</td>
					<% 
						  /*double amount = Double.parseDouble(e.getTotal());
						  DecimalFormat formatter = new DecimalFormat("#,###.##");
						  String number = formatter.format(amount) ;*/
					%> 
					<td style="width:20%;text-align:right;"><%= e.getTotal() %></td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">I.V.A.</td>
					<td style="width:20%;text-align:right;">0,00</td>
				</tr>
				<% 
					String total = e.getTotal();	
					String totalDollar = e.getTotalDollar();
					if (e.getTotalWithDiscount() != null) { 
						double a = Estimation.format.parse(e.getTotal()).doubleValue();
						double b = Estimation.format.parse(e.getTotalWithDiscount()).doubleValue();
						double disc  = a - b;
						String discF = Estimation.format.format(disc);
						total = e.getTotalWithDiscount() ;
						totalDollar = e.getTotalWithDiscountDollar();
				%>
				<tr id="totalTr2">
					<td colspan="2">*** DESCUENTO ***</td>
					<td style="width:20%;text-align:right;"><%= discF %></td>
				</tr>
				<% } %>
				<tr id="totalTr">
					<td colspan="2">*** TOTAL GENERAL ***</td>
					<td style="width:20%;text-align:right;"><%= total %></td>
				</tr>
				<tr id="totalTr">
					<td colspan="2" style="background-color: #A5E0F1;">*** TOTAL GENERAL EN D&Oacute;LARES ***</td>
					<td style="width:20%;text-align:right;background-color: #A5E0F1;"><%= totalDollar %></td>
				</tr>
			</tbody>
		</table>		
		<br>		
		<br>		
		<br>
		<div style="text-align:center;font-weight:bold;font-size:11px;">CENTRO MÉDICO QUIRÚRGICO VIDAMED		
		<br>Departamento Administrativo</div>		
		<br>
		<div style="text-align:left;font-size:10px;"><b>Elaborado Por:</b> <%= e.getCreationUser() %></div>
		<% System.out.println("'"+e.getEditionUser()+"'");
		if (e.getEditionUser() != null){ %>
		<div style="text-align:left;font-size:10px;"><b>Modificado Por:</b> <%= e.getEditionUser() %></div>
		<% } %>
		<br>	
		<div id="botonera">
				<form onsubmit="printPageContentB();" style="display:inline-block;">
				<div id="botonP">
							<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" style="margin-left:30%;" onclick="printPageContentB();unPrintPageContentB();return false" />
				</div>	
				</form>
				<form style="display:inline-block;">
					<div id="botonV">
							<input type="button" class="button" value="Regresar"  onClick="javascript:history.back();" style="margin-left:40%;" />		
					</div>	
				</form>
			</div>
		<div class="push"></div>
        </div>
        <div class="footer" id="footer">
			<ul class="a" style="display:none;" id="footList">
	  			<li>ESTE PRESUPUESTO ES ESTIMADO Y PODRÁ SUFRIR VARIACIONES DE ACUERDO A LA PERMANENCIA Y/O EVOLUCIÓN DEL PACIENTE; Y EN EL MISMO NO ESTÁ INCLUIDO CONTINGENCIAS, NI SERVICIOS ESPECIALES. EL MATERIAL MÉDICO QUIRÚRGICO Y MEDICINAS SERÁN FACTURADOS DE ACUERDO AL CONSUMO.</li>
	  			<li>SI TIENE PÓLIZA DE SEGUROS DEBE DEPOSITAR LA DIFERENCIA ENTRE LA COBERTURA APROBADA Y EL PRESENTE PRESUPUESTO. </li>
	  			<li>ESTE PRESUPUESTO ES VÁLIDO POR 7 DÍAS. DEBE PRESENTAR LOS EXÁMENES PRE-OPERATORIOS AL MOMENTO DE SU INGRESO.</li>
			</ul>		
		</div>			
	</body>
</html>