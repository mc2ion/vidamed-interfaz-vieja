<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Cuenta por Cobrar</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>		
		<!--JS Datapicker-->
		<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
		<script type="text/javascript">
			$(function(){
				$.datepicker.setDefaults($.datepicker.regional['es']);
				$('#txtDateIni').datepicker({
					showOn: "button",
					buttonImage: "images/calendar.png",
					buttonImageOnly: true,
					buttonText: "Seleccione una fecha",
					changeMonth: true,
				    changeYear: true
				});
			} );
		</script>
		<link rel="stylesheet" href="/resources/demos/style.css" />		
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	   	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="ListAdmissionDischargesServlet">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListAccountsServlet">Ver Cuentas</a></li>
	            </ul>
	           <div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Cuenta por Cobrar:</h2>
	        	<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Información Cuenta</a></li>
					    <li><a href="#tabs-2">Información Adicional</a></li>
			  		</ul>
			  		<div id="tabs-1">
						<fieldset>
							<label for="name">Factura:</label>F-1001<br><br>
							<label for="name">Número Control:</label>1726289 <br><br>
							<label for="name">Responsable Pago:</label>Multinacional de Seguros, C.A<br><br>
							<label for="name">Monto a Cobrar:</label>Bs. 13392,85<br><br>
							<label for="name">IVA:</label>Bs. 1607,15<br><br>
							<label for="name">Fecha Vencimiento:</label>20/08/2013
						</fieldset>						
						
			  		</div>
			  		<div id="tabs-2">
						<fieldset>
							<label for="name">Empresa:</label>Centro Médico Quirúrgico Vidamed<br><br>
							<label for="name">Unidad de Negocio:</label>Emergencia Vidamed <br><br>
							<label for="name">Clasificación:</label> Urgente <br><br>
							<label for="name">Tipo Responsable:</label>Empresa<br><br>
							<label for="name">Beneficiario Factura:</label>Centro Quirúrgico Vidamed C.A<br><br>
						</fieldset>		
					</div>
			  	</div>
		  		<div id="botonera">
			  		<form action="ListAccountsServlet#tabs-1">
						<div id="botonV" style="display: inline; margin-left: 40px;">
								<input type="submit" class="button" value="Regresar" />		
						</div>
					</form>	
				</div><br>
			</div>
		</div>
	</body>
</html>