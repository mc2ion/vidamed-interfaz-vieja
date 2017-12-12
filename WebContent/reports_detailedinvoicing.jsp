<%@page import="sun.font.EAttribute"%>
<%@page import="domain.Invoice"%>
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
	ArrayList<Invoice> mfList = (ArrayList<Invoice>)request.getAttribute("pp");

	String generationfrom 			= (String)request.getAttribute("generationfrom");
	String generationto 			= (String)request.getAttribute("generationto");
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
			<h2>Reporte Facturaci&oacute;n Detallada</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoja el m�dulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								     <option value="0">Seleccionar</option>
									<option value="1" >Usuarios</option>
									<option value="2" >Especialistas</option>
									<option value="3" >Responsables de Pago</option>
									<option value="4" >Farmacia - Admin</option>
									<option value="5" >Farmacia - Pacientes</option>
									<option value="6" >Banco de Sangre</option>
									<option value="7" >Ecosonograf�a</option>
									<option value="8" >Rayos X</option>
									<option value="9" >Laboratorio</option>
									<option value="10" >Interconsultas</option>
									<option value="11" >Descuentos</option>
									<option value="12" >Facturas</option>
									<option value="13" >Admisi�n</option>
									<option value="14" >Honorarios M�dicos</option>
									<option value="15" >Libro de Ventas</option>
									<option value="16" selected>Facturaci�n detallada</option>
									<option value="17" >An&aacute;lisis Vencimiento</option>
									<option value="18" >Relaci&oacute;n de Facturaci&oacute;n</option>
									<option value="19" >An&aacute;lisis Vencimiento Resumido</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="DetailedInvoicingReportServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la b�squeda por los siguientes par�metros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Egreso Desde:</b></td><td><input  type="text" name="generationfrom" id="txtDateIniR" maxlength="50" size="20" value="<%= (generationfrom != null) ? generationfrom : "" %>" /></td>
									<td><b>Egreso Hasta:</b></td><td><input  type="text" name="generationto" id="txtDateEndR" maxlength="50" size="20" value="<%= (generationto != null) ? generationto : "" %>" /></td>
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
											<th>N� Factura</th>
											<th>Monto Cl&iacute;nica</th>
											<th>Monto Descuento</th>
											<th>Monto F&aacute;rmacos</th>
											<th>Monto Mat M&eacute;dico</th>
											<th>Monto Laboratorio</th>
											<th>Monto Rayos X</th>
											<th>Monto Eco</th>
											<th>Honorarios M&eacute;dicos</th>
											<th>Total Factura</th>
										</tr>
									</thead>
									<tbody>		
									<% 	if (mfList != null && mfList.size() > 0 ){
											for (int i = 0; i < mfList.size(); i++){ 
											Invoice u = mfList.get(i); 
									%>
										<tr>
											<td><%= u.getBillID() %></td>
											<td><%= u.getClinicTotal() %></td>
											<td><%= u.getDiscount() %></td>
											<td><%= u.getDrugs() %></td>
											<td><%= u.getMaterials() %></td>
											<td><%= u.getLabs() %></td>
											<td><%= u.getxRays() %></td>
											<td><%= u.getEcos() %></td>
											<td><%= u.getProfessionalFees() %></td>
											<td><%= u.getTotal() %></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="10" style="text-align: center;">No hay datos disponibles</td></tr>
									
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