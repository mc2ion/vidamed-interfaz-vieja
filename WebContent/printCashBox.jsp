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
		<div id="title" style="font-size:16px; font-weight: bold;"> Caja Administracion </div>
		<br>
		<p>
	    <b>Fecha Apertura:</b> 20/07/2013<br><br>
	    <b>Hora de apertura:</b> 9:30am<br><br>
	    <b>Cajero:</b> Ana Roja<br><br>
	    <b>Monto Inicio:</b> Bs. 100<br><br>
	    <b>Monto Cobrado:</b> Bs. 0<br><br>
	    <b>Monto Pagado:</b> Bs. 0<br><br>
			   
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