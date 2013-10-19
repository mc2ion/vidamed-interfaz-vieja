<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Altas Farmacia Pendientes</title>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
  	<script src="./js/jquery-1.9.1.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<link rel="stylesheet" href="/resources/demos/style.css" />
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
        	<img alt="logo" src="./images/logo.png"/>
        </div>  
        <nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="pendingAdmissionDischarges.jsp">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="pendingCreditNotes.jsp">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="pendingCreditNotesReview.jsp">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="pendingInvoices.jsp">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="pendingRequest.jsp">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="pendingPharmacyDischarges.jsp">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="billing.jsp">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>       
		 <div id="menu">
			<div class="menuitemHome" ><a href="mainMenu.jsp">Home</a></div>	
			<ul>
            	<li class="menuitem"><a href="supplyAreas.jsp">Ver Áreas Insumos</a></li>
            	<li class="menuitem"><a href="pendingPharmacyDischarges.jsp">Ver Altas Pendientes</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content" style="position:absolute;">	
	        	<h2>Ver Detalle Alta Pendiente:</h2><br>
	        	<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					</ul>
  					<div id="tabs-1">
  						<br>
					    <b> Cédula: </b> V-12345678<br><br>
					    <b>Nombre: </b>  Ana Rojas<br><br>
					  	<fieldset>
					    <label> Unidad: </label>
					    <input type="text" name="departament" id="departament" value="Nutrición" readonly>
					    <br><br>
					   <label>Médico Tratante: </label> <input type="text" name="doctorName" id="doctorName" value="Ricardo García" readonly>
					    <a href="searchDoctor.jsp?function=editPharmacyEstimation" style="color: #f7941e; font-weight: bold;">
							<input type="button"id="doctorId" value="Cambiar" >
						</a> <br><br>
					   <label> Responsable del Pago:</label>  <input type="text" name="insuranceName" id="insuranceName" value="La Previsora" readonly>
					    <a href="searchInsurance.jsp?function=editPharmacyEstimation" style="color: #f7941e; font-weight: bold;">
							<input type="button"id="paymentResp" value="Cambiar" >
						</a> 
					    </fieldset>
					    <div id="botonera" >
							<form action="#">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
								</div>	
							</form>
						</div>
					    <br>
					</div>
  					<div id="tabs-2">
  						<div style="text-align:right;">
	  						<a href="searchadmission.jsp?function=editPharmacyEstimation" style="color: #006c92; font-weight: bold;">
								<img alt="logo" src="./images/add.png" height="12" width="12" />Agregar Protocolo
							</a>						
  						</div>
  						<br>
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
				   			<tr>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Acción</th>
								</tr>	
					   		<tr>
					   			<td>Frenuloplastia</td>
					   			<td>Bs. 14321,00</td>
					   			<td>
					   				<a href="editPharmacyProtocol.jsp" style="color: transparent" >
										<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar Protocolo" />
									</a>
										<a id="go" rel="leanModal" href="#deleteProtocol" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(1001,'Colocación de prótesis peneana');" >
											<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
										</a> 
								</td>
					   		</tr>
					   		<tr>
					   			<td>Apendicectomía</td>
					   			<td>Bs. 7680,00</td>
					   			<td>
					   				<a href="#" style="color: transparent" >
										<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar Protocolo" />
									</a>
									<a id="go" rel="leanModal" href="#deleteProtocol" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars(1001,'Apendicectomía');" >
											<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
									</a>
								</td>
					   		</tr>
					   		<tr style="background: rgb(196, 196, 196);">
					   			<td >Sub-total:</td>
					   			<td>Bs. 22001</td>
								<td></td>
							</tr>
					   		<tr style="background: rgb(196, 196, 196);">
					   			<td >Descuento aplicado:</td>
					   			<td>Bs. 1500</td>
								<td></td>
							</tr>
					   		<tr style="background: rgb(136, 162, 190);">
					   			<td >Total</td>
					   			<td>Bs.20501 </td>
								<td></td>
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
				<span>¿Está seguro que desea eliminar el protocolo '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"   name="sbmtButton" value="Aceptar"  />
				</div>
			</div>
		</div>
		<div id="deleteService">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Servicio</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el servicio '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"  name="sbmtButton" value="Aceptar"  />
				</div>
			</div>
		</div>
		
		<div id="payment-resp">
			<div id="a">
				<h3 id="see_id" class="sprited" > Escoger responsable de pago</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el servicio '<span class="cliente"></span>'? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
				</div>
			</div>
		</div>
	</body>
</html>