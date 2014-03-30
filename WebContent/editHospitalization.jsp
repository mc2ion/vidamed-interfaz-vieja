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
		<title>Editar Hospitalizaci�n</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript"  src="./js/jquery.leanModal.min.js"></script>
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
                <li><a href="ListAdmissionDischargesServlet">Altas Admisi�n<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
				<ul>
            		<li class="menuitem"><a href="ListHospitalizationsServlet">Ver Hospitalizaciones</a></li>
           		</ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Editar Hospitalizaci�n:</h2>
				<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					</ul>
  					<div id="tabs-1">
  						<div id="hosp">
  							<p><b>C�dula:</b> <span style="margin-left:115px;">V-12345678</span>  </p>
  							<p><b>Nombre:</b> <span style="margin-left:107px;"> Ana Rojas</span> </p>
							<p><b>Fecha de Ingreso:  </b> <span style="margin-left:48px;">20/06/2013 07:35 AM  <br></span> </p>
							</div>
							<fieldset>
								<label>Unidad: </label>
							   <input type="text" name="departament" id="departament" value="Cirug�a" readonly>
							    <br><br>
							   <label>M�dico Tratante: </label> <input type="text" name="doctorName" id="doctorName" value="Ricardo Garc�a" readonly>
							    <a href="SearchDoctorServlet?function=editHospitalization" style="color: #f7941e; font-weight: bold;">
									<input type="button"id="doctorId" value="Cambiar" >
								</a> <br><br>
								<label> Ubicaci�n:  </label>
								<input type="text" name="ubication" id="ubication" value="UCI" readonly><br><br>
								 
								<label> Cama:</label>  <input type="text" name="bedId" id="bedId" value="Cama 1" readonly>
								    <a href="SearchBedsServlet?function=editHospitalization" style="color: #f7941e; font-weight: bold;">
										<input type="button"id="bedUbication" value="Cambiar" >
									</a> <br><br>
								
								 <label> Responsable del Pago:</label>  <input type="text" name="insuranceName" id="insuranceName" value="La Previsora" readonly>
								    <a href="SearchInsuranceServlet?function=editHospitalization" style="color: #f7941e; font-weight: bold;">
										<input type="button"id="paymentResp" value="Cambiar" >
									</a> 
						  </fieldset>
						  <div id="botonera" style="margin-top: -3px;">
							<form action="#">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>	
							</form>
						</div>
					</div>
  					<div id="tabs-2">
  						<div style="text-align:right;">
	  						<a href="SearchAdmissionServlet?function=editHospitalization" style="color: #006c92; font-weight: bold;">
								<img alt="logo" src="./images/add.png" height="12" width="12" />Agregar Protocolo
							</a>						
  						</div>
  						<br>
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
				   			<tr>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Acci�n</th>
								</tr>	
					   		<tr>
					   			<td>Colocaci�n de pr�tesis peneana</td>
					   			<td>Bs. 14321,00</td>
					   			<td>
										<a id="go" rel="leanModal" href="#deleteProtocol" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(1001,'Colocaci�n de pr�tesis peneana');" >
											<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
										</a> 
								</td>
					   		</tr>
					   		<tr>
					   			<td>Apendicectom�a</td>
					   			<td>Bs. 7680,00</td>
					   			<td>
									<a id="go" rel="leanModal" href="#deleteProtocol" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(1001,'Apendicectom�a');" >
											<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
									</a>
								</td>
					   		</tr>
					   	</table>
					</div>
  				</div>
			</div>
		</div>
		<div id="deleteProtocol">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Protocolo</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar el protocolo '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="EditHospitalizationServlet#tabs-2" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="deleteService">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Servicio</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar el servicio '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
					<form action="EditHospitalizationServlet#tabs-3" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="deleteSupply">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Suministro</h3>
				<br><br>
				<span>�Est� seguro que desea eliminar el suministro '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="EditHospitalizationServlet#tabs-4" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>		
	</body>
</html>