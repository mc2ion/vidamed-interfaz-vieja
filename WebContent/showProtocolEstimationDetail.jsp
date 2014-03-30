<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Movimiento</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
		<script>
		  $(function() {
		    $( "#accordion" ).accordion();
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
         		<li><a href="#">Bienvenido, <%= name %></a></li>
                <li><a href="ListAdmissionDischargesServlet">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">	<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul id="menuInside">
	            	<li class="menuitem"><a href="ListEstimationsServlet">Ver Presupuestos</a></li>
	            	<li class="menuitem"><a href="CreateEstimationServlet">Crear Presupuesto</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Colocación de prótesis peneana:</h2>
				<br>
				<div id="accordion">
				  <h3>Hospitalización</h3>
				  <div>
				    <table class="table-simple">
				    	<tr>
				    		<td>Habitación</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Médico Residente</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Teléfono</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Televisión</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Acompañante</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Kit Paciente</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Servicio de Asistencia Permanente</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Servicio de Alimentación</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Servicios Farmacéuticos Quirúrgicos</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Fármacos en Habitación</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Material Médico Quirúrgico en Habitación</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	
				    </table>
				  </div>
				  <h3>Gastos en Quirófano</h3>
				  <div>
				    <table class="table-simple">
				    	<tr>
				    		<td>Quirófano</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Sala de Recuperación</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Monitoreo</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Gases, anestésicos y medicamentos</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Material Médico Quirúrgico</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    </table>
				  </div>
				  <h3>Servicios Médicos</h3>
				  <div>
				    <table class="table-simple">
				    	<tr>
				    		<td>Banco de Sangre (Tipiaje)</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Electrocardiograma</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Evaluación cardiovascular, pre-operatoria</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Laboratorio Clínico</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Rayos X</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    </table>
				  </div>
				  <h3>Honorarios Profesionales</h3>
				  <div>
				  	<table class="table-simple">
				    	<tr>
				    		<td>Cirujano Principal - Dr. Ricardo Perez</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Cirujano Ayudante I - Dra. Ana Rojas </td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Cirujano Ayudante II  - Dra. Luisa Mendez </td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Anestesiólogo - Pedro Rojas</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Instrumentista - Luis Gonzalez </td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Enfermera Circulante - Maria Cruz</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    	<tr>
				    		<td>Consulta Pre-anestésica</td>
				    		<td>Bs. 2270</td>
				    	</tr>
				    </table>
				  </div>
				</div>
				<div id="botonera2"  style="width: 120px;">
					<input type="button"  class="button"  name="sbmtButton" value="Regresar" onclick="history.go(-1);" />
				</div><br>
				 
			</div>
		</div>
	</body>
</html>