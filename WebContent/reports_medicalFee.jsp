<%@page import="domain.MedicalFee"%>
<%@page import="domain.SupplyArea"%>
<%@page import="domain.SupplyForm"%>
<%@page import="domain.Supply"%>
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
	ArrayList<MedicalFee> mfList = (ArrayList<MedicalFee>)request.getAttribute("pp");

	String identityCard = (String)request.getAttribute("identityCard");
	String gender = (String)request.getAttribute("gender");
	String rif = (String)request.getAttribute("rif");
	String billid = (String)request.getAttribute("billid");
	String billwasgenerated = (String)request.getAttribute("billwasgenerated");
	String billgenerationfrom = (String) request.getAttribute("billgenerationfrom");
	String billgenerationto = (String)request.getAttribute("billgenerationto");
	String billwaspaid = (String)request.getAttribute("billwaspaid");
	String billpaymentfrom = (String)request.getAttribute("billpaymentfrom");
	String billpaymentto = (String)request.getAttribute("billpaymentto");
	String ispromptpayment = (String)request.getAttribute("ispromptpayment");
	String waspaid = (String)request.getAttribute("waspaid");
	String paymentfrom = (String)request.getAttribute("paymentfrom");
	String paymentto = (String)request.getAttribute("paymentto");

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
				 $( "#txtDateIniW" ).datepicker({
			      changeMonth: true,
			      numberOfMonths: 1,
			      onClose: function( selectedDate ) {
			        $( "#txtDateEndW" ).datepicker( "option", "minDate", selectedDate );
			      },
				    showOn: "button",
					buttonImage: "images/calendar.png",
					buttonImageOnly: true,
					buttonText: "Seleccione una fecha",
					dateFormat:'dd/mm/yy',
					changeMonth: true,
				    changeYear: true
			    });
			    $( "#txtDateEndW" ).datepicker({
			      changeMonth: true,
			      numberOfMonths: 1,
			      onClose: function( selectedDate ) {
			        $( "#txtDateIniW" ).datepicker( "option", "maxDate", selectedDate );
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
		<div id="content" style="min-height: 700px;">  
			<h2>Reportes Honorarios Médicos</h2>
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
									<option value="12" >Facturas</option>
									<option value="13" >Admisión</option>
									<option value="14"  selected>Honorarios Médicos</option>
									<option value="15" >Libro de Ventas</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="ListMedicalFeeReportServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Cédula:</b></td><td> <input  type="text" name="identityCard" maxlength="50" size="20" value="<%= (identityCard != null) ? identityCard : "" %>"/></td>
									<td><b>Rif:</b></td><td><input type="text" name="rif" size="20" value="<%= (rif != null) ? rif : "" %>"></td>
									<td><b>Sexo:</b></td><td>
									<select name="gender">
										<option value="-">Ambos</option>
										<option value="F" <%= (gender != null && gender.equals("F")) ? "selected" : "" %> >F</option>
										<option value="M" <%= (gender != null && gender.equals("M")) ? "selected" : "" %>>M</option>
									</select>
									</td>
								</tr>
								<tr>
									<td><b>¿Factura Generada?:</b></td><td>
									<select name="billwasgenerated">
										<option value="-"> Todas </option>
										<option value="1" <%= ( "1".equals(billwasgenerated)) ? "selected" : "" %> > Si</option>
										<option value="0" <%= ( "0".equals(billwasgenerated)) ? "selected" : "" %>>No </option>
									</select>
									</td>
									<td><b>Fact. Generada Desde:</b></td><td><input  type="text" name="billgenerationfrom" id="txtDateIni" maxlength="50" size="20" value="<%= (billgenerationfrom != null) ? billgenerationfrom : "" %>" /></td>
									<td><b>Fact. Generada Hasta:</b></td><td> <input  type="text" name="billgenerationto" id="txtDateEnd" maxlength="50" size="20" value="<%= (billgenerationto != null) ? billgenerationto : "" %>"/></td>
								</tr>
								<tr>
									<td><b>¿Factura Pagada?:</b></td><td>
									<select name="billwaspaid">
										<option value="-"> Todas </option>
										<option value="1" <%= ( "1".equals(billwaspaid)) ? "selected" : "" %> > Si</option>
										<option value="0" <%= ( "0".equals(billwaspaid)) ? "selected" : "" %>>No </option>
									</select>
									</td>
									<td><b>Fact. Pagada Desde:</b></td><td><input  type="text" name="billpaymentfrom" id="txtDateIniW" maxlength="50" size="20" value="<%= (billpaymentfrom != null) ? billpaymentfrom : "" %>" /></td>
									<td><b>Fact. Pagada Hasta:</b></td><td> <input  type="text" name="billpaymentto" id="txtDateEndW" maxlength="50" size="20" value="<%= (billpaymentto != null) ? billpaymentto : "" %>"/></td>
								</tr>
								<tr>
									<td><b># Factura:</b></td><td> <input  type="text" name="billid" maxlength="50" size="20" value="<%= (billid != null) ? billid : "" %>"/></td>
									<td><b>¿Pronto Pago?:</b></td><td>
									<select name="ispromptpayment">
										<option value="-"> Todas </option>
										<option value="1" <%= ( "1".equals(ispromptpayment)) ? "selected" : "" %> >Si</option>
										<option value="0" <%= ( "0".equals(ispromptpayment)) ? "selected" : "" %>>No </option>
									</select>
									</td>
									<td><b>¿Honorario Pagado?:</b></td><td>
									<select name="waspaid">
										<option value="-"> Todas </option>
										<option value="1" <%= ( "1".equals(waspaid)) ? "selected" : "" %> > Si</option>
										<option value="0" <%= ( "0".equals(waspaid)) ? "selected" : "" %>>No </option>
									</select>
									</td>	
								</tr>
								<tr>
									<td><b>Honorario Pagado Desde:</b></td><td><input  type="text" name="paymentfrom" id="txtDateIniR" maxlength="50" size="20" value="<%= (paymentfrom != null) ? paymentfrom : "" %>" /></td>
									<td><b>Honorario Pagado Hasta:</b></td><td> <input  type="text" name="paymentto" id="txtDateEndR" maxlength="50" size="20" value="<%= (paymentto != null) ? paymentto : "" %>"/></td>
							
								</tr>
									
							</table>	
							<input type="submit" class="buttonGreen lessPadding"   style="float: right; margin-right:40px; margin-top: 5px;" value="Buscar">
							</fieldset>
  						</div>	
  						</form>
  						<div id="demo" style="display: block; height: 400px; overflow-y: scroll; margin-top:10px;">
								<table id="sweetTable" style="font-size: 9px;" >
									<thead>
										<tr>
											<th>Cédula</th>
											<th>Rif</th>
											<th>Nombre</th>
											<th>Sexo</th>
											<th>Honorario</th>
											<th>¿Fue Generada?</th>
											<th>Fecha Generación</th>
											<th>¿Fact. Pagada?</th>
											<th>Fecha Pago</th>
											<th>¿Pronto Pago?</th>
											<th>¿Honorario Pagado?</th>
											<th>Monto</th>
										</tr>
									</thead>
									<tbody>	
									<tbody>	
									<% 	if (mfList != null && mfList.size() > 0 ){
											for (int i = 0; i < mfList.size(); i++){ 
											MedicalFee us = mfList.get(i); 
									%>
										<tr>
											<td><%= us.getSpecialist().getIdentityCard() %></td>
											<td><%= (us.getSpecialist().getRif() != null)? us.getSpecialist().getRif() : "-"%></td>
											<td><%= us.getSpecialist().getFirstName() + " " + us.getSpecialist().getLastName()  %></td>
											<td><%= us.getSpecialist().getSex() %></td>
											<td><%= us.getAmount() %></td>
											<td><%= (us.getBill().getWasGenerated() == 0)? "No": "Si" %></td>
											<td><%= (us.getBill().getGenerationDate() != null)? us.getBill().getGenerationDate(): "-" %></td>
											<td><%= (us.getBill().getWasPaid() == 0)? "No": "Si" %></td>
											<td><%= (us.getBill().getPaymentDate() != null)? us.getBill().getPaymentDate(): "-" %></td>
											<td><%= (us.getIsPromptPayment()  == 0)? "No": "Si" %></td>
											<td><%= (us.getWasPaid() != 0)? "Si": "No" %></td>
											<td><%= (us.getPromptAmount()  != null)? us.getPromptAmount(): "-" %></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="12" style="text-align: center;">No hay datos disponibles</td></tr>
									<% } %>	
									</tbody>
										
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