<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormat"%>
<%@page import="domain.Admission"%>
<%@page import="domain.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.AdmissionPaymentResponsible"%>
<%
Admission admission = (Admission)request.getAttribute("admission");
DateFormat datehourFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
DateFormat dateFormat = new SimpleDateFormat("'Caracas,' dd 'de' MMMMM 'de' yyyy", new Locale("ES"));
Date date = datehourFormat.parse(admission.getDischargeDate());
String dateTxt = dateFormat.format(date);
String patient = admission.getFirstName()+" "+admission.getLastName();
String identityCard = admission.getIdentityCard();
String billID = (String)request.getAttribute("factId");
Long admissionID = admission.getAdmissionID();
String total = admission.getTotal();
String patientPayment = admission.getPatientPayment();
User user = (User)request.getAttribute("user");
String userName = user.getFirstName()+" "+user.getLastName();
ArrayList<AdmissionPaymentResponsible> responsibles = (ArrayList<AdmissionPaymentResponsible>)request.getAttribute("responsibles");
%>

<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<style type="text/css">
			body {
				font-style: italic;
				font-size: 12px;
			    width: 90%;
			    margin: 0 auto;
			}
			.right {
				text-align: right;
			}
			.col-6 div {
				width: 49%;
				display: inline-table; 
			}
			.col-4 div {
				width: 33%;
				display: inline-table; 
				vertical-align: middle;
			}			
			.col-4 div > div {
				width: 12px;
				height: 12px;
				border: 2px solid black;
				margin-right: 10px;
			}			
			.center {
				text-align: center;
			}
			.text {
				width: 83%;
			}
			.bold {
				font-weight: bold;
			}
			.uppercase {
				text-transform: uppercase;
			}
			.super {
				font-size: 10px;
    			vertical-align: super
			}
			#botonera {
				text-align: center;
    			padding: 20px 0;
    		}
			.button {
				-moz-box-shadow:inset 0px 0px 0px 0px #bee2f9;
				-webkit-box-shadow:inset 0px 0px 0px 0px #bee2f9;
				box-shadow:inset 0px 0px 0px 0px #bee2f9;
				background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #63b8ee), color-stop(1, #468ccf) );
				background:-moz-linear-gradient( center top, #63b8ee 5%, #468ccf 100% );
				filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#63b8ee', endColorstr='#468ccf');
				background-color:#63b8ee;
				-webkit-border-top-left-radius:0px;
				-moz-border-radius-topleft:0px;
				border-top-left-radius:0px;
				-webkit-border-top-right-radius:0px;
				-moz-border-radius-topright:0px;
				border-top-right-radius:0px;
				-webkit-border-bottom-right-radius:0px;
				-moz-border-radius-bottomright:0px;
				border-bottom-right-radius:0px;
				-webkit-border-bottom-left-radius:0px;
				-moz-border-radius-bottomleft:0px;
				border-bottom-left-radius:0px;
				text-indent:0;
				border:1px solid #3866a3;
				display:inline-block;
				color: #14396a !important;
				font-family:Arial;
				font-size:15px;
				font-weight:bold;
				font-style:normal;
				padding: 8px;
				text-decoration:none;
				text-align:center;
				text-shadow:1px 1px 0px #7cacde;
			}
			.button:hover {
				background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #468ccf), color-stop(1, #63b8ee) );
				background:-moz-linear-gradient( center top, #468ccf 5%, #63b8ee 100% );
				filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#468ccf', endColorstr='#63b8ee');
				background-color:#468ccf;
			}
		</style>
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
	</head>
	<body>
	<%
		for(AdmissionPaymentResponsible responsible : responsibles){
			String info = (responsible.getGuaranteeLetter()!= null)?responsible.getGuaranteeLetter():"";
			
			if(info==""){
				info+=(responsible.getKeyNumber()!=null)?responsible.getKeyNumber():"";
			} else {
				info+=(responsible.getKeyNumber()!=null)?" / "+responsible.getKeyNumber():"";
			}
	%>
		<br>
		<div class="right"><%= dateTxt %></div>
		<br><br><br>
		<div>SE&Nacute;ORES:</div>
		<div><span class="super">SEG.</span> <span class="uppercase bold"><%= responsible.getPaymentResponsibleName() %></span></div>
		<br><br><br>
		<div>Por medio de la presente les estamos enviando documentaci&oacute;n correspondiente al caso Nro. <span class="bold"><%= admissionID %></span></div>
		<br><br><br>
		<div>PACIENTE:</div>
		<div class="uppercase bold"><%= patient %></div>
		<br>
		<div>CEDULA Nº:</div>
		<div class="bold"><%= identityCard %></div>
		<br>
		<div class="col-6">
			<div>CARTA AVAL/CLAVE Nº:</div>
			<div>POLIZA Nº:</div>
		</div>
		<div class="col-6">
			<div class="bold"><%= info %></div>
			<div></div>
		</div>
		<br><br>
		<div class="col-6">
			<div>FACTURA ORIGINAL:</div>
			<div>MONTO FACTURADO: <span class="bold"><%= total %></span></div>
		</div>
		<br>
		<div class="col-6">
			<div class="bold"><%= billID %></div>
			<div>COBERTURA: <span class="bold"><%= responsible.getCoverageAmount() %></span></div>
		</div>
		<br>
		<div class="col-6">
			<div></div>
			<div>A PAGAR PACIENTE: <span class="bold"><%= patientPayment %></span></div>
		</div>
		<br>
		<div>SE ANEXA:</div>
		<div class="col-4">
			<div><div></div> Banco de Sangre</div>
			<div><div></div> Ecosonogramas</div>
			<div><div></div> Planilla de Siniestro</div>
		</div>
		<div class="col-4">
			<div><div></div> Carta Aval</div>
			<div><div></div> Electrocardiograma</div>
			<div></div>
		</div>
		<div class="col-4">
			<div><div></div> Carta Narrativa</div>
			<div><div></div> Ex&aacute;menes de Laboratorio</div>
			<div></div>
		</div>
		<div class="col-4">
			<div><div></div> Clave de Egreso</div>
			<div><div></div> Informe de Biopsia</div>
			<div></div>
		</div>
		<div class="col-4">
			<div><div></div> Clave de Ingreso</div>
			<div><div></div> Informe de M&eacute;dico</div>
			<div></div>
		</div>
		<div class="col-4">
			<div><div></div> Desglose de gastos Materiales y Medicamentos</div>
			<div><div></div> Informe de Rayos X</div>
			<div></div>
		</div>
		<br><br><br><br>
		<div class="text">Agradecemos emitir cheque en un plazo no mayor de treinta (30) d&iacute;as a partir de la fecha de recepci&oacute;n, a nombre de CENTRO MEDICO QUIRURGICO VIDAMED, sin m&aacute;s que hacer referencia.</div>
		<br><br>
		<div>Agradecemos firmar y sellar esta hoja como Acuse de Recibo.</div>
		<br><br><br><br>
		<div class="center">Atentamente,</div>
		<br>
		<div class="center">POR <span class="bold">CENTRO MEDICO QUIRURGICO VIDAMED</span></div>
		<br><br><br><br>
		<div><span class="bold">Elaborado por: </span><span class="uppercase"><%= userName %></span></div>
		<%
		} 
		%>
		<div id="botonera">
			<form onsubmit="printPageContentB();">
			<div id="botonP" style="display:inline-block;">
						<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" style="margin-left:30%;" onclick="printPageContentB();unPrintPageContentB();return false" />
			</div>	
			<div id="botonV" style="display:inline-block;">
						<input type="button" class="button" value="Regresar"  onClick="javascript:history.back();" style="margin-left:40%;" />		
			</div>	
			</form>
		</div>
	</body>
</html>