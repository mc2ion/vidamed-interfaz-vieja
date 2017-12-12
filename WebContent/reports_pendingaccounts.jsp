<%@page import="java.util.ArrayList"%>
<%@page import="domain.PaymentResponsible"%>
<%@page import="domain.PendingAccounts"%>
<%@page import="domain.User"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.concurrent.TimeUnit" %>
<%
User user = (User) session.getAttribute("user");
String name = "";
if (user != null)
	name = user.getFirstName() ;

@SuppressWarnings("unchecked")
ArrayList<PaymentResponsible> resp = (ArrayList<PaymentResponsible>)request.getAttribute("pr");

ArrayList<PendingAccounts> pp = (ArrayList<PendingAccounts>)request.getAttribute("pp");

Long paymentresponsibleid = (Long)request.getAttribute("paymentresponsibleid");
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
			<h2>Reporte An&aacute;lisis Vencimiento Detallado</h2>
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
									<option value="17" selected>An&aacute;lisis Vencimiento</option>
									<option value="18" >Relaci&oacute;n de Facturaci&oacute;n</option>
									<option value="19" >An&aacute;lisis Vencimiento Resumido</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="PendingAccountsReportServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Responsable de Pago:</b></td>
									<td>
										<select name="paymentresponsibleid" id="paymentresponsibleid">
											<option value="-">Seleccionar</option>
											<% for (int i = 0; i < resp.size(); i++){
												PaymentResponsible p = resp.get(i);
												String info = p.getName();
											
												if (p.getId() == paymentresponsibleid){
											%>
											<option value="<%= p.getId()%>" selected> <%= info %></option>
											<%  } else { %>
											<option value="<%= p.getId()%>"> <%= info %></option>
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
											<th>N° Factura</th>
											<th>Fecha</th>
											<th>Paciente</th>
											<th>CI Paciente</th>
											<th>CI Titular P&oacute;liza</th>
											<th>Carta</th>
											<th>Facturado</th>
											<th>Cobertura Seguro</th>
											<th>Monto Abonado</th>
											<th>Monto Pendiente Seguro</th>
											<th>Fecha Recepci&oacute;n</th>
											<th>0 - 30</th>
											<th>30 - 60</th>
											<th>60 - 90</th>
											<th>M&aacute;s de 90</th>
										</tr>
									</thead>
									<tbody>		
									<% 	if (pp != null && pp.size() > 0 ){
											for (int i = 0; i < pp.size(); i++){ 
											PendingAccounts u = pp.get(i); 
											SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
											Date deliveryDate = format.parse(u.getDeliveryDate());
											Date today = new Date();
											long difference = today.getTime() - deliveryDate.getTime();
											Long days = TimeUnit.DAYS.convert(difference, TimeUnit.MILLISECONDS);
									%>
										<tr>
											<td><%= u.getBillID() %></td>
											<td><%= u.getDischargeDate() %></td>
											<td><%= u.getPatientName() %></td>
											<td><%= u.getPatientIdentityCard() %></td>
											<td><%= u.getPolicyHolderIdentityCard() %></td>
											<td><%= u.getGuaranteeLetter() %></td>
											<td><%= u.getTotalBill() %></td>
											<td><%= (u.getTotal()==null)?"":u.getTotal() %></td>
											<td><%= (u.getTotalPaid()==null)?"":u.getTotalPaid() %></td>
											<td><%= (u.getTotalPending()==null)?"":u.getTotalPending()  %></td>
											<td><%= u.getDeliveryDate() %></td>
											<td><%= (days <= 30)?"x":"" %></td>
											<td><%= (days > 30 && days <= 60)?"x":"" %></td>
											<td><%= (days > 60 && days <= 90)?"x":"" %></td>
											<td><%= (days > 90)?"x":"" %></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="15" style="text-align: center;">No hay datos disponibles</td></tr>
									
									<% } %>	
									</tbody>
								</table>
							</div>
					</div>
				</div>
				<div class="spacer"></div>
       		</div>
		</div>
	</body>
</html>