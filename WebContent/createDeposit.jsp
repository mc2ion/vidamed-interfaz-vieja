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
		<title>Registrar Pago</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />		
		<script>
		function findPatient(){
			div1 = document.getElementById('patient');
			div1.style.display = "block";
		}
		
		function displayPaymentFields(combo) {
			sel = combo.options[combo.selectedIndex].value;
			bank = document.getElementById('bank');
			check = document.getElementById('check');
			sellPoint = document.getElementById('sellPoint');
			insurance = document.getElementById('insurance');
			
			if(sel == 1 || sel == 0){
				bank.style.display = "none";
				check.style.display = "none";
				sellPoint.style.display = "none";
				insurance.style.display = "none";
			} else if(sel == 2 || sel == 3){
				bank.style.display = "block";
				check.style.display = "none";
				sellPoint.style.display = "block";
				insurance.style.display = "none";
			} else if(sel == 4){
				bank.style.display = "block";
				check.style.display = "block";
				sellPoint.style.display = "none";
				insurance.style.display = "none";
			} else if(sel == 5){
				bank.style.display = "none";
				check.style.display = "none";
				sellPoint.style.display = "none";
				insurance.style.display = "block";
			}
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
		    	<ul>
	            	<li class="menuitem"><a href="ListBanksServlet">Ver Cajas</a></li>
            		<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Registrar Deposito:</h2>
				<br>
				<fieldset>
					<label for="name">Fecha de la transacción:</label>
					<input type="text" style="width: 135px;"> <br><br>
					<div id="bank">
						<label for="name">Banco Receptor:</label>
						<select>
							<option value="0">Seleccionar</option>
							<option value="5">Banco Bicentenario</option>
							<option value="4">Banco Mercantil</option>
							<option value="3">Banco Provincial</option>
							<option value="1">Banco Venezuela</option>
							<option value="2">Banesco</option>
						</select> <br><br>
					</div>
					<label for="name">N° de Planilla:</label>
					<input type="text" style="width: 135px;"> <br><br>
					
					<label for="name">Monto Efectivo:</label>
					<input type="text" value="" style="width: 135px;"> <br><br>
					
					<label for="name">Monto Cheques:</label>
					<input type="text" value="" style="width: 135px;"> <br><br>
					
					<label for="name">Monto Total:</label>
					<input type="text" value="" style="width: 135px;"> <br><br>
					
				</fieldset>
				<div id="botonera">
					<form action="ListBanksServlet">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</form>
				</div><br>
			</div>
		</div>
	</body>
</html>