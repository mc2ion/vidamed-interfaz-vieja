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
		<title>Ver Presupuesto</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
		<script type="text/javascript">
		var idUser;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
		});
		
		function loadVars(var1, var2) {
			idUser = var1;
			$('.cliente').text(var2);
			
		};
		
		function setV(f){
			f.elements['userId'].value = idUser;
			return true;
		}
		</script>
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	   	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, <%= name %></a></li>
                <li><a href="ListAdmissionDischargesServlet">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Presupuesto:</h2>
				<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					    <li><a href="#tabs-3">Servicios</a></li>
			  		</ul>
  					<div id="tabs-1">
  						<br>
					    <p>
					    Cédula: V-12345678<br><br>
					    Nombre: Ana Rojas<br><br>
					    Médico Tratante: Ricardo García<br><br>
					    Unidad: Cirugía<br><br>
					    Responsable del Pago: La Previsora<br><br>
					    </p>
  					</div>
  					<div id="tabs-2">
  						<br>
					    <p>
					    * Histerectomía<br><br>
					    * Colecistectomía<br><br>
					    * Apendicectomía<br><br>
					    </p>
  					</div>
  					<div id="tabs-3">
  						<br>
					    <table id="sweetTable">
							<tbody>
								<tr>
									<th>Servicio</th>
									<th>Precio</th>
								</tr>				
								<tr>
									<td>Hospitalización</td>
									<td>Bs 3472,00</td>
								</tr>				
								<tr>
									<td>Anestesia Peridural</td>
									<td>Bs 2727,50</td>
								</tr>				
								<tr>
									<td>Servicios Médicos</td>
									<td>Bs 1021,90</td>
								</tr>				
								<tr id="totalTr">
									<td>*** MONTO TOTAL ***</td>
									<td>Bs 7221,40</td>
								</tr>
							</tbody>
						</table>
						<br>
					</div>
				</div>
				<div id="botonera">
				<form>
					<div id="botonV" >
							<input type="button" class="button" value="Regresar" style="margin-left:40%;" onClick="javascript:history.back();" style="margin-left:40%;" />		
					</div>	
				</form>
			</div>	
			</div>
		</div>
		<div id="refreshUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Actualizar Presupuesto</h3>
				<br><br>
				<span>¿Desea actualizar fecha y costos del presupuesto seleccionado? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListEstimationsServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>