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
		   <li class='first'><a href='help_estimation.jsp' target="main"><span>Presupuesto</span></a></li>
		   <li><a href='help_emergency.jsp' target="main"><span>Emergencia</span></a></li>
		   <li><a href='help_admission.jsp' target="main"><span>Admisi&oacute;n</span></a></li>
		   <li><a href='help_hospitalization.jsp' target="main"><span>Hospitalizaci&oacute;n</span></a></li>
		   <li><a href='help_medicalTreatment.jsp' target="main"><span>Tratamientos M&eacute;dicos</span></a></li>
		   <li><a href='help_users.jsp' target="main"><span>Usuarios</span></a></li>
		   <li><a href='help_protocol.jsp' target="main"><span>Protocolos</span></a></li>
		   <li><a href='help_rayX.jsp' target="main"><span>Rayos X</span></a></li>
		   <li><a href='help_pharmacy.jsp' target="main"><span>Farmacia</span></a></li>
		   <li><a href='help_HM.jsp' target="main"><span>Honorarios M&eacute;dicos</span></a></li>
		   <li><a href='help_RP.jsp' target="main"><span>Relaci&oacute;n de Pago</span></a></li>
		   <li><a href='help_GN.jsp' target="main"><span>Generar N&oacute;mina</span></a></li>
		   <li><a href='help_PP.jsp' target="main"><span>Pronto Pago</span></a></li>
		   <li><a href='help_units.jsp' target="main"><span>Unidades</span></a></li>
		   <li><a href='help_spec.jsp' target="main"><span>Especialistas</span></a></li>
		   <li><a href='help_paymentR.jsp' target="main"><span>Responsables de Pago</span></a></li>
		   <li><a href='help_cashBox.jsp' target="main"><span>Cajas</span></a></li>
		   <li><a href='help_account.jsp' target="main"><span>Cuentas por Cobrar</span></a></li>
		   <li><a href='help_bloodB.jsp' target="main"><span>Banco de Sangre</span></a></li>
		   <li><a href='help_eco.jsp' target="main"><span>Ecosonograf&iacute;a</span></a></li>
		   <li><a href='help_lab.jsp' target="main"><span>Laboratorio</span></a></li>
		   <li><a href='help_discharge_admission.jsp' target="main"><span>Altas Admisión</span></a></li>
		   <li><a href='help_pending_creditNotes.jsp' target="main"><span>Prefacturas por Generar</span></a></li>
		   <li><a href='help_pending_creditNotesReview.jsp' target="main"><span>Prefacturas por Revisar</span></a></li>
		   <li><a href='help_pending_invoices.jsp' target="main"><span>Facturas por Generar</span></a></li>
		   <li><a href='help_pending_requests.jsp' target="main"><span>Descuentos</span></a></li>
		   <li><a href='help_discharge_pharmacy.jsp' target="main"><span>Altas Farmacia</span></a></li>
		   <li><a href='help_pending_payments.jsp' target="main"><span>Honorarios por Pagar</span></a></li>
		</ul>
		</div>
		<iframe class="help"  name="main" id="main"  src="./helpIni.jsp" style="width:700px; height:600px;"></iframe>
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