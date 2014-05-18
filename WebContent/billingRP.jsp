<%@page import="domain.MedicalFee"%>
<%@page import="domain.User"%>
<%@page import="domain.PendingMedicalFee"%>
<%@page import="java.util.ArrayList"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;

	@SuppressWarnings("unchecked")
	ArrayList<MedicalFee> mfList = (ArrayList<MedicalFee>)request.getAttribute("pp");
	
	String text_result = (String) session.getAttribute("text");
	if (text_result == null)
		text_result = "";
	session.removeAttribute("text");
	
	
	String dateIni = (String) request.getAttribute("dateIni");
	String dateEnd = (String)request.getAttribute("dateEnd");
	String nameF = (String)request.getAttribute("name");
	String amount = (String)request.getAttribute("amount");
	String lastName = (String)request.getAttribute("lastname");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Facturación</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<!--JS Datapicker-->
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
		<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
		<script type="text/javascript" charset="utf-8">
		$(document).ready(function() {
			$('#example').dataTable( {
				"iDisplayLength": 5,
				"bLengthChange": false,
				"sScrollY": "200px",
				"bPaginate": false,
				"aoColumns": [
					null,
					null,
					null,
					null,
					{ "bSearchable": false, "asSorting": false, "sWidth": "18%" }
				],
				"oLanguage": {
		            "sLengthMenu": " ",
		            "sZeroRecords": "No hay ningún registro que coincida con su búsqueda",
		            "sInfo": " ",
		            "sInfoEmpty": " ",
		            "sInfoFiltered": " ",
		            "sEmptyTable": "No hay datos disponibles en la tabla",
		            "sLoadingRecords": "Por favor, espere - cargando...",
		            "sSearch": "Buscar:"
	        	}
			} );
	} );
		
	</script>
		<script type="text/javascript">
		var idUser;

		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x, .buttonPopUpDelete" });		
		});

		function loadVars(var1, var2, var3, var4) {
			idUser = var1;
			$('.fId').text(var2);
			$('.name').text(var3);
		};

		function setV(f){
			f.elements['userId'].value = idUser;
			return true;
		}
		</script>
		<script>
			$(function() {
				$("#tabs").tabs();
				$("#tabs").tabs("select", window.location.hash);
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
		    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Relación de Pago:</h2><br>
				<div class="info-text"><%= text_result %></div>
					<form action="ListBillingsRPServlet" style="margin-top: -10px;" method="post" >
						Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  						<div>
							<fieldset style="text-align: left; margin-left:0px;">
							<table style="width:100%;">
								<tr>
									<td><b>Desde:</b></td><td><input  type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="20" value="<%= (dateIni != null) ? dateIni : "" %>" /></td>
									<td><b>Hasta:</b></td><td> <input  type="text" name="txtDateEnd" id="txtDateEnd" maxlength="50" size="20" value="<%= (dateEnd != null) ? dateEnd : "" %>"/></td>
									<td><b>Importe Bs:</b></td><td><input type="text" name="amount" size="20" value="<%= (amount != null) ? amount : "" %>"></td>
								</tr>
								<tr>
									<td><b>Nombre Especialista:</b></td><td>  <input type="text" name="eName" size="20" value="<%= (nameF != null) ? nameF : "" %>"></td>
									<td><b>Apellido Especialista:</b></td><td>  <input type="text" name="eLastname" size="20" value="<%= (lastName != null) ? lastName : "" %>"></td>
									<td> <td style="text-align:center;"><input type="submit" class="buttonGreen lessPadding" value="Buscar"></td>
								</tr>
							</table>	
							</fieldset>
  						</div>	
  					</form>
  							<div id="demo" style="display: block; height: 300px; overflow-y: scroll; margin-top:10px;">
								<table id="sweetTable" >
									<thead>
										<tr>
											<th>Fecha de Pago</th>
											<th>Especialista</th>
											<th>Importe</th>
											<th>Pronto Pago</th>
											<th style="text-align:center;">Acciones</th>
										</tr>
									</thead>
									<tbody>		
										<% 
											if (mfList.size() > 0 ){
												for (int i=0; i< mfList.size(); i++){ 
												MedicalFee m = mfList.get(i);
												String ename = m.getSpecialist().getFirstName() + " " +m.getSpecialist().getLastName();
										%>	
										<tr>
											<td><%= (m.getPaymentDate()!= null) ? m.getPaymentDate() : "No proporcionada" %></td>
											<td><%= ename %></td>
											<td>Bs. <%= m.getAmount() %></td>
											<td><%= (m.getIsPromptPayment() == 1) ? "Si" : "No" %></td>
											<td style="text-align:center;"><a href="ShowMedicalFeedServlet?id=<%= m.getMedicalFeeID() %>" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a></td>
										</tr>
									<% 		}
										}else{									
									%>
										<tr><td colspan="5" style="text-align: center;">No hay datos disponibles</td></tr>
									
									<% } %>
									</tbody>
								</table>
							</div>
				</div>
		</div>
		<div id="closeAccount">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Cobrada</h3>
				<br><br>
				<span>¿Está seguro que el pago #<span class="fId"></span> al doctor <span class="name"></span> fue realizado? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="PayPendingPromptPaymentServlet" method="post" onsubmit="return setV(this)" >
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>