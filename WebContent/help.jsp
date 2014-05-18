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
		<title>Ayuda</title>
		<link rel="stylesheet" href="./css/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
	</head>
	<body style="background: white;">
		<div class="menu-help">
			<ul>
		   <li class='first'><a href='ListEstimationsServlet'><span>Presupuesto</span></a></li>
		   <li><a href='ListEmergenciesServlet'><span>Emergencia</span></a></li>
		   <li><a href='ListAdmissionsServlet'><span>Admisi&oacute;n</span></a></li>
		   <li><a href='ListHospitalizationsServlet'><span>Hospitalizaci&oacute;n</span></a></li>
		   <li class='has-sub'>
			<a href='#'><span>Tratamientos M&eacute;dicos</span></a>
		      <ul>
		         <li class='first'><a href='ListMedicalTreatmentsAdminServlet'><span>Administrar</span></a></li>
		         <li class='last'><a href='ListMedicalTreatmentsServlet'><span>Ver Pacientes</span></a></li>
		      </ul>
		   </li>
		   <li><a href='ListUsersServlet'><span>Usuarios</span></a></li>
		   <li><a href='ListProtocolsServlet'><span>Protocolos</span></a></li>
		   <li><a href='ListXRayReportsServlet'><span>Rayos X</span></a></li>
		   <li class='has-sub'>
			<a href='#'><span>Farmacia</span></a>
		      <ul>
		         <li class='first'><a href='ListSupplyAreasServlet'><span>Administrar</span></a></li>
		         <li class='last'><a href='ListSupplyServlet'><span>Ver Pacientes</span></a></li>
		      </ul>
		   </li>
		   <li class='has-sub'>
			<a href='#'><span>Facturaci&oacute;n</span></a>
		      <ul>
		         <li class='first'><a href='ListBillingsHServlet'><span>Honorarios M&eacute;dicos</span></a></li>
		         <li><a href='ListBillingsRPServlet'><span>Relaci&oacute;n de Pago</span></a></li>
		         <li><a href='ListBillingsNServlet'><span>Generar N&oacute;mina</span></a></li>
		         <li class='last'><a href='ListBillingsPPServlet'><span>Pronto Pago</span></a></li>
		      </ul>
		   </li>
		   <li><a href='ListUnitsServlet'><span>Unidades</span></a></li>
		   <li><a href='ListSpecialistsServlet'><span>Especialistas</span></a></li>
		   <li><a href='ListPaymentResponsiblesServlet'><span>Responsables de Pago</span></a></li>
		   <li><a href='ListCashBoxesServlet'><span>Cajas</span></a></li>
		   <li><a href='ListAccountsServlet'><span>Cuentas Pendientes</span></a></li>
		   <li><a href='ListBloodBankServlet'><span>Banco de Sangre</span></a></li>
		   <li><a href='ListEcoServlet'><span>Ecosonograf&iacute;a</span></a></li>
		   <li><a href='ListLabServlet'><span>Laboratorio</span></a></li>
		   <li class='last'><a href='ListInterServlet'><span>Interconsultas</span></a></li>
		</ul>
		</div>
		<iframe class="help" src="./help2.jsp" width="500" height="600"></iframe>
	</body>
	<style>
		.menu-help{
			width: 213px;
			background: whitesmoke;
			margin-left: 0px;
			margin-top: 0px;
			height: 100%;
		}
		
		.help{
			position: absolute;
			top: 0px;
			left: 213px;
			width: 485px;
			height: 100%;
		}
	</style>
</html>