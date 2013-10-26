<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Ver Admisión</title>
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
	            	<li class="menuitem"><a href="AdmitPatientFormServlet">Admitir Paciente</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Admisión:</h2>
				<br>
				<div style="text-align:left;">
				    <div class="leftColum"><b> Cédula: </b></div> V-12345678<br><br>
				   	<div class="leftColum"> <b> Nombre: </b></div> Ana Rojas<br><br>
				   	<div class="leftColum"> <b> Responsable del Pago: </b></div> Multinacional de Seguros, C.A.<br><br>
				    <div class="leftColum"><b> Motivo de Admisión: </b></div> Dolor abdominal<br><br>
				    <div class="leftColum"><b>Ubicación: </b></div> Emergencias<br><br>
				    <div class="leftColum"><b>N° Presupuesto:  </b></div>1001
				    <a href="ShowEstimationServlet?function=showAdmission" style="color: transparent" >
						<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
					</a>
				    <br><br>
			    </div>
				<div id="botonera">
					<form action="PrintAdmissionServlet">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</form>
				</div><br>
			</div>
		</div>
	</body>
</html>