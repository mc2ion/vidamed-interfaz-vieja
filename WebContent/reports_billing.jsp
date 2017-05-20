<%@page import="java.util.ArrayList"%>
<%@page import="domain.Invoice"%>
<%@page import="domain.User"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.concurrent.TimeUnit" %>
<%@page import="java.util.Calendar" %>
<%
User user = (User) session.getAttribute("user");
String name = "";
if (user != null)
	name = user.getFirstName() ;

ArrayList<Invoice> pp = (ArrayList<Invoice>)request.getAttribute("pp");
ArrayList<Invoice> subtotals = (ArrayList<Invoice>)request.getAttribute("subtotals");
ArrayList<Invoice> totals = (ArrayList<Invoice>)request.getAttribute("totals");
ArrayList<Invoice> total = (ArrayList<Invoice>)request.getAttribute("total");
ArrayList<Invoice> footer = (ArrayList<Invoice>)request.getAttribute("footer");

Integer monthid = (Integer)request.getAttribute("monthid");
Integer yearid = (Integer)request.getAttribute("yearid");

String months[] = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Reportes</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	<script src="./js/jquery-1.9.1.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
	<script type="text/javascript">
	var idUser;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2) {
		console.log('pase por aca');
		idUser = var1;
		$('.cliente').text(var2);
		$('#admId').attr('value', var1);
		$('#factId').attr('value', var2);			
	};
	
	function setV(f){
		//f.elements['userId'].value = idUser;
		return true;
	};
	
	function formatSelected(f){
		var opt = $('#formats').val();
		$('#printForm').attr('action', opt);
		return true;
	};
	</script>
	<style>
		fieldset input[type="text"]{ width: 75%;}
	</style>
	</head>
