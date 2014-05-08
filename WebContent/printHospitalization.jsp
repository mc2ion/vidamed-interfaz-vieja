<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Imprimir Hospitalizaci�n</title>	
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
		#especial{
			background-image:url(null);
			margin-left: 10%;
			margin-right: 10%;
		}
		input{
			border: none;
		}
		
		label, span {
			font-weight: bold;
		}
		</style>
	<script > 
	<!-- 
	
	function inhabilitar(){ 
	   	return false;
	} 
	
	document.oncontextmenu=inhabilitar;
	
	// --> 
	</script>
</head>
	<body id="especial">
		<div id="printHeader">
        	
        </div>  
		
		<br>
		<div id="title" style="font-size:16px; font-weight: bold; text-align:right;"> Fecha: 20/06/2013 07:35 AM</div>
		<div id="title" style="font-size:16px; font-weight: bold;"> Hospitalizaci�n n� 1001 </div>
		<br>
		
		<h3>Datos Paciente</h3>
		<fieldset>
			<label for="name" class="etiq"><span id="idCard">C�dula de Identidad: </span></label>V-12345678<br><br>
			<label for="name" class="etiq"><span id="idCard">Nombre: </span></label>Ana Rojas<br>	<br>				
			<label for="name" class="etiq"><span id="idCard">Fecha de Ingreso: </span></label>20/06/2013 07:35 AM<br><br>
			<label for="name" class="etiq"><span id="idCard">Ubicaci�n: </span></label>UCI<br><br>
			<label for="name" class="etiq"><span id="idCard">Cama: </span></label>Cama 1<br> <br>
			<label for="name" class="etiq"><span id="idCard">M�dico Tratante: </span></label>Ricardo Garc�a<br><br>
			<label for="name" class="etiq"><span id="idCard">Unidad: </span></label>Cirug�a<br>  <br>
			<label for="name" class="etiq"><span id="idCard">Responsable del Pago: </span></label>La Previsora<br> <br>
		</fieldset>
		<br>
		<h3>Protocolos</h3>
		<fieldset>
			<label for="name" class="etiq"><span id="idCard"></span></label> * Histerectom�a<br><br>
			<label for="name" class="etiq"><span id="idCard"></span></label> * Colecistectom�a<br><br>
			<label for="name" class="etiq"><span id="idCard"></span></label> * Apendicectom�a<br>
		</fieldset>
		<br>
		<h3>Servicios</h3>
		<table id="sweetTable">
			<tbody>
				<tr>
					<th>Servicio</th>
					<th>Precio</th>
				</tr>				
				<tr>
					<td>Hospitalizaci�n</td>
					<td>Bs 3472,00</td>
				</tr>				
				<tr>
					<td>Anestesia Peridural</td>
					<td>Bs 2727,50</td>
				</tr>				
				<tr>
					<td>Servicios M�dicos</td>
					<td>Bs 1021,90</td>
				</tr>				
				<tr id="totalTr">
					<td>*** MONTO TOTAL ***</td>
					<td>Bs 7221,40</td>
				</tr>
			</tbody>
		</table>
		<br>
		<h3>Suminitros</h3>
		<table id="sweetTable">
			<tbody>
				<tr>
					<th>Suministro</th>
					<th>Cantidad</th>
					<th>Pendiente</th>
					<th>Recibido</th>
				</tr>				
				<tr>
					<td>Guantes de Examen N/Esteril M</td>
					<td>1</td>
					<td>1</td>
					<td>0</td>
				</tr>				
				<tr>
					<td>Alcohol</td>
					<td>1</td>
					<td>1</td>
					<td>0</td>
				</tr>				
				<tr>
					<td>Algod�n</td>
					<td>3</td>
					<td>3</td>
					<td>0</td>
				</tr>				
				<tr>
					<td>S�banas de Camilla</td>
					<td>1</td>
					<td>0</td>
					<td>1</td>
				</tr>
			</tbody>
		</table>
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
	</body>
</html>