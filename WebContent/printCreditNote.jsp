<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Imprimir Prefactura</title>	
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
			<div style="width:100%;float:left;text-align:right;">Fecha: 17/07/2013</div>       	
        </div><br>
		<div style="text-align:right;width:100%;font-size:11px;">Hora: 11:28:31 a.m.</div> <br>
		<div id="title" style="font-size:14px; font-weight: bold;text-align:center;"> PREFACTURA # 201345032 </div>
		<hr />
		<div class="header">
			<div style="width:50%;float:left;">Nombre del Paciente: Gipsy Altuve</div>
			<div style="width:50%;float:left;text-align:right;">C�dula de Identidad: 13.463.499</div>       	
        </div><br>
		<div class="header">
			<div style="width:50%;float:left;">Asegurado Principal:</div>
			<div style="width:50%;float:left;text-align:right;">C�dula de Asegurado:</div>       	
        </div><br>
		<div class="header">
			M�dico Tratante: Minaret Sandrea     	
        </div>
		<div class="header">
			Responsable de Pago: Seguros Federal C.A.     	
        </div><br>
        <table id="sweetTable">
			<tbody>
				<tr>
					<th style="width:8%">N�mero</th>
					<th style="width:15%">Diagn�stico</th>
					<th style="width:77%">Protocolo</th>
				</tr>				
				<tr>
					<td>001</td>
					<td>Rinopat�a Obstructiva</td>
					<td>
					<table id="invisibleTable">
			<tbody>
				<tr>
					<th colspan="2">Cirug�a Funcional Endonasal</th>
					<th style="width:20%;text-align:right;">Precio Bs.S.</th>
				</tr>
				<tr>
					<td colspan="2">Hospitalizaci�n</td>
					<td style="width:20%;text-align:right;">3.042,75</td>
				</tr>
				<tr>
					<td colspan="2">Gastos en Quir�fano</td>
					<td style="width:20%;text-align:right;">17.720,34</td>
				</tr>
				<tr>
					<td colspan="2">Servicios M�dicos</td>
					<td style="width:20%;text-align:right;">2.960,15</td>
				</tr>
				<tr>
					<td colspan="2">Honorarios Profesionales</td>
					<td style="width:20%;text-align:right;">13.528,83</td>
				</tr>
				<tr id="totalTr3">
					<td colspan="2">*** TOTAL PROTOCOLO ***</td>
					<td style="width:20%;text-align:right;">37.252,07</td>
				</tr>
			</tbody>
			</table>
					</td>
				</tr>					
				<tr>
					<td>002</td>
					<td>Amigdalitis Cr�nica</td>
					<td>
					<table id="invisibleTable">
			<tbody>
				<tr>
					<th colspan="2">Amigdalectom�a o Tonsilectom�a</th>
					<th style="width:20%;text-align:right;">Precio Bs.S.</th>
				</tr>
				<tr>
					<td colspan="2">Hospitalizaci�n</td>
					<td style="width:20%;text-align:right;">3.042,75</td>
				</tr>				
				<tr>
				<tr>
					<td colspan="2">Gastos en Quir�fano</td>
					<td style="width:20%;text-align:right;">17.720,34</td>
				</tr>
				<tr>
					<td colspan="2">Servicios M�dicos</td>
					<td style="width:20%;text-align:right;">2.960,15</td>
				</tr>
				<tr>
					<td colspan="2">Honorarios Profesionales</td>
					<td style="width:20%;text-align:right;">13.528,83</td>
				</tr>
				<tr id="totalTr3">
					<td colspan="2">*** TOTAL PROTOCOLO ***</td>
					<td style="width:20%;text-align:right;">37.252,07</td>
				</tr>
			</tbody>
			</table></td>
				</tr>
				<tr id="totalTr2">
					<td colspan="2">*** SUB-TOTAL ***</td>
					<td style="width:20%;text-align:right;">74.504,14</td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">I.V.A.</td>
					<td style="width:20%;text-align:right;">0,00</td>
				</tr>
				<tr id="totalTr2">
					<td colspan="2">*** DESCUENTO ***</td>
					<td style="width:20%;text-align:right;">10.000,00</td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">*** TOTAL GENERAL ***</td>
					<td style="width:20%;text-align:right;">64.504,14</td>
				</tr>
			</tbody>
		</table>		
		<br>		
		<br>		
		<br>
		<div style="text-align:center;font-weight:bold;font-size:11px;">CENTRO M�DICO QUIR�RGICO VIDAMED		
		<br>Departamento Administrativo</div>		
		<br>
		<div style="text-align:left;font-size:10px;">Elaborado Por: Elizabeth Hernandez</div>
		<div style="text-align:left;font-size:10px;">Modificado Por: Elizabeth Hernandez</div>
		<br>	
		<div id="botonera">
				<form onsubmit="printPageContentB();">
				<div id="botonP">
							<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" style="margin-left:30%;" onclick="printPageContentB();unPrintPageContentB();return false" />
				</div>	
				</form>
				<form>
					<div id="botonV" style="position:relative; margin-left: 450px; top: -20px;">
							<input type="button" class="button" value="Regresar"  onClick="javascript:history.back();" style="margin-left:40%;" />		
					</div>	
				</form>
			</div>
		<div class="push"></div>
        </div>			
	</body>
</html>