<body>
	<div id="container">
		<div id="header">
        	
        </div>         
      	<jsp:include page="./upperMenu.jsp" />        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
			<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content" style="min-height: 600px;">  
			<h2>Reporte Relaci&oacute;n de Facturaci&oacute;n</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoja el módulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								    <option value="0">Seleccionar</option>
									<option value="1" >Usuarios</option>
									<option value="2" >Especialistas</option>
									<option value="3" >Responsables de Pago</option>
									<option value="4" >Farmacia - Admin</option>
									<option value="5" >Farmacia - Pacientes</option>
									<option value="6" >Banco de Sangre</option>
									<option value="7" >Ecosonografía</option>
									<option value="8" >Rayos X</option>
									<option value="9" >Laboratorio</option>
									<option value="10" >Interconsultas</option>
									<option value="11" >Descuentos</option>
									<option value="12" >Facturas</option>
									<option value="13" >Admisión</option>
									<option value="14" >Honorarios Médicos</option>
									<option value="15" >Libro de Ventas</option>
									<option value="16" >Facturación detallada</option>
									<option value="17" >An&aacute;lisis Vencimiento</option>
									<option value="18" selected>Relaci&oacute;n de Facturaci&oacute;n</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="BillingReportServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Mes:</b></td>
									<td>
										<select name="monthid" id="monthid" required>
											<option value="">Seleccionar</option>
											<%
												for(int i = 0; i < 12; i++){
													Integer month = i + 1;
													
													if (month == monthid){
											%>
											<option value="<%= month %>" selected><%= months[i] %></option>
											<%
													} else {
											%>
											<option value="<%= month %>"><%= months[i] %></option>
											<%		
													}
												}
											%>
										</select>
									</td>
									<td><b>A&nacute;o:</b></td>	
									<td>
										<select name="yearid" id="yearid" required>
											<option value="">Seleccionar</option>
											<% 
											int currentyear = Calendar.getInstance().get(Calendar.YEAR);
											
											for (Integer i = 2016; i <= currentyear; i++){
											
												if (i.equals(yearid)){
											%>
											<option value="<%= i %>" selected> <%= i %></option>
											<%  } else { %>
											<option value="<%= i %>"> <%= i %></option>
											<%  } 
											}
											%>
										</select>
									</td>
								</tr>
							</table>	
							<input type="submit" class="buttonGreen lessPadding"   style="float: right; margin-right:40px; margin-top: 5px;" value="Buscar">
							</fieldset>
  						</div>	
  						</form>
  						<div id="demo" style="display: block; height: 300px; overflow-y: scroll; margin-top:10px;">
								<table id="sweetTable" >
									<thead>
										<tr>
											<th>N° Caso</th>
											<th>N° Factura</th>
											<th>Total Factura</th>
											<th>Saldo Seguro</th>
											<th>Cl&iacute;nica</th>
											<th>Honorarios M&eacute;dicos</th>
											<th>Cobrado</th>
											<th>Descuento</th>
										</tr>
									</thead>
									<tbody>		
									<% 	if (pp != null && pp.size() > 0 ){
											Long pr = null, r = null;
											int st = 0, t = 0;
											String rname = "", prname = "";
										
											for (int i = 0; i < pp.size(); i++){ 
											Invoice u = pp.get(i); 
											
											if(!u.getPaymentResponsibleID().equals(pr)){
												if(pr != null){
									%>
										<tr>
											<td colspan="2" style="font-weight:bold;">TOTAL POR <%= rname %></td>
											<td><%= subtotals.get(st).getTotal() %></td>
											<td><%= (subtotals.get(st).getCoverageAmount() == null)? 0.00 : subtotals.get(st).getCoverageAmount() %></td>
											<td><%= subtotals.get(st).getClinicTotal() %></td>
											<td><%= subtotals.get(st).getProfessionalFees() %></td>
											<td><%= subtotals.get(st).getCoverageTotalPaid() %></td>
											<td><%= subtotals.get(st).getDiscount() %></td>
										</tr>
										<tr>
											<td colspan="2" style="font-weight:bold;">TOTAL <%= prname %></td>
											<td><%= totals.get(t).getTotal() %></td>
											<td><%= (totals.get(t).getCoverageAmount() == null)? 0.00 : totals.get(t).getCoverageAmount() %></td>
											<td><%= totals.get(t).getClinicTotal() %></td>
											<td><%= totals.get(t).getProfessionalFees() %></td>
											<td><%= totals.get(t).getCoverageTotalPaid() %></td>
											<td><%= totals.get(t).getDiscount() %></td>
										</tr>
									<%				
													st++;
													t++;
												}
									%>
										<tr>
											<td colspan="8" style="font-weight:bold;"><%= u.getPaymentResponsibleName() %></td>
										</tr>
										<tr>
											<td colspan="8" style="font-weight:bold;"><%= u.getReasonName() %></td>
										</tr>
									<%
											} else {
												if(!r.equals(u.getReasonID())){
									%>
										<tr>
											<td colspan="2" style="font-weight:bold;">TOTAL POR <%= rname %></td>
											<td><%= subtotals.get(st).getTotal() %></td>
											<td><%= (subtotals.get(st).getCoverageAmount() == null)? 0.00 : subtotals.get(st).getCoverageAmount() %></td>
											<td><%= subtotals.get(st).getClinicTotal() %></td>
											<td><%= subtotals.get(st).getProfessionalFees() %></td>
											<td><%= subtotals.get(st).getCoverageTotalPaid() %></td>
											<td><%= subtotals.get(st).getDiscount() %></td>
										</tr>
										<tr>
											<td colspan="8" style="font-weight:bold;"><%= u.getReasonName() %></td>
										</tr>
										<%
													st++;
												}
											}
									%>
										<tr>
											<td><%= u.getAdmissionID() %></td>
											<td><%= u.getBillID() %></td>
											<td><%= u.getTotal() %></td>
											<td><%= (u.getCoverageAmount()== null)? 0.00 : u.getCoverageAmount() %></td>
											<td><%= u.getClinicTotal() %></td>
											<td><%= u.getProfessionalFees() %></td>
											<td><%= u.getCoverageTotalPaid() %></td>
											<td><%= u.getDiscount() %></td>
										</tr>
									<% 		

												pr = u.getPaymentResponsibleID();
												r = u.getReasonID();
												rname = u.getReasonName();
												prname = u.getPaymentResponsibleName();
												System.out.println("+++"+i+". pr:"+pr+", prname:"+prname+", r:"+r+", rname:"+rname);
											}
									%>
										<tr>
											<td colspan="2" style="font-weight:bold;">TOTAL POR <%= rname %></td>
											<td><%= subtotals.get(st).getTotal() %></td>
											<td><%= (subtotals.get(st).getCoverageAmount() == null)? 0.00 : subtotals.get(st).getCoverageAmount() %></td>
											<td><%= subtotals.get(st).getClinicTotal() %></td>
											<td><%= subtotals.get(st).getProfessionalFees() %></td>
											<td><%= subtotals.get(st).getCoverageTotalPaid() %></td>
											<td><%= subtotals.get(st).getDiscount() %></td>
										</tr>
										<tr>
											<td colspan="2" style="font-weight:bold;">TOTAL <%= prname %></td>
											<td><%= totals.get(t).getTotal() %></td>
											<td><%= (totals.get(t).getCoverageAmount() == null)? 0.00 : totals.get(t).getCoverageAmount() %></td>
											<td><%= totals.get(t).getClinicTotal() %></td>
											<td><%= totals.get(t).getProfessionalFees() %></td>
											<td><%= totals.get(t).getCoverageTotalPaid() %></td>
											<td><%= totals.get(t).getDiscount() %></td>
										</tr>
										<tr>
											<td colspan="2" style="font-weight:bold;">TOTAL GENERAL</td>
											<td><%= total.get(0).getTotal() %></td>
											<td><%= (total.get(0).getCoverageAmount() == null)? 0.00 : total.get(0).getCoverageAmount() %></td>
											<td><%= total.get(0).getClinicTotal() %></td>
											<td><%= total.get(0).getProfessionalFees() %></td>
											<td><%= total.get(0).getCoverageTotalPaid() %></td>
											<td><%= total.get(0).getDiscount() %></td>
										</tr>
									<%
										}else{									
									%>
										<tr><td colspan="12" style="text-align: center;">No hay datos disponibles</td></tr>
									
									<% } %>	
									</tbody>
								</table><br><br><br>
								<% 	
								if (pp != null && pp.size() > 0 ){
								%>
								<table class="sweetTable">
									<thead>
										<tr>
											<th><%= footer.get(0).getBillsAmount() %> Casos Facturados</th>
											<th><%= footer.get(1).getBillsAmount() %> Casos Cobrados Totalmente</th>
											<th><%= footer.get(2).getBillsAmount() %> Casos Cobrados Parcial</th>
											<th><%= footer.get(3).getBillsAmount() %> Casos Pendientes Por Cobrar</th>
											<th><%= footer.get(4).getBillsAmount() %> Casos Con Descuento</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><%= footer.get(0).getTotal() %></td>
											<td><%= footer.get(1).getTotal() %></td>
											<td><%= footer.get(2).getTotal() %></td>
											<td><%= footer.get(3).getTotal() %></td>
											<td><%= footer.get(4).getTotal() %></td>
										</tr>
									</tbody>
								</table><br><br><br>
								<div>*Porcentaje de Cobranzas: <%= footer.get(5).getTotal() %></div>
								<%
								}
								%>
							</div>
					</div>
				</div>
				<div class="spacer"></div>
       		</div>
		</div>
	</body>
</html>