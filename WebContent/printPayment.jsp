<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Imprimir Caja</title>	
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
        	<img alt="logo" src="./images/logo.png"/>
        </div>  
		<br>
		<div id="title" style="font-size:16px; font-weight: bold; text-align:right;"> Fecha: 23/06/2013 </div>
		<div id="title" style="font-size:16px; font-weight: bold;"> Detalle Pago realizado a Ana Rojas </div>
		<br>
		<p>
   	   	<b>Especialista:</b> Ana Rojas<br><br>
	    <b>N° de factura:</b> F-24410<br><br>
	    <b>Fecha de la factura:</b> 20/08/2013<br><br>
	    <b>Monto inicial:</b> Bs. 6220,00<br><br>
	    <b>Deducciones realizadas:</b> Bs. 1220,00<br><br>
	    <b>Descuentos aplicados:</b> Bs. 0,00<br><br>
	    <b>Monto a cobrar:</b> Bs. 5000,00<br><br>
	    <b>Cargo desempeñado:</b> Cirujano Ayudante<br><br><br>
	    <b>Pago Realizado el Día:</b> 20/09/2013 <br><br>
		</p>	   
		<div id="botonera">
				<form onsubmit="printPageContentB();">
					<div id="botonP" style="display: inline; margin-right: 30px;">
								<input type="submit"  class="button"  name="sbmtButton" value="Imprimir"  onclick="printPageContentB();unPrintPageContentB();return false" />
					</div>	
					
					<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar"  onClick="javascript:history.back();"  />		
					</div>	
				</form>
				
		</div>			
	</body>
</html>