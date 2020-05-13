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
		<title>Editar Cuenta por Pagar</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>		
		<!--JS Datapicker-->
		<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
		<script type="text/javascript">
			$(function(){
				$.datepicker.setDefaults($.datepicker.regional['es']);
				$('#txtDateIni').datepicker({
					showOn: "button",
					buttonImage: "images/calendar.png",
					buttonImageOnly: true,
					buttonText: "Seleccione una fecha",
					dateFormat:'dd/mm/yyyy',
					changeMonth: true,
				    changeYear: true
				});
			} );
			
			$(function(){
				$.datepicker.setDefaults($.datepicker.regional['es']);
				$('#txtDateIni2').datepicker({
					showOn: "button",
					buttonImage: "images/calendar.png",
					buttonImageOnly: true,
					buttonText: "Seleccione una fecha",
					dateFormat:'dd/mm/yyyy',
					changeMonth: true,
				    changeYear: true
				});
			} );
		</script>
		<link rel="stylesheet" href="/resources/demos/style.css" />		
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />   
        	<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListAccountsServlet">Ver Cuentas</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Editar Cuenta por Pagar:</h2>
	        	<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Información Cuenta</a></li>
					    <li><a href="#tabs-2">Información Pago</a></li>
					    <li><a href="#tabs-3">Información Adicional</a></li>
			  		</ul>
			  		<div id="tabs-1">
						<fieldset>
							<label for="name">Documento a Pagar:</label>Factura<br><br>
							<label for="name">Factura:</label>F-7629 <br><br>
							<label for="name">Número Control:</label>1725778 <br><br>
							<label for="name">Proveedor:</label>Anthony Bernal<br><br>
							<label for="name">Fecha Facturación:</label>18/07/2013<br><br>
							<label for="name">Fecha Vencimiento:</label>20/09/2013
						</fieldset>						
						<br>
			  		</div>			  		
			  		<div id="tabs-2">
						<fieldset>
							<label for="name">Base Imponible:</label> Bs. 13392,85<br><br>
							<label for="name">IVA:</label> Bs. 1607,15<br><br>
							<label for="name">Monto Exento IVA:</label> -<br><br>
							<label for="name">Total Factura:</label> Bs. 15000<br><br>
							<label for="name">Retención IVA:</label> - <br><br>
							<label for="name">Monto a Pagar:</label> Bs. 15000
						</fieldset>						
						<br>
			  		</div>
			  		<div id="tabs-3">
						<fieldset>
							<label for="name">Empresa:</label>Centro Médico Quirúrgico Vidamed<br><br>
							<label for="name">Unidad de Negocio:</label>Compras e Inventario<br><br>
							<label for="name">Clasificación:</label>Urgente<br><br>
							<label for="name">Tipo Proveedor:</label>Proveedores<br><br>
							<label for="name">Beneficiario Pago:</label>Vidamed C.A<br><br>
						</fieldset>	
						<br>	
					</div>
			  	</div>
			  	<div id="botonera">
			  		<form action="ListAccountsServlet#tabs-2">
						<div id="botonV" style="display: inline; margin-left: 40px;">
								<input type="submit" class="button" value="Regresar" />		
						</div>
					</form>	
				</div>
			</div>
		</div>
	</body>
</html>