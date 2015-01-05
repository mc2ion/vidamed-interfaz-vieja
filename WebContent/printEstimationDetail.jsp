<%@page import="domain.BussinessMicro"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="domain.Protocol"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.Estimation"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%


%>

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
			<div style="width:50%;float:left;">HOSPITALIZACIÓN VIDAMED</div>
			<div style="width:50%;float:left;text-align:right;"><b>Fecha: </b> <%= dateTxt %></div>           	
        </div><br>
		<div style="text-align:right;width:100%;font-size:11px;"><b>Hora: </b><%= hour %></div> <br>
		<div id="title" style="font-size:14px; font-weight: bold;text-align:center;"> PRESUPUESTO # <%= e.leftPadStringWithChar(est, 9, '0') %> </div>
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
				<% for (int i = 0; i < pList.size(); i++){ 
					Protocol p = pList.get(i);
				%>			
				<tr>
					<td><%= p.getProtocolID() %></td>
					<td><%= p.getDiagnosis() %></td>
					<td><%= p.getName() %><br>
					<table id="invisibleTable">
						<tbody>
					<% 
						Long id = 0L;
							
						for (int j = 0 ; j < lList.size(); j ++){ 
						Protocol pt = lList.get(j);
						if (pList.get(i).getProtocolID() == pt.getProtocolID()){
							
							if (pt.getBussinessRuleMicroID() != id){
								id = pt.getBussinessRuleMicroID();
							%>
								<tr>
									<th><%= pt.getBussinessRuleMicroName()%></th>
									<th style="width:20%;text-align:right;">Precio Bs.F.</th>
								</tr>	
								
							<% } %>
							<tr>
							<td style="width:50%"><%= pt.getProtocolScaleName() %></td>
							<td style="width:20%;text-align:right;"><%= pt.getEstimationCost()%></td>
							</tr>
					<% 
						}
					}
					%>
			</tbody>
			</table>
					</td>
				</tr>	
			<% } %>				
				<tr id="totalTr2">
					<% 
						  double amount = Double.parseDouble(e.getTotal());
						  DecimalFormat formatter = new DecimalFormat("#,###.##");
						  String number = formatter.format(amount) ;
					%> 
					<td colspan="2">*** SUB-TOTAL GENERAL ***</td>
					<td style="width:20%;text-align:right;"><%= number %></td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">I.V.A.</td>
					<td style="width:20%;text-align:right;">0,00</td>
				</tr>
				<% 
					String total = number;	
					if (e.getTotalWithDiscount() != null) { 
						double a = Double.valueOf(e.getTotal());
						double b = Double.valueOf(e.getTotalWithDiscount());
						double disc  = a - b;
						String discF = formatter.format(disc);
						total = e.getTotalWithDiscount() ;
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
			</tbody>
		</table>		
		<br>		
		<br>		
		<br>
		<div style="text-align:center;font-weight:bold;font-size:11px;">CENTRO MÉDICO QUIRÚRGICO VIDAMED		
		<br>Departamento Administrativo</div>		
		<br>
		<div style="text-align:left;font-size:10px;"><b>Elaborado Por:</b> <%= e.getCreationUser() %></div>
		<% if (e.getEditionUser() != null){ %>
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
  			<li>PRESUPUESTO VÁLIDO POR TREINTA (30) DÍAS, A PARTIR DE LA FECHA DE ELABORACIÓN.</li>
  			<li>EL MATERIAL MÉDICO QUIRÚRGICO, FÁRMACOS EN HABITACIÓN, GASES, ANESTÉSICOS Y MEDICAMENTOS SON MONTOS ESTIMADOS QUE PUEDEN VARIAR DE ACUERDO AL CONSUMO.</li>
  			<li>LOS EXÁMENES PRE-OPERATORIOS Y LA PRE-ADMISIÓN DEBEN HACERSE ANTES DE LA FECHA DE INTERVENCIÓN.</li>
  			<li>LOS PACIENTES QUE NO TENGAN PÓLIZA DE SEGUROS, PUEDEN CANCELAR EN EFECTIVO, TARJETAS DE CRÉDITO, DÉBITO O CHEQUE DE GERENCIA. EN CASO DE POSEER CHEQUE DE COMPAÑÍA, DEBE TRAERLO A LA INSTITUCIÓN OCHO (8) DÍAS ANTES DE LA INTERVENCIÓN PARA HACER LA RESPECTIVA VERIFICACIÓN.</li>
  			<li>LOS PACIENTES QUE POSEEN PÓLIZA DE SEGUROS DEBEN CANCELAR AL MOMENTO DEL INGRESO LA DIFERENCIA QUE EXISTA ENTRE LA CARTA AVAL Y EL PRESUPUESTO.</li>
		</ul>		
		</div>			
	</body>
</html>