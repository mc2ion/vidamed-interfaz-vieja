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
		<title>Ver Hospitalización</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
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
		<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
				<ul>
	            	<li class="menuitem"><a href="ListHospitalizationsServlet">Ver Hospitalizaciones</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Hospitalización:</h2>
				<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					</ul>
  					<div id="tabs-1">
  						<br>
					   	<div class="leftColum"><b> Cédula: </b></div>V-12345678<br>
					    <div class="leftColum"><b>Nombre:</b></div> Ana Rojas<br>
					    <div class="leftColum"><b>Fecha de Ingreso:</b></div> 20/06/2013 07:35 AM<br>
					   <div class="leftColum"> <b>Ubicación:</b></div> UCI<br>
					   <div class="leftColum"> <b>Cama:</b></div> Cama 1<br><br>
					   <div class="leftColum"> <b>Médico Tratante:</b></div> Ricardo García<br>
					   <div class="leftColum"><b>Unidad:</b></div> Cirugía<br>
					   <div class="leftColum"><b> Responsable del Pago:</b></div> La Previsora<br><br>
					   
  					</div>
  							<div id="tabs-2">
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
					   		<tr style="background: rgb(136, 162, 190);">
					   			<td>Nombre</td>
					   			<td>Precio</td>
					   			<td>Acción</td>
					   		</tr>
							<tr>
					   			<td>Colocación de prótesis peneana</td>
					   			<td>Bs. 14321,00</td>
					   			<td>
									<a href="ShowProtocolHospitalizationDetailServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
					   		</tr>
					   		<tr>
					   			<td>Apendicectomía</td>
					   			<td>Bs. 7680,00</td>
					   			<td>
									<a href="ShowProtocolHospitalizationDetailServlet" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
					   		</tr>
					   	</table>
					</div>
  				</div>
				<div id="botonera">
					<form action="PrintHospitalizationServlet">
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