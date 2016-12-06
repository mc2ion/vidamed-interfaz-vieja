<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="domain.Protocol"%>
<%@page import="domain.Cost"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Specialist"%>
<%@page import="domain.Admission"%>
<%
Admission admission = (Admission) request.getAttribute("admission");
Specialist e = admission.getSpecialist();

@SuppressWarnings("unchecked")
ArrayList<Cost> c = (ArrayList<Cost>)  request.getAttribute("costs");

@SuppressWarnings("unchecked")
ArrayList<Protocol> p = (ArrayList<Protocol>) request.getAttribute("protocols");
			
String admisionID 	= (String) request.getAttribute("admissionID");
String estimationID = (String) request.getAttribute("estimationID");

Locale spanish = new Locale("es","ES");
NumberFormat format = NumberFormat.getNumberInstance(spanish);
			

DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
DateFormat hourFormat = new SimpleDateFormat("hh:mm:ss a");
Date date = new Date();
String dateTxt = dateFormat.format(date);

			
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Imprimir Admisión</title>	
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
		<style type="text/css">
		#especial{
			background-image:url(null);
			margin-left: 10%;
			margin-right: 10%;
		}
		input{
			border: none;
		}
		
		label, span {
			font-weight: bold;
		}
		</style>
	<script > 
	<!-- 
	
	function inhabilitar(){ 
	   	return false;
	} 
	
	document.oncontextmenu=inhabilitar;
	
	// --> 
	</script>
</head>
	<body id="especial">
		<div id="printHeader" class="header">
			<div style="width:100%;float:left;text-align:right;"><b>Fecha:</b><%= dateTxt %>
		</div>       	
        </div>  
		<br><br><br>
		<div id="title" style="font-size:14px; font-weight: bold;text-align:center;"> ADMISION # <%= admisionID%></div>
		<br>
		<h3 style="text-decoration:underline;">Datos Paciente</h3><br/>
		<fieldset>
			<b style="display:inline-block; width: 250px; margin-bottom:3px">Cédula de Identidad: </b><%= admission.getIdentityCard() %><br>
			<b style="display:inline-block; width: 250px; margin-bottom:3px">Nombres y Apellidos:</b><%= admission.getFirstName() + " " + admission.getLastName()  %><br>
			<b style="display:inline-block; width: 250px; margin-bottom:3px">Tipo Paciente:</b><%= (admission.getIsAdult() == 1) ? "Adulto": "Pediátrico"  %><br>
			<b style="display:inline-block; width: 250px; margin-bottom:3px">Responsable del Pago:</b><%= admission.getResponsibleName()  %><br>				
			<b style="display:inline-block; width: 250px; margin-bottom:3px">Motivo de Admisión:</b><%= admission.getObservation()  %><br>
			<b style="display:inline-block; width: 250px; margin-bottom:3px">Ubicación:</b><%= admission.getReasonName() %><br>
		</fieldset>
		<br>
		<br>
		<div id="title" style="font-size:16px; font-weight: bold; text-decoration:underline;"> Presupuesto Asociado n° <%= estimationID %> </div>
		<br>
		<fieldset>
			<b style="display:inline-block; width: 250px; margin-bottom:3px">Médico Tratante:</b><%= e.getFirstName() + " " + e.getLastName() %><br>
			<b style="display:inline-block; width: 250px; margin-bottom:3px">Unidad:</b><%= e.getUnitName() %><br><br>
		</fieldset>
		<br>
		<h3>Protocolos Asociados</h3><br/>
		<table id="sweetTable"> 
			<tbody>
				<tr>
					<th> Protocolo</th>
					<th> Dignóstico</th>
				</tr>
			<% for (int i = 0; i < p.size(); i++){ %>
			<tr>
				<td> <%= p.get(i).getName() %></td>
				<td> <%= (p.get(i).getDiagnosis() != null) ? p.get(i).getDiagnosis() : "N/A" %></td>
			</tr>
			<% } %>
			</tbody>
		</table>
		<br/><br/><br/>
		<h3>Servicios Asociados</h3><br/>
		<table id="sweetTable">
			<tbody>
				<tr>
					<th>Servicio</th>
					<th>Precio</th>
				</tr>	
				<% 
				double costTotal = 0.0;
				for (int i = 0; i < c.size(); i++){ 
					if (c.get(i).getCost() != null) {
						costTotal  += Double.valueOf(c.get(i).getCost());
				%>
				<tr>
					<td> <%= c.get(i).getName() %></td>
					<td> Bs <%= format.format(Double.valueOf(c.get(i).getCost())) %></td>
				</tr>
				<% 
				}
				} %>
				<tr id="totalTr">
					<td>*** MONTO TOTAL ***</td>
					<td>Bs <%= format.format(costTotal) %></td>
				</tr>
			</tbody>
			</table>	
		
		<br>
		<div style="text-align:center;font-weight:bold;font-size:11px;">CENTRO MÉDICO QUIRÚRGICO VIDAMED		
		<br>Departamento Administrativo</div>		
		<div id="botonera">
				<form onsubmit="printPageContentB();" style="display:inline-block;">
				<div id="botonP">
							<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" style="margin-left:30%;" onclick="printPageContentB();unPrintPageContentB();return false" />
				</div>	
				</form>
				<form style="display:inline-block;">
					<div id="botonV">
							<input type="button" class="button" value="Regresar"  onClick="javascript:history.back();" style="margin-left:40%;" />		
					</div>	
				</form>
			</div>		
	</body>
</html>