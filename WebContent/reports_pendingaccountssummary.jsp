<%@page import="java.util.ArrayList"%>
<%@page import="domain.PaymentResponsible"%>
<%@page import="domain.PendingAccounts"%>
<%@page import="domain.User"%>
<%@ page import="java.util.HashMap" %>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	ArrayList<PendingAccounts> pp = (ArrayList<PendingAccounts>)request.getAttribute("pp");
	HashMap<String, Integer> header = (HashMap<String, Integer>) request.getAttribute("header");
	ArrayList<String> ht = (ArrayList<String>)request.getAttribute("ht");
	
	String dateIni = (String) request.getAttribute("dateIni");
	String dateEnd = (String)request.getAttribute("dateEnd");
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
		<div id="content">  
			<h2>Reporte An&aacute;lisis Vencimiento Resumido</h2>
			<div id="dt_example">
					<div id="container">
						<form action="ListReportsServlet" method="post">
								<h3 style="display:inline;">Escoja el módulo del cual quiere obtener un reporte:</h3>
								<select name="modId">
								  	<option value="0">Seleccionar</option>
									<option value="1" selected>Usuarios</option>
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
									<option value="18" >Relaci&oacute;n de Facturaci&oacute;n</option>
									<option value="19" selected>An&aacute;lisis Vencimiento Resumido</option>
									<option value="20" >Registros de Pacientes</option>
									<option value="21" >Insumos Facturados</option>
									<option value="22" >Insumos Pacientes</option>
								</select>
								<input type="submit" value="Buscar"/>
						</form><br/><br/>
						<form action="PendingAccountsSummaryReportServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Desde:</b></td><td><input  type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="20" value="<%= (dateIni != null) ? dateIni : "" %>" required /></td>
									<td><b>Hasta:</b></td><td> <input  type="text" name="txtDateEnd" id="txtDateEnd" maxlength="50" size="20" value="<%= (dateEnd != null) ? dateEnd : "" %>" required /></td>
									<td><b></b></td><td></td>
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
										<% if(ht != null && ht.size() > 0) {											
											for (String col : ht) {%>
										        <th><%= col %></th>
										    <%}
										} else {
										%>
											<th>Responsable de pago</th>
										<%
										} %>
										</tr>
									</thead>
									<tbody>	
									<% 	if (pp != null && pp.size() > 0 ){
											Long id = 0L;
											Integer aux = 1;
											
											for (int i = 0; i < pp.size(); i++){ 
												PendingAccounts u = pp.get(i);
												PaymentResponsible pr = u.getPaymentResposible();
												System.out.println("+++++ id: '"+id+"', pr.getId(): '"+pr.getId()+"', match?: "+ (id == pr.getId()));
												if(!id.equals(pr.getId())) {
													if(aux != 1){
														for(int j = aux; j < header.keySet().size(); j++) {
															%>
											<td></td>
															<%
														}
														
														aux = 1;
														%>
										</tr>
														<%
													}
													%>
										<tr>
											<td><%= pr.getName() %></td>
													<%
													Integer index = header.get(u.getDeliveryDate());
													
													for(int k = aux; k <= index; k++) {
														if(k == index) {
															%>
											<td><%= (u.getTotal()==null)?"":u.getTotal() %></td>
															<%
														} else {
															%>
											<td></td>
															<%
														}
													}
													
													aux = index + 1;
													id = pr.getId();
												} else {
													Integer index = header.get(u.getDeliveryDate());
													
													for(int l = aux; l <= index; l++) {
														if(l == index) {
															%>
											<td><%= (u.getTotal()==null)?"":u.getTotal() %></td>
															<%
														} else {
															%>
											<td></td>
															<%
														}
													}
													
													aux = index + 1;
													id = pr.getId();
												}
											}
											
											if(aux != 1){
												for(int i = aux; i < header.keySet().size(); i++) {
													%>
									<td></td>
													<%
												}
												
												aux = 1;
												%>
								</tr>
												<%
											}
										}else{									
									%>
										<tr><td colspan="<%= (header != null && header.keySet().size() > 0)?header.keySet().size():1 %>" style="text-align: center;">No hay datos disponibles</td></tr>
									
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