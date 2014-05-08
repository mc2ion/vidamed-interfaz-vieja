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
			margin-left: 10px;
			margin-right: 10px;
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
	   	return true;
	} 
	
	document.oncontextmenu=inhabilitar;
	
	// --> 
	</script>
</head>
	<body id="especial">
		<div id="printHeader">
        	
        </div>  
		<div id="dt_example">
					<div id="container">
						<div id="demo">
						 <table id="sweetTable">
								<tbody>	
									<tr>
									<th>Caja</th>
									<th>Fecha</th>
									<th>Cajero</th>
									<th>Responsable Pago</th>
									<th>Tipo</th>
									<th>Forma</th>
									<th>Monto</th>
									<th>Total</th>
								</tr>			
									<tr class="gradeA">
										<td>Principal</td>
										<td>11/05/2013 08:00 am</td>
										<td>Ricardo García</td>
										<td></td>
										<td>Apertura Caja</td>
										<td>Efectivo</td>
										<td>Bs. 1001</td>
										<td>Bs. 1001</td>
									</tr>			
									<tr class="gradeA">
										<td>Principal</td>
										<td>11/05/2013 08:50 am</td>
										<td>Ricardo García</td>
										<td>Particular</td>
										<td>Abono</td>
										<td>Efectivo</td>
										<td>Bs. 1500</td>
										<td>Bs. 2501</td>
									</tr>			
									<tr class="gradeA">
										<td>Principal</td>
										<td>11/05/2013 11:42 am</td>
										<td>Ricardo García</td>
										<td>Mapfre La Seguridad</td>
										<td>Pago</td>
										<td>Cheque</td>
										<td>Bs. 15000</td>
										<td></td>
									</tr>			
									<tr class="gradeA">
										<td>Principal</td>
										<td>11/05/2013 03:29 pm</td>
										<td>Ricardo García</td>
										<td>Particular</td>
										<td>Reintegro</td>
										<td>Cheque</td>
										<td>Bs. 10501</td>
										<td></td>
									</tr>			
									<tr class="gradeA">
										<td>Principal</td>
										<td>11/05/2013 08:00 pm</td>
										<td>Ricardo García</td>
										<td></td>
										<td>Cierre Caja</td>
										<td>Efectivo</td>
										<td></td>
										<td>Bs. 2501</td>
									</tr>
									<tr class="gradeA">
										<td>Principal</td>
										<td>17/06/2013 08:00 pm</td>
										<td>Ani Gómez</td>
										<td></td>
										<td>Apertura Caja</td>
										<td>Efectivo</td>
										<td>Bs. 2017</td>
										<td>Bs. 2017</td>
									</tr>
									<tr class="gradeA">
										<td>Principal</td>
										<td>18/06/2013 08:00 am</td>
										<td>Ani Gómez</td>
										<td></td>
										<td>Cierre Caja</td>
										<td>Efectivo</td>
										<td></td>
										<td>Bs. 2017</td>
									</tr>
									<tr class="gradeA">
										<td>Principal</td>
										<td>24/06/2013 08:00 pm</td>
										<td>Luis Pérez</td>
										<td></td>
										<td>Apertura Caja</td>
										<td>Efectivo</td>
										<td>Bs. 6196</td>
										<td>Bs. 6196</td>
									</tr>
									<tr class="gradeA">
										<td>Principal</td>
										<td>25/06/2013 08:00 am</td>
										<td>Luis Pérez</td>
										<td></td>
										<td>Cierre Caja</td>
										<td>Efectivo</td>
										<td></td>
										<td>Bs. 6196</td>
									</tr>
								</tbody>
						</table>
						</div>
					</div><br>
					<div id="botonera">
						<form onsubmit="printPageContentB();">
							<div id="botonP" style="display: inline; margin-right: 30px;">
										<input type="submit"  class="button"  name="sbmtButton" value="Imprimir"  onclick="printPageContentB();unPrintPageContentB();return false" />
							</div>	
							
							<div id="botonV" style="display: inline;">
										<input type="button" class="button" value="Regresar"  onClick="javascript:history.back();"  />		
							</div>	
						</form>
					</div><br>
				</div>
				<div class="spacer"></div>
	</body>
</html>