<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Men� Principal</title>
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
			
			<div class="menuitemHome"><a href="#">Home</a></div>	
			<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        </div>   	
       <jsp:include page="./menu.jsp" />    
		<div id="content">  
			<h2>Bienvenido al Sistema Hospitalario de Vidamed </h2>
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			<h3>Men� Superior</h3>
			<p>En el men� superior encontrar�s los enlaces para dirigirte al Home o salir del sistema; as� como tambi�n las opciones propias de cada secci�n (del men� lateral izquierdo).</p>
			<p>&nbsp;</p>
			<h3>Men� Lateral Izquierdo</h3>
			<p>En el men� lateral izquierdo encontrar�s las diversas �reas de Vidamed que tu usuario puede administrar. Ingresa al �rea de tu inter�s y realiza los ajustes que desees desde cualquier lugar gracias a las ventajas de la web.</p>
			<p>&nbsp;</p>
			<div id="footer"></div>
      	</div>
   </div>	
</body>
</html>