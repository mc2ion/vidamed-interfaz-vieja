<%@page import="java.util.ArrayList"%>
<%@page import="domain.MedicalFee"%>
<%@page import="domain.Specialist"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
ArrayList<MedicalFee> mf = (ArrayList<MedicalFee>)request.getAttribute("mf");
ArrayList<MedicalFee> totals = (ArrayList<MedicalFee>)request.getAttribute("totals");
SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
Date date = new Date();
String dateTxt = dateFormat.format(date);
String function = (String)request.getAttribute("function");
String backUrl = "./ListBillingsHServlet";

if (function != null && function.equals("pendingPayments"))
	backUrl = "./ListPendingPaymentsServlet";
%>

<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<style type="text/css">
			body {
				font-size: 12px;
			    width: 90%;
			    margin: 0 auto;
			}
			.right {
				text-align: right;
			}
			.title {
				font-size: 14px;
			    font-weight: bold;
			    text-align: center;
			}
			hr {
			    background-color: black;
			    height: 1px;
			}
			table {
			    width: 100%;
			    border-collapse: collapse;
			}
			td, th {
				border: 1px solid #006c92;
			    padding: 1px 7px 1px 7px;
			    /*font-size: 10px;*/
			    vertical-align: top;
			}
			th {
				background-color: #006c92;
				color: white;
				font-weight: bold;
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
    			vertical-align: super;
			}
			.pagebreak {
				page-break-before: always;
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
		Specialist s = null;
		Long sId = 0L;
		int i = 0;
		for(MedicalFee fee : mf){
			s = fee.getSpecialist();

			if(!sId.equals(s.getId())) {
				if(sId != 0) {
	%>
				<tr>
					<td colspan="5"></td>
					<td colspan="2" class="bold right"><%= totals.get(i).getAmount() %></td>
					<td class="bold right"><%= totals.get(i).getRetentionAmount() %></td>
					<td class="bold right"><%= totals.get(i).getFinalAmount() %></td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<td colspan="3" class="bold">I.S.L.R.</td>
					<td class="right"><%= totals.get(i).getIslr() %></td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<td colspan="3" class="bold">TOTAL A COBRAR:</td>
					<td class="bold right"><%= totals.get(i).getTotal() %></td>
				</tr>
			</tbody>
		</table>
		<div class="pagebreak"></div>
	<%
					i++;
				}
	%>
		<br>
		<div class="right"><label class="bold">Fecha: </label> <%= dateTxt %></div>
		<br><br><br>
		<div class="title">RELACI&Oacute;N DE HONORARIOS M&Eacute;DICOS</div>
		<hr>
		<br><br><br>
		<div><label class="bold">DR(A)</label> <%= s.getFirstName() + ' ' + s.getLastName() %></div>
		<br><br>
		<table>
			<thead>
				<tr>
					<th>Fecha</th>
					<th>Factura</th>
					<th>Nombre del Paciente</th>
					<th>Nombre del Seguro</th>
					<th>Unidad de Negocio</th>
					<th>Honorarios</th>
					<th>% de Retenci&oacute;n</th>
					<th>Gastos Administrativos</th>
					<th>Monto a Pagar</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%= fee.getDischargeDate() %></td>
					<td><%= fee.getBill().getCreditNoteID() %></td>
					<td><%= fee.getPatientName() %></td>
					<td><%= fee.getPaymentResponsibleName() %></td>
					<td><%= fee.getReasonName() %></td>
					<td class="right"><%= fee.getAmount() %></td>
					<td class="right"><%= fee.getRetentionRate() %></td>
					<td class="right"><%= fee.getRetentionAmount() %></td>
					<td class="right"><%= fee.getFinalAmount() %></td>
				</tr>
	<%
			} else {
	%>
				<tr>
					<td><%= fee.getDischargeDate() %></td>
					<td><%= fee.getBill().getCreditNoteID() %></td>
					<td><%= fee.getPatientName() %></td>
					<td><%= fee.getPaymentResponsibleName() %></td>
					<td><%= fee.getReasonName() %></td>
					<td class="right"><%= fee.getAmount() %></td>
					<td class="right"><%= fee.getRetentionRate() %></td>
					<td class="right"><%= fee.getRetentionAmount() %></td>
					<td class="right"><%= fee.getFinalAmount() %></td>
				</tr>
	<%				
			}
			
			sId = s.getId();
		} 
	%>
				<tr>
					<td colspan="5"></td>
					<td colspan="2" class="bold right"><%= totals.get(i).getAmount() %></td>
					<td class="bold right"><%= totals.get(i).getRetentionAmount() %></td>
					<td class="bold right"><%= totals.get(i).getFinalAmount() %></td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<td colspan="3" class="bold">I.S.L.R.</td>
					<td class="right"><%= totals.get(i).getIslr() %></td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<td colspan="3" class="bold">TOTAL A COBRAR:</td>
					<td class="bold right"><%= totals.get(i).getTotal() %></td>
				</tr>
			</tbody>
		</table>
		<div class="pagebreak"></div>
		<div id="botonera">
			<form onsubmit="printPageContentB();">
			<div id="botonP" style="display:inline-block;">
						<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" style="margin-left:30%;" onclick="printPageContentB();unPrintPageContentB();return false" />
			</div>	
			<div id="botonV" style="display:inline-block;">
						<a class="button" href="<%= backUrl %>" style="margin-left:40%;">Regresar</a>		
			</div>	
			</form>
		</div>
	</body>
</html>