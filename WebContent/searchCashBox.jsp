<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Imprimir Cierre de Caja</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript">
	var idUser;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2) {
		idUser = var1;
		$('.cliente').text(var2);
		
	};
	
	function setV(f){
		f.elements['userId'].value = idUser;
		return true;
	}
	</script>
</head>
<body>
	<div id="container">
		<div id="header">
        	<img alt="logo" src="./images/logo.png"/>
        </div>         
      	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="pendingAdmissionDischarges.jsp">Altas Admisi�n<span class="badge yellow">3</span></a></li>
		 		<li><a href="pendingCreditNotes.jsp">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="pendingCreditNotesReview.jsp">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="pendingInvoices.jsp">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="pendingRequest.jsp">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="pendingPharmacyDischarges.jsp">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="billing.jsp">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="mainMenu.jsp">Home</a></div>	
	    	<ul>
            	<li class="menuitem"><a href="bank.jsp">Ver Cajas</a></li>
           		<li class="menuitem"><a href="createCashBox.jsp">Crear Caja</a></li>
            </ul>	
	    	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Cajas que coinciden con su b�squeda:</h2>
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
										<td>Ricardo Garc�a</td>
										<td></td>
										<td>Apertura Caja</td>
										<td>Efectivo</td>
										<td>Bs. 1001</td>
										<td>Bs. 1001</td>
									</tr>			
									<tr class="gradeA">
										<td>Principal</td>
										<td>11/05/2013 08:50 am</td>
										<td>Ricardo Garc�a</td>
										<td>Particular</td>
										<td>Abono</td>
										<td>Efectivo</td>
										<td>Bs. 1500</td>
										<td>Bs. 2501</td>
									</tr>			
									<tr class="gradeA">
										<td>Principal</td>
										<td>11/05/2013 11:42 am</td>
										<td>Ricardo Garc�a</td>
										<td>Mapfre La Seguridad</td>
										<td>Pago</td>
										<td>Cheque</td>
										<td>Bs. 15000</td>
										<td></td>
									</tr>			
									<tr class="gradeA">
										<td>Principal</td>
										<td>11/05/2013 03:29 pm</td>
										<td>Ricardo Garc�a</td>
										<td>Particular</td>
										<td>Reintegro</td>
										<td>Cheque</td>
										<td>Bs. 10501</td>
										<td></td>
									</tr>			
									<tr class="gradeA">
										<td>Principal</td>
										<td>11/05/2013 08:00 pm</td>
										<td>Ricardo Garc�a</td>
										<td></td>
										<td>Cierre Caja</td>
										<td>Efectivo</td>
										<td></td>
										<td>Bs. 2501</td>
									</tr>
									<tr class="gradeA">
										<td>Principal</td>
										<td>17/06/2013 08:00 pm</td>
										<td>Ani G�mez</td>
										<td></td>
										<td>Apertura Caja</td>
										<td>Efectivo</td>
										<td>Bs. 2017</td>
										<td>Bs. 2017</td>
									</tr>
									<tr class="gradeA">
										<td>Principal</td>
										<td>18/06/2013 08:00 am</td>
										<td>Ani G�mez</td>
										<td></td>
										<td>Cierre Caja</td>
										<td>Efectivo</td>
										<td></td>
										<td>Bs. 2017</td>
									</tr>
									<tr class="gradeA">
										<td>Principal</td>
										<td>24/06/2013 08:00 pm</td>
										<td>Luis P�rez</td>
										<td></td>
										<td>Apertura Caja</td>
										<td>Efectivo</td>
										<td>Bs. 6196</td>
										<td>Bs. 6196</td>
									</tr>
									<tr class="gradeA">
										<td>Principal</td>
										<td>25/06/2013 08:00 am</td>
										<td>Luis P�rez</td>
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
						<form action="printSearchCashBox.jsp">
							<div id="botonP" style="display: inline; margin-right: 30px;">
										<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" />
							</div>	
							<div id="botonV" style="display: inline;">
									<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
							</div>	
						</form>
					</div><br>
				</div>
				<div class="spacer"></div>
        	</div>
       	</div>
		
	</body>
</html>