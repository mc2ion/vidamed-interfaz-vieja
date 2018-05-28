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
		
		#sweetTable {
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
		
		#totalTr td {
			background-color: #1EB1DD;	
			font-weight: bold;
		}
		
		#sweetTable td, #sweetTable th {
			border: 1px solid #006c92;
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
			<div style="float:left;width:100%;text-align:right;">Fecha: 17/07/2013</div>       	
        </div><br>
		<div style="text-align:right;width:100%;font-size:11px;">Hora: 11:28:31 a.m.</div> <br>
		<div id="title" style="font-size:14px; font-weight: bold;text-align:center;"> PRESUPUESTO # 201345032 </div>
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
					<th style="width:10%">N�mero</th>
					<th style="width:45%">Diagn�stico</th>
					<th style="width:45%">Protocolo</th>
				</tr>				
				<tr>
					<td>001</td>
					<td>Rinopat�a Obstructiva</td>
					<td>Cirug�a Funcional Endonasal</td>
				</tr>					
				<tr>
					<td>002</td>
					<td>Amigdalitis Cr�nica</td>
					<td>Amigdalectom�a o Tonsilectom�a</td>
				</tr>
			</tbody>
		</table>
		<br>
		<table id="sweetTable">
			<tbody>
				<tr>
					<th colspan="2">Hospitalizaci�n</th>
					<th style="width:20%;text-align:right;">Precio Bs.S.</th>
				</tr>				
				<tr>
					<td style="width:50%">Habitaci�n</td>
					<td style="width:30%">Ambulatorio</td>
					<td style="width:20%;text-align:right;">1.135,20</td>
				</tr>				
				<tr>
					<td style="width:50%">M�dico Residente</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">220,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Servicios de Asistencia Permanente</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">154,69</td>
				</tr>				
				<tr>
					<td style="width:50%">Servicios de Alimentaci�n</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">260,00</td>
				</tr>								
				<tr>
					<td style="width:50%">Servicios Farmac�uticos Ambulatorios</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">35,20</td>
				</tr>				
				<tr>
					<td style="width:50%">F�rmacos en Habitaci�n</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">650,32</td>
				</tr>				
				<tr>
					<td style="width:50%">Material M�dico Quir�rgico en Habitaci�n</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">587,34</td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">*** SUB-TOTAL ***</td>
					<td style="width:20%;text-align:right;">3.042,75</td>
				</tr>
				<tr>
					<th colspan="2">Gastos en Quir�fano</th>
					<th style="width:20%;text-align:right;">Precio Bs.S.</th>
				</tr>				
				<tr>
					<td style="width:50%">Quir�fano</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">4.875,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Sala de Recuperaci�n</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">450,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Monitoreo</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">1.950,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Gases, Anest�sicos y Medicamentos</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">4.593,91</td>
				</tr>								
				<tr>
					<td style="width:50%">Material M�dico Quir�rgico</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">5852,03</td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">*** SUB-TOTAL ***</td>
					<td style="width:20%;text-align:right;">17.720,34</td>
				</tr>
				<tr>
					<th colspan="2">Servicios M�dicos</th>
					<th style="width:20%;text-align:right;">Precio Bs.S.</th>
				</tr>				
				<tr>
					<td style="width:50%">Banco de Sangre (Tipiaje)</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">591,25</td>
				</tr>				
				<tr>
					<td style="width:50%">Electrocardiograma Reposo</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">402,50</td>
				</tr>				
				<tr>
					<td style="width:50%">Evaluaci�n Cardiovascular Pre-Operatoria</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">812,50</td>
				</tr>				
				<tr>
					<td style="width:50%">Laboratorio Cl�nico</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">552,00</td>
				</tr>								
				<tr>
					<td style="width:50%">Rayos X</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">601,90</td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">*** SUB-TOTAL ***</td>
					<td style="width:20%;text-align:right;">2.960,15</td>
				</tr>
				<tr>
					<th colspan="2">Honorarios Profesionales</th>
					<th style="width:20%;text-align:right;">Precio Bs.S.</th>
				</tr>				
				<tr>
					<td style="width:50%">Cirujano Principal</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">3.300,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Cirujano Ayudante I</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">1.320,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Anestesi�logo</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">1.320,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Instrumentista</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">224,20</td>
				</tr>								
				<tr>
					<td style="width:50%">Enfermera Circulante</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">56,63</td>
				</tr>				
				<tr>
					<td style="width:50%">Instrumental Especial</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">2.000,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Equipo Endoscopio</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">2.500,00</td>
				</tr>								
				<tr>
					<td style="width:50%">Material Especial</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">2.500,00</td>
				</tr>								
				<tr>
					<td style="width:50%">Consulta Pre-Anest�sica</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">308,00</td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">*** SUB-TOTAL ***</td>
					<td style="width:20%;text-align:right;">13.528,83</td>
				</tr>
				<tr id="totalTr2">
					<td colspan="2">*** TOTAL ***</td>
					<td style="width:20%;text-align:right;">37.252,07</td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">*** DESCUENTO ***</td>
					<td style="width:20%;text-align:right;">1.000,00</td>
				</tr>
				<tr id="totalTr2">
					<td colspan="2">I.V.A.</td>
					<td style="width:20%;text-align:right;">0,00</td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">*** TOTAL GENERAL ***</td>
					<td style="width:20%;text-align:right;">36.252,07</td>
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
        <div class="footer" id="footer">
			<ul class="a" style="display:none;" id="footList">
	  			<li>ESTE PRESUPUESTO ES ESTIMADO Y PODR� SUFRIR VARIACIONES DE ACUERDO A LA PERMANENCIA Y/O EVOLUCI�N DEL PACIENTE; Y EN EL MISMO NO EST� INCLUIDO CONTINGENCIAS, NI SERVICIOS ESPECIALES. EL MATERIAL M�DICO QUIR�RGICO Y MEDICINAS SER�N FACTURADOS DE ACUERDO AL CONSUMO.</li>
	  			<li>SI TIENE P�LIZA DE SEGUROS DEBE DEPOSITAR LA DIFERENCIA ENTRE LA COBERTURA APROBADA Y EL PRESENTE PRESUPUESTO. </li>
	  			<li>ESTE PRESUPUESTO ES V�LIDO POR 7 D�AS. DEBE PRESENTAR LOS EX�MENES PRE-OPERATORIOS AL MOMENTO DE SU INGRESO.</li>
			</ul>		
		</div>		
	</body>
</html>