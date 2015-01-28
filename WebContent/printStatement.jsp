<%@page import="domain.Cost"%>
<%@page import="domain.Admission"%>
<%@page import="domain.BussinessMicro"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="domain.Protocol"%>
<%@page import="domain.Estimation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.Estimation"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%

String est = (String) request.getAttribute("estimationID");
Admission e = (Admission)request.getAttribute("admission");

@SuppressWarnings("unchecked")
ArrayList<Protocol> protocols = (ArrayList<Protocol>) request.getAttribute("protocols");

@SuppressWarnings("unchecked")
ArrayList<Protocol> costs = (ArrayList<Protocol>) request.getAttribute("costs");

DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
DateFormat hourFormat = new SimpleDateFormat("hh:mm:ss a");
Date date = new Date();
String dateTxt = dateFormat.format(date);
String hour    = hourFormat.format(date);

String dateE = e.getAdmissionDate()		;
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
		<title>Imprimir Corte Cuenta</title>	
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
			<div style="width:50%;float:left;">HOSPITALIZACI�N VIDAMED</div>
			<div style="width:50%;float:left;text-align:right;"><b>Fecha: </b> <%= dateTxt %></div>       	
        </div><br>
		<div style="text-align:right;width:100%;font-size:11px;"><b>Hora: </b><%= hour %></div> <br>
		<div id="title" style="font-size:14px; font-weight: bold;text-align:center;"> CORTE DE CUENTA </div>
		<hr />
		<div class="header">
		<% 
			String name 	= e.getFirstName() + " " + e.getLastName();
			String cedula 	= e.getIdentityCard();
		%>
			<div><b>Nombre del Paciente: </b> <%= name %></div><br/>
			<div><b>C�dula de Identidad: </b> <%= cedula %></div>
		</div><br>
		<div class="header">
			<b>M�dico Tratante: </b><%= e.getSpecialist().getFirstName() +  " " + e.getSpecialist().getLastName() %>    	
        </div>
		<div class="header">
			<b>Responsable de Pago: </b><%= e.getResponsibleName() %>     	
        </div><br>
        <div class="header">
			Estado de cuenta desde el <%= de %> hasta <%= dateTxt %>     	
        </div><br>
        
        <table id="sweetTable">
			<tbody>
				<tr>
					<th style="width:10%">N�mero</th>
					<th style="width:45%">Diagn�stico</th>
					<th style="width:45%">Protocolo</th>
				</tr>				
				<% for (int i = 0 ; i < protocols.size(); i++){ 
					Protocol p = protocols.get(i);
				%>
					<tr>
						<td><%= p.getProtocolID() %></td>
						<td><%= p.getDiagnosis() %></td>
						<td><%= p.getName() %></td>
				<% } %>
				
			</tbody>
		</table>
		<br>
		<table id="sweetTable">
			<tbody>
			<% 
			long micro = 1;
			double subtotal = 0.00;
			%>
			<tr>
				<th ><%= costs.get(0).getBussinessRuleMicroName() %></th>
				<th style="width:20%;text-align:right;">Precio Bs.F.</th>
			</tr>
			<%
			for (int j = 0; j < costs.size(); j++){
				Protocol ct = costs.get(j);
				if(ct.getEstimationCost() != null){
					if(micro == ct.getBussinessRuleMicroID()){
						double d = Estimation.format.parse(ct.getEstimationCost()).doubleValue();
						subtotal = subtotal + d;
						%>
						<tr>
							<td style="width:50%"><%= ct.getProtocolScaleName() %></td>
							<td style="width:20%;text-align:right;"><%= ct.getEstimationCost() %></td>
						</tr>		
					<%
					} else {
						%>
						<tr id="totalTr">
							<td>*** SUB-TOTAL ***</td>
							<td style="width:20%;text-align:right;"><%= Estimation.format.format(subtotal) %></td>
						</tr>
						<tr>
							<th ><%= ct.getBussinessRuleMicroName() %></th>
							<th style="width:20%;text-align:right;">Precio Bs.F.</th>
						</tr>
						<tr>
							<td style="width:50%"><%= ct.getProtocolScaleName() %></td>
							<td style="width:20%;text-align:right;"><%= ct.getEstimationCost() %></td>
						</tr>
					<%
						subtotal = Estimation.format.parse(ct.getEstimationCost()).doubleValue();
						micro = ct.getBussinessRuleMicroID();
					}
				}
			}
			%>
				<tr id="totalTr">
					<td>*** SUB-TOTAL ***</td>
					<td style="width:20%;text-align:right;"><%= Estimation.format.format(subtotal) %></td>
				</tr>
				<%
					double d = (e.getEstimation().getTotalWithDiscount()==null) ? 0 : Estimation.format.parse(e.getEstimation().getTotal()).doubleValue() - 
							Estimation.format.parse(e.getEstimation().getTotalWithDiscount()).doubleValue();
					double t = (d == 0) ? Estimation.format.parse(e.getTotal()).doubleValue() : Estimation.format.parse(e.getTotal()).doubleValue() + d;
					double r = Estimation.format.parse(e.getTotal()).doubleValue() - Estimation.format.parse(e.getTotalPaid()).doubleValue();
				%>
				<tr id="totalTr2">
					<td>*** TOTAL ***</td>
					<td style="width:20%;text-align:right;"><%= Estimation.format.format(t) %></td>
				</tr>
				<tr id="totalTr">
					<td>*** DESCUENTO ***</td>
					<td style="width:20%;text-align:right;"><%= Estimation.format.format(d) %></td>
				</tr>
				<tr id="totalTr2">
					<td>I.V.A.</td>
					<td style="width:20%;text-align:right;">0,00</td>
				</tr>
				<tr id="totalTr">
					<td>*** TOTAL GENERAL ***</td>
					<td style="width:20%;text-align:right;"><%= e.getTotal() %></td>
				</tr>
				<tr id="totalTr2">
					<td>*** TOTAL PAGADO ***</td>
					<td style="width:20%;text-align:right;"><%= e.getTotalPaid() %></td>
				</tr>
				<tr id="totalTr">
					<td>*** RESTANTE ***</td>
					<td style="width:20%;text-align:right;"><%= Estimation.format.format(r) %></td>
				</tr>
			</tbody>
			</table>				
		<br>
		<div style="text-align:center;font-weight:bold;font-size:11px;">CENTRO M�DICO QUIR�RGICO VIDAMED		
		<br>Departamento Administrativo</div>
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
        <div class="footer" id="footer">
		<ul class="a" style="display:none;" id="footList">
  			<li>PRESUPUESTO V�LIDO POR TREINTA (30) D�AS, A PARTIR DE LA FECHA DE ELABORACI�N.</li>
  			<li>EL MATERIAL M�DICO QUIR�RGICO, F�RMACOS EN HABITACI�N, GASES, ANEST�SICOS Y MEDICAMENTOS SON MONTOS ESTIMADOS QUE PUEDEN VARIAR DE ACUERDO AL CONSUMO.</li>
  			<li>LOS EX�MENES PRE-OPERATORIOS Y LA PRE-ADMISI�N DEBEN HACERSE ANTES DE LA FECHA DE INTERVENCI�N.</li>
  			<li>LOS PACIENTES QUE NO TENGAN P�LIZA DE SEGUROS, PUEDEN CANCELAR EN EFECTIVO, TARJETAS DE CR�DITO, D�BITO O CHEQUE DE GERENCIA. EN CASO DE POSEER CHEQUE DE COMPA��A, DEBE TRAERLO A LA INSTITUCI�N OCHO (8) D�AS ANTES DE LA INTERVENCI�N PARA HACER LA RESPECTIVA VERIFICACI�N.</li>
  			<li>LOS PACIENTES QUE POSEEN P�LIZA DE SEGUROS DEBEN CANCELAR AL MOMENTO DEL INGRESO LA DIFERENCIA QUE EXISTA ENTRE LA CARTA AVAL Y EL PRESUPUESTO.</li>
		</ul>		
		</div>			
	</body>
</html>