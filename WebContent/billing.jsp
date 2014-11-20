<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
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
			
			$('#example4').dataTable( {
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
			$('.type').text(var2);
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
        	<div id="content" style="position:absolute;">	
	        	<h2>Facturación:</h2><br>
	        	<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Honorarios Médicos</a></li>
					    <li><a href="#tabs-2">Relación de Pago</a></li>
					    <li><a href="#tabs-3">Generar Nómina</a></li>
					    <li><a href="#tabs-4">Pronto Pago</a></li>
					</ul>
  					<div id="tabs-1">
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
										<tr class="gradeA">
											<td>Pendiente</td>
											<td>Pablo Rojas </td>
											<td>Bs. 15000</td>
											<td>F-2015</td>
											<td>
												<a href="ShowMedicalFeedServlet" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#payment" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'', 'Luisa Mendez');" >
													<img alt="logo" src="./images/prontopago.png" height="16" width="16" title="Mover a Pronto Pago"/>
												</a> 
											</td>
										</tr>
										<tr class="gradeA">
											<td><span style="color: rgb(241, 224, 180);font-weight: bold;font-style: italic;"> Cobrado</span></td>
											<td>Juan Pérez</td>
											<td>Bs. 5000</td>
											<td>F-24410</td>
											<td>
												<a href="ShowMedicalFeedServlet" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Cobrar', 'Juan Pérez');" >
													<img alt="logo" src="./images/check.png" height="16" width="16" title="Pago Realizado"/>
												</a> 
											</td>
										</tr>
										<tr class="gradeA">
											<td><span style="color: rgb(241, 224, 180);font-weight: bold;font-style: italic;"> Cobrado</span></td>
											<td>Luisa Mendez</td>
											<td>Bs. 34500</td>
											<td>F-1324A</td>
											<td>
												<a href="ShowMedicalFeedServlet" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Cobrar', 'Luisa Mendez');" >
													<img alt="logo" src="./images/check.png" height="16" width="16" title="Pago Realizado"/>
												</a> 
											</td>
										</tr>
									</tbody>
								</table>
							</div>
					</div>
					<div id="tabs-2">
						<form id="searchPayments">
							Si lo desea, puede filtrar la búsqueda por cualquiera de los siguientes parámetros:
  							<fieldset>
  							<b>Desde:</b> <input  type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" /> &nbsp;&nbsp;
							<b>Hasta:</b> <input  type="text" name="txtDateEnd" id="txtDateEnd" maxlength="50" size="10" />
							<b>Especialista:</b><input type="text" size="20">
  							<b>Importe:</b> Bs.<input type="text" size="10"><br>
  							</fieldset>
  							<input type="submit" class="buttonGreen absoluteB lessPadding" value="Buscar">
  						</form>
  							<div id="demo" style="display: block; height: 300px; overflow-y: scroll;">
								<table id="sweetTable" >
									<thead>
										<tr>
											<th>Fecha de Pago</th>
											<th>Especialista</th>
											<th>Importe</th>
											<th style="text-align:center;">Acciones</th>
										</tr>
									</thead>
									<tbody>			
										<tr>
											<td>20/09/2013</td>
											<td>Ana Rojas</td>
											<td>Bs. 15000</td>
											<td style="text-align:center;"><a href="ShowPaymentServlet?id=" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a></td>
										</tr>
										<tr>
											<td>20/09/2013</td>
											<td>Pedro Ramirez</td>
											<td>Bs. 5000</td>
											<td style="text-align:center;"><a href="ShowPaymentServlet?id=" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a></td>
										</tr>
										<tr>
											<td>20/09/2013</td>
											<td>Luis Gomez</td>
											<td>Bs. 34500</td>
											<td style="text-align:center;"><a href="ShowPaymentServlet?id=" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a></td>
										</tr>
										<tr>
											<td>20/09/2013</td>
											<td>Juan Medina</td>
											<td>Bs. 15000</td>
											<td style="text-align:center;"><a href="ShowPaymentServlet?id=" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a></td>
										</tr>
										<tr>
											<td>20/09/2013</td>
											<td>Ana Rojas</td>
											<td>Bs. 15000</td>
											<td style="text-align:center;"><a href="ShowPaymentServlet?id=" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a></td>
										</tr>
										<tr>
											<td>20/09/2013</td>
											<td>Pedro Ramirez</td>
											<td>Bs. 5000</td>
											<td style="text-align:center;"><a href="ShowPaymentServlet?id=" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a></td>
										</tr>
										<tr>
											<td>20/09/2013</td>
											<td>Luis Gomez</td>
											<td>Bs. 34500</td>
											<td style="text-align:center;"><a href="ShowPaymentServlet?id=" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a></td>
										</tr>
										<tr>
											<td>20/09/2013</td>
											<td>Juan Medina</td>
											<td>Bs. 15000</td>
											<td style="text-align:center;"><a href="ShowPaymentServlet?id=" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
											</a></td>
										</tr>
										<tr style="background: gray;">
											<td colspan="3">Total</td>
											<td>Bs. 165.240,20</td>
										</tr>
										
									</tbody>
								</table>
							</div>
					</div>
					<div id="tabs-3">
							<div style="text-align:right; margin-bottom: 10px;">
								<a href="AddEmployerServlet" style="color: #006c92; font-weight: bold;">
									<img alt="logo" src="./images/add.png" height="12" width="12">Agregar Empleado
								</a>						
							</div>
  							<div id="demo" style="display: block; height: 300px; overflow-y: scroll;">
								<table id="sweetTable" >
									<thead>
										<tr>
											<th>Fecha de Pago</th>
											<th>Departamento</th>
											<th>Empleado</th>
											<th>Cargo</th>
											<th>Importe</th>
										</tr>
									</thead>
									<tbody>			
										<tr>
											<td>15/10/2013</td>
											<td>Sistema</td>
											<td>Ana Rojas</td>
											<td>Ing. de Sistemas</td>
											<td>Bs. 15000</td>
										</tr>
										<tr>
											<td>15/10/2013</td>
											<td>Facturación</td>
											<td>Pedro Ramirez</td>
											<td>Cajero</td>
											<td>Bs. 5000</td>
										</tr>
										<tr>
											<td>15/10/2013</td>
											<td>Farmacia</td>
											<td>Luis Gomez</td>
											<td>Ing. Químico</td>
											<td>Bs. 34500</td>
										</tr>
										<tr>
											<td>15/10/2013</td>
											<td>Sistema</td>
											<td>Juan Medina</td>
											<td>Ing. de Sistemas</td>
											<td>Bs. 15000</td>
										</tr>
										<tr>
											<td>15/10/2013</td>
											<td>Admisión</td>
											<td>Ana Rojas</td>
											<td>Jefe de Admisión</td>
											<td>Bs. 15000</td>
										</tr>
										<tr>
											<td>15/10/2013</td>
											<td>Facturación</td>
											<td>Pedro Ramirez</td>
											<td>Cobrador</td>
											<td>Bs. 5000</td>
										</tr>
										<tr>
											<td>15/10/2013</td>
											<td>Sistema</td>
											<td>Luis Gomez</td>
											<td>Gerente de Sistemas</td>
											<td>Bs. 34500</td>
										</tr>
										<tr>
											<td>15/10/2013</td>
											<td>Farmacia</td>
											<td>Juan Medina</td>
											<td>Ing. Químico</td>
											<td>Bs. 15000</td>
										</tr>
										<tr style="background: gray;">
											<td colspan="4">Total</td>
											<td>Bs. 165.240,20</td>
										</tr>
										
									</tbody>
								</table>
							</div>
					</div>
					<div id="tabs-4">
							<div id="demo">
								<table class="display" id="example4">
									<thead>
										<tr>
											<th>Doctor</th>
											<th>Monto</th>
											<th>Factura</th>
											<th>Estatus</th>
											<th>Acciones</th>
										</tr>
									</thead>
									<tbody>			
										<tr class="gradeA">
											<td>Pablo Rojas </td>
											<td>Bs. 15000</td>
											<td>F-2015</td>
											<td>Pendiente</td>
											<td>
												<a href="ShowPromptPaymentServlet" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Cobrar', 'Juan Pérez');" >
													<img alt="logo" src="./images/check.png" height="16" width="16" title="Cobrada"/>
												</a> 
												<br>
											</td>
										</tr>
										<tr class="gradeA">
											<td>Juan Pérez</td>
											<td>Bs. 5000</td>
											<td>F-24410</td>
											<td>Pendiente</td>
											<td>
												<a href="ShowPromptPaymentServlet" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<a id="go" rel="leanModal" href="#closeAccount" style="color: #f7941e; font-weight: bold;" 
													onclick="return loadVars(1001,'Cobrar', 'Juan Pérez');" >
													<img alt="logo" src="./images/check.png" height="16" width="16" title="Cobrada"/>
												</a> 
												<br>
											</td>
										</tr>
										<tr class="gradeA">
											<td>Luisa Mendez</td>
											<td>Bs. 34500</td>
											<td>F-1324A</td>
											<td><span style="color: rgb(241, 224, 180);font-weight: bold;font-style: italic;"> Cobrado</span></td>
											<td>
												<a href="ShowPromptPaymentServlet" style="color: transparent" >
													<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
												</a>
												<br>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					
					
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
				<h3 id="see_id" class="sprited" > Pago Realizado</h3>
				<br><br>
				<span>¿Está seguro que el pago al doctor <span class="name"></span> fue realizado? </span> <br><br>
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
		
		<div id="payment">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Mover a Pronto Pago</h3>
				<br><br>
				<span>¿Está seguro que desea mover al doctor <span class="name"></span> a pronto pago? </span> <br><br>
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
	</body>
</html>