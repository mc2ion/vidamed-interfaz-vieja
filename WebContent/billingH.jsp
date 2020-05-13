<%@page import="domain.User"%>
<%@page import="domain.PendingMedicalFee"%>
<%@page import="java.util.ArrayList"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;

	@SuppressWarnings("unchecked")
	ArrayList<PendingMedicalFee> mfList = (ArrayList<PendingMedicalFee>)request.getAttribute("medicalFee");
	
	String text_result = (String) session.getAttribute("text");
	if (text_result == null)
		text_result = "";
	session.removeAttribute("text");
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
				dateFormat:'dd/mm/yyyy',
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
				dateFormat:'dd/mm/yyyy',
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
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Honorarios Médicos:</h2><br>
				<div class="info-text"><%= text_result %></div>
					<div id="demo">
						<table class="display" id="example">
							<thead>
								<tr>
									<th>Pago del Seguro</th>
									<th>Doctor</th>
									<th>Monto</th>
									<th>Factura</th>
									<th>Acciones</th>
								</tr>
							</thead>
							<tbody>			
								<% for (int i = 0; i < mfList.size(); i++){
									PendingMedicalFee pm = mfList.get(i);
									String status = "Pendiente";
									System.out.println("status " + pm.getBillWasPaid());
									if (pm.getBillWasPaid() == 1)
										status = "<span style=\"color: rgb(241, 224, 180);font-weight: bold;font-style: italic;\">Cobrado</span>";
									String eName = pm.getSpecialist().getFirstName() + " " + pm.getSpecialist().getLastName();
									System.out.println(pm.getMedicalFeeID());
									
								%>
								<tr class="gradeA">
									<td><%= status %></td>
									<td><%= eName %></td>
									<td>Bs. <%= pm.getAmount() %></td>
									<td><%= pm.getBillID() %></td>
									<td>
										<a href="ShowMedicalFeedServlet?id=<%= pm.getMedicalFeeID() %>" style="color: transparent" >
											<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
										</a>
										<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(<%= pm.getMedicalFeeID() %>,<%= pm.getBillID() %>, '<%= eName %>');" >
											<img alt="logo" src="./images/check.png" height="16" width="16" title="Pagar"/>
										</a>
										<a id="go" rel="leanModal" href="#payment" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(<%= pm.getMedicalFeeID() %>,<%= pm.getBillID() %>, '<%= eName %>');" >
											<img alt="logo" src="./images/prontopago.png" height="16" width="16" title="Mover a Pronto Pago"/>
										</a> 
									</td>
								</tr>
								<% } %>
								</tbody>
							</table>
						</div>
				</div>
		</div>
		<div id="deleteUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Cuenta Por <span class="type"></span>  </h3>
				<br><br>
				<span>¿Está seguro que desea eliminar la cuenta por <span class="type"></span>  de <span class="name"></span>? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form >
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="closeAccount">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Pago Realizado</h3>
				<br><br>
				<span>¿Está seguro que el pago #<span class="fId"></span> al doctor <span class="name"></span> fue realizado? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="PayPendingMedicalFeeServlet" method="post" onsubmit="return setV(this)" >
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<label>N&uacute;mero de Documento: </label><input type="text" name="documentnumber" id="documentnumber" size="10"><br>
					<label>Banco: </label><input type="text" name="bank" id="bank" size="25">
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		
		<div id="payment">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Mover a Pronto Pago</h3>
				<br><br>
				<span>¿Está seguro que desea mover el pago #<span class="fId"></span> del doctor <span class="name"></span> a pronto pago? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="MoveToPromptPaymentServlet" method="post" onsubmit="return setV(this)" style="text-align:center;">
				    <input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<input type="hidden" id="variableId" class="good_input" name="variableId"  value="1"/>
					<span>Porcentaje negociado: 
						<select name="commission" id="commission">
							<%for(int i = 1; i<=15; i++){ %>
							<option value="<%= (i+0.00)/100 %>"><%= i%>%</option>
							<%}%>
						</select>
					</span>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>