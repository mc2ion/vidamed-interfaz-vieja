<%@page import="sun.font.EAttribute"%>
<%@page import="domain.PendingBills"%>
<%@page import="domain.Admission"%>
<%@ page import="domain.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	int modSelect = 0;
	String modId = (String) request.getAttribute("modId");
	if (modId != null && !modId.equals(""))
		modSelect = Integer.valueOf(modId);
	
	@SuppressWarnings("unchecked")
	ArrayList<PendingBills> mfList = (ArrayList<PendingBills>)request.getAttribute("pp");
	
	String billid 					= (String) request.getAttribute("billid");
	String estimationid 			= (String)request.getAttribute("estimationid");
	String paymentresponsiblename 	= (String)request.getAttribute("paymentresponsiblename");
	String wasgenerated 			= (String)request.getAttribute("wasgenerated");
	String generationfrom 			= (String)request.getAttribute("generationfrom");
	String generationto 			= (String)request.getAttribute("generationto");
	String waspaid 					= (String)request.getAttribute("waspaid");
	String paymentfrom 				= (String) request.getAttribute("paymentfrom");
	String paymentto				= (String)request.getAttribute("paymentto");
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
		$(function() {
		    $( "#txtDateIni" ).datepicker({
		      changeMonth: true,
		      numberOfMonths: 1,
		      onClose: function( selectedDate ) {
		        $( "#txtDateEnd" ).datepicker( "option", "minDate", selectedDate );
		      },
			    showOn: "button",
				buttonImage: "images/calendar.png",
				buttonImageOnly: true,
				buttonText: "Seleccione una fecha",
				dateFormat:'dd/mm/yy',
				changeMonth: true,
			    changeYear: true
		    });
		    $( "#txtDateEnd" ).datepicker({
		      changeMonth: true,
		      numberOfMonths: 1,
		      onClose: function( selectedDate ) {
		        $( "#txtDateIni" ).datepicker( "option", "maxDate", selectedDate );
		      },
		      showOn: "button",
				buttonImage: "images/calendar.png",
				buttonImageOnly: true,
				buttonText: "Seleccione una fecha",
				dateFormat:'dd/mm/yy',
				changeMonth: true,
			    changeYear: true
		    });
			$( "#txtDateIniR" ).datepicker({
		      changeMonth: true,
		      numberOfMonths: 1,
		      onClose: function( selectedDate ) {
		        $( "#txtDateEndR" ).datepicker( "option", "minDate", selectedDate );
		      },
			    showOn: "button",
				buttonImage: "images/calendar.png",
				buttonImageOnly: true,
				buttonText: "Seleccione una fecha",
				dateFormat:'dd/mm/yy',
				changeMonth: true,
			    changeYear: true
		    });
			$( "#txtDateEndR" ).datepicker({
		      changeMonth: true,
		      numberOfMonths: 1,
		      onClose: function( selectedDate ) {
		        $( "#txtDateIniR" ).datepicker( "option", "maxDate", selectedDate );
		      },
		      showOn: "button",
				buttonImage: "images/calendar.png",
				buttonImageOnly: true,
				buttonText: "Seleccione una fecha",
				dateFormat:'dd/mm/yy',
				changeMonth: true,
			    changeYear: true
		    });
		  });
		</script>
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
			<h2>Reportes Facturas</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoga el módulo del cual quiere obtener un reporte:</h3>
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
									<option value="12" selected>Facturas</option>
									<option value="13" >Admisión</option>
									<option value="14" >Honorarios Médicos</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="ListBillReportServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b># Factura:</b></td><td><input  type="text" name="billId" maxlength="50" size="20" value="<%= (billid != null) ? billid : "" %>" /></td>
									<td><b># Estimación:</b></td><td><input  type="text" name="estimationId" maxlength="50" size="20" value="<%= (estimationid != null) ? estimationid : "" %>" /></td>
									<td><b>Responsable de Pago:</b></td><td><input  type="text" name="paymentresponsiblename" maxlength="50" size="20" value="<%= (paymentresponsiblename != null) ? paymentresponsiblename : "" %>" /></td>
								</tr>
								<tr>
									<td><b>¿Fue generada?:</b></td>
									<td>
									<select name="wasGenerated">
										<option value="-">Ambos</option>
										<option value="1" <%= ( "1".equals(wasgenerated)) ? "selected" : "" %>>Si</option>
										<option value="0" <%= ( "0".equals(wasgenerated)) ? "selected" : "" %>>No</option>
									</select>
									</td>
									<td><b>Generada Desde:</b></td><td><input  type="text" name="generationfrom" id="txtDateIniR" maxlength="50" size="20" value="<%= (generationfrom != null) ? generationfrom : "" %>" /></td>
									<td><b>Generada Hasta:</b></td><td><input  type="text" name="generationto" id="txtDateEndR" maxlength="50" size="20" value="<%= (generationto != null) ? generationto : "" %>" /></td>
								</tr>
								<tr>
									<td><b>¿Fue pagada?:</b></td>
									<td>
									<select name="wasPaid">
										<option value="-">Ambos</option>
										<option value="1" <%= ( "1".equals(waspaid)) ? "selected" : "" %>>Si</option>
										<option value="0" <%= ( "0".equals(waspaid)) ? "selected" : "" %>>No</option>
									</select>
									</td>
									<td><b>Pagada Desde:</b></td><td><input  type="text" name="paymentfrom" id="txtDateIni" maxlength="50" size="20" value="<%= (paymentfrom != null) ? paymentfrom : "" %>" /></td>
									<td><b>Pagada Hasta:</b></td><td><input  type="text" name="paymentto" id="txtDateEnd" maxlength="50" size="20" value="<%= (paymentto != null) ? paymentto : "" %>" /></td>
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
											<th>Id</th>
											<th>Responsable de Pago</th>
											<th>Monto</th>
											<th>¿Fue generada?</th>
											<th>Fecha Generación</th>
											<th>¿Fue Pagada?</th>
											<th>Fecha Pago</th>
											<th></th>
										</tr>
									</thead>
									<tbody>		
									<% 	if (mfList != null && mfList.size() > 0 ){
											for (int i = 0; i < mfList.size(); i++){ 
											PendingBills u = mfList.get(i); 
									%>
										<tr>
											<td><%= u.getBillID() %></td>
											<td><%= u.getPaymentResposible().getName() %></td>
											<td><%= u.getTotal() %></td>
											<td><%= (u.getWasGenerated() == 1)? "Si" : "No" %></td>
											<td><%= (u.getGenerationDate() != null)? u.getGenerationDate() : "-" %></td>
											<td><%= (u.getWasPaid() == 1)? "Si" : "No" %></td>
											<td><%= (u.getPaymentDate() != null)? u.getPaymentDate() : "-" %></td>
											<td>
												<a id="go" rel="leanModal" href="#printUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars('<%= u.getAdmissionID() %>','<%= u.getBillID() %>');" >
												<img alt="logo" src="./images/print.png"  height="16" width="16" title="Imprimir"/>
											</a> 
											</td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="7" style="text-align: center;">No hay datos disponibles</td></tr>
									
									<% } %>	
									</tbody>
								</table>
							</div>
					</div>
				</div>
				<div class="spacer"></div>
       	</div>
		</div>
		<div id="printUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Imprimir Factura</h3>
				<br><br>
				<span>Seleccione en qué formato desea imprimir la factura n° <span class="cliente"></span>:</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<!-- Hay que hacer ambas versiones para imprimir -->
				<form action="PrintInvoiceCompactServlet" method="post"  onsubmit="return setV(this)" id="printForm" style="text-align: center;">
					<input type="hidden" id="admId" class="good_input" name="admId"  value=""/>
					<input type="hidden" id="factId" class="good_input" name="factId"  value=""/>
					<input type="hidden" id="f" class="good_input" name="f"  value="in"/>
					<select onchange="return formatSelected(this)" id="formats">
						<option value="PrintInvoiceCompactServlet">Compacto</option>
						<option value="PrintInvoiceServlet">Detallado</option>
						<option value="PrintInvoiceServicesServlet">Servicios Auxiliares</option>
						<option value="PrintInvoiceSuppliesServlet">Material M&eacute;dico y F&aacute;rmacos</option>
					</select><br><br>
					<input type="submit"  class="buttonPopUpDelete2"  name="sbmtButton" value="Aceptar" style="position: static;"  />
		 		</form>
			</div>
		</div>
	</body>
</html>