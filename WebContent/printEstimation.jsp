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
			<div style="width:50%;float:left;text-align:right;">Cédula de Identidad: 13.463.499</div>       	
        </div><br>
		<div class="header">
			<div style="width:50%;float:left;">Asegurado Principal:</div>
			<div style="width:50%;float:left;text-align:right;">Cédula de Asegurado:</div>       	
        </div><br>
		<div class="header">
			Médico Tratante: Minaret Sandrea     	
        </div>
		<div class="header">
			Responsable de Pago: Seguros Federal C.A.     	
        </div><br>
        <table id="sweetTable">
			<tbody>
				<tr>
					<th style="width:10%">Número</th>
					<th style="width:45%">Diagnóstico</th>
					<th style="width:45%">Protocolo</th>
				</tr>				
				<tr>
					<td>001</td>
					<td>Rinopatía Obstructiva</td>
					<td>Cirugía Funcional Endonasal</td>
				</tr>					
				<tr>
					<td>002</td>
					<td>Amigdalitis Crónica</td>
					<td>Amigdalectomía o Tonsilectomía</td>
				</tr>
			</tbody>
		</table>
		<br>
		<table id="sweetTable">
			<tbody>
				<tr>
					<th colspan="2">Hospitalización</th>
					<th style="width:20%;text-align:right;">Precio Bs.S.</th>
				</tr>				
				<tr>
					<td style="width:50%">Habitación</td>
					<td style="width:30%">Ambulatorio</td>
					<td style="width:20%;text-align:right;">1.135,20</td>
				</tr>				
				<tr>
					<td style="width:50%">Médico Residente</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">220,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Servicios de Asistencia Permanente</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">154,69</td>
				</tr>				
				<tr>
					<td style="width:50%">Servicios de Alimentación</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">260,00</td>
				</tr>								
				<tr>
					<td style="width:50%">Servicios Farmacéuticos Ambulatorios</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">35,20</td>
				</tr>				
				<tr>
					<td style="width:50%">Fármacos en Habitación</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">650,32</td>
				</tr>				
				<tr>
					<td style="width:50%">Material Médico Quirúrgico en Habitación</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">587,34</td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">*** SUB-TOTAL ***</td>
					<td style="width:20%;text-align:right;">3.042,75</td>
				</tr>
				<tr>
					<th colspan="2">Gastos en Quirófano</th>
					<th style="width:20%;text-align:right;">Precio Bs.S.</th>
				</tr>				
				<tr>
					<td style="width:50%">Quirófano</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">4.875,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Sala de Recuperación</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">450,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Monitoreo</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">1.950,00</td>
				</tr>				
				<tr>
					<td style="width:50%">Gases, Anestésicos y Medicamentos</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">4.593,91</td>
				</tr>								
				<tr>
					<td style="width:50%">Material Médico Quirúrgico</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">5852,03</td>
				</tr>
				<tr id="totalTr">
					<td colspan="2">*** SUB-TOTAL ***</td>
					<td style="width:20%;text-align:right;">17.720,34</td>
				</tr>
				<tr>
					<th colspan="2">Servicios Médicos</th>
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
					<td style="width:50%">Evaluación Cardiovascular Pre-Operatoria</td>
					<td style="width:30%"></td>
					<td style="width:20%;text-align:right;">812,50</td>
				</tr>				
				<tr>
					<td style="width:50%">Laboratorio Clínico</td>
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
					<td style="width:50%">Anestesiólogo</td>
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
					<td style="width:50%">Consulta Pre-Anestésica</td>
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
		<div style="text-align:center;font-weight:bold;font-size:11px;">CENTRO MÉDICO QUIRÚRGICO VIDAMED		
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
	  			<li>ESTE PRESUPUESTO ES ESTIMADO Y PODRÁ SUFRIR VARIACIONES DE ACUERDO A LA PERMANENCIA Y/O EVOLUCIÓN DEL PACIENTE; Y EN EL MISMO NO ESTÁ INCLUIDO CONTINGENCIAS, NI SERVICIOS ESPECIALES. EL MATERIAL MÉDICO QUIRÚRGICO Y MEDICINAS SERÁN FACTURADOS DE ACUERDO AL CONSUMO.</li>
	  			<li>SI TIENE PÓLIZA DE SEGUROS DEBE DEPOSITAR LA DIFERENCIA ENTRE LA COBERTURA APROBADA Y EL PRESENTE PRESUPUESTO. </li>
	  			<li>ESTE PRESUPUESTO ES VÁLIDO POR 7 DÍAS. DEBE PRESENTAR LOS EXÁMENES PRE-OPERATORIOS AL MOMENTO DE SU INGRESO.</li>
			</ul>		
		</div>		
	</body>
</html>