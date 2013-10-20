<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Ver Hospitalizaci�n</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
		<script>
			var prevPage = "";
			var prevButton = "";
			
			$(function evolution() {
				$("#tabs").tabs();
				$("#tabs").tabs("select", window.location.hash);
			});
			
			
			$(document).on('click','#vitalSigns #detailVitalSigns',function(){
				$('#vitalSigns').load('./showVitalSignsDetail.jsp');
				$("#backButton2").show();
				prevPage = "showVitalSigns.jsp";
				prevButton = "signs";
			});
			
			$(document).on('click','#result #detailHosp',function(){
				$('#result').load('./showEvolutionDetail.jsp');
				$("#backButton2").show();
				prevPage = "showEvolution.jsp";
				prevButton = "evolution";
			});
			
			
			
			
			$(document).ready(function() {
				prevPage += ' #contentAux';
		
				$('#result').load('./showEvolution.jsp #contentAux');
				$('#vitalSigns').load('./showVitalSigns.jsp #contentAux');
				
				
				$("#backButton2").click(function() {
					if (prevButton != "evolution")
						$('#vitalSigns').load(prevPage);
					else
						$('#result').load(prevPage);
					$(this).hide();
				});
				
			});
			
			
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
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
				<ul>
	            	<li class="menuitem"><a href="hospitalization.jsp">Ver Hospitalizaciones</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Hospitalizaci�n:</h2>
				<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					    <li><a href="#tabs-3">Servicios</a></li>
					    <li><a href="#tabs-4">Farmacia</a></li>
					    <li><a href="#tabs-5">Evoluci�n</a></li>
					    <li><a href="#tabs-6">Signos Vitales</a></li>
			  		</ul>
  					<div id="tabs-1">
  						<br>
					   	<div class="leftColum"><b> C�dula: </b></div>V-12345678<br>
					    <div class="leftColum"><b>Nombre:</b></div> Ana Rojas<br>
					    <div class="leftColum"><b>Fecha de Ingreso:</b></div> 20/06/2013 07:35 AM<br>
					   <div class="leftColum"> <b>Ubicaci�n:</b></div> UCI<br>
					   <div class="leftColum"> <b>Cama:</b></div> Cama 1<br><br>
					   <div class="leftColum"> <b>M�dico Tratante:</b></div> Ricardo Garc�a<br>
					   <div class="leftColum"><b>Unidad:</b></div> Cirug�a<br>
					   <div class="leftColum"><b> Responsable del Pago:</b></div> La Previsora<br><br>
					   
  					</div>
  					<div id="tabs-2">
  						<br>
					    <p>
					    * Histerectom�a<br><br>
					    * Colecistectom�a<br><br>
					    * Apendicectom�a<br><br>
					    </p>
  					</div>
  					<div id="tabs-3">
  						<br>
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
					</div>
					<div id="tabs-4">
						<br>
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
					</div>
					<div id="tabs-5">
					<br>
						<table id="sweetTable">
								<tbody>
									<tr>
										<th>Fecha</th>
										<th>M�dico</th>
										<th>Ver Detalle</th>
									</tr>				
									<tr>
										<td>27/06/2013 07:35 PM</td>
										<td>Ricardo Garc�a</td>
										<td style="text-align:center;">
									<a href="showEvolutionDetail.jsp?function=showHospitalization" style="color: transparent" >
										<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
							</tr>				
							<tr>
								<td>23/06/2013 09:40 AM</td>
								<td>Javier Fernandez</td>
								<td style="text-align:center;">										
									<a href="#" style="color: transparent" >
										<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
							</tr>				
							<tr>
								<td>20/06/2013 07:35 AM</td>
								<td>Ricardo Garc�a</td>
								<td style="text-align:center;">										
									<a href="#" style="color: transparent" >
										<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
							</tr>				
							<tr>
								<td>19/06/2013 10:06 AM</td>
								<td>Ricardo Garc�a</td>
								<td style="text-align:center;">										
									<a href="#" style="color: transparent" >
										<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
							</tr>
						</tbody>
						</table>
						<br>
					</div>
					<div id="tabs-6">
						<br>
		    <table id="sweetTable">
				<tbody>
					<tr>
						<th>Fecha de Toma</th>
						<th>Hora de Toma</th>
						<th>Ver Detalle</th>
					</tr>				
					<tr>
						<td>27/06/2013</td>
						<td>07:35 PM</td>
						<td style="text-align:center;">
							<a href="showVitalSignsDetail.jsp?function=showHospitalization" style="color: transparent"  >
								<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
							</a>
						</td>
					</tr>				
					<tr>
						<td>23/06/2013</td>
						<td>09:40 AM</td>
						<td style="text-align:center;">										
							<a href="#" style="color: transparent" >
								<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
							</a>
						</td>
					</tr>				
					<tr>
						<td>20/06/2013</td>
						<td>07:35 AM</td>
						<td style="text-align:center;">										
							<a href="#" style="color: transparent" >
								<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
							</a>
						</td>
					</tr>				
					<tr>
						<td>19/06/2013</td>
						<td>10:06 AM</td>
						<td style="text-align:center;">										
							<a href="#" style="color: transparent" >
								<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
							</a>
						</td>
					</tr>
				</tbody>
			</table><br>
					</div>
				</div>
				<div id="botonera">
					<form action="printhospitalization.jsp">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>		
					</form>
				</div>	
			</div>
		</div>
	</body>
</html>