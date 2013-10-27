<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Caja</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />		
		<script>
		$(function() {
				$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });
				$("#addSellPoint").click(function() {
					
					if($('#otherSellPoint').is(':hidden')) {
						$("#otherSellPoint").show();
					} else {
						if($('#otherSellPoint2').is(':hidden')) {
							$("#otherSellPoint2").show();
						} else {
							$("#otherSellPoint3").show();
						}
					}
					
					if($('#otherSellPoint').is(':visible') && $('#otherSellPoint2').is(':visible') && $('#otherSellPoint3').is(':visible')){
						$(this).hide();						
					}
					  
				});
				
				$("#deleteSellPoint").click(function() {
					  $("#otherSellPoint").hide();
					  $("#addSellPoint").show();
				});
				
				$("#deleteSellPoint2").click(function() {
					  $("#otherSellPoint2").hide();
					  $("#addSellPoint").show();
				});
				
				$("#deleteSellPoint3").click(function() {
					  $("#otherSellPoint3").hide();
					  $("#addSellPoint").show();
				});
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
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
				 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Crear Caja:</h2>
				<br>
				<fieldset>
					<label for="name">Nombre:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
					<label for="name">Descripción:</label>
					<textarea name="txtDescription" id="txtDescription" rows="3" cols="50"></textarea> <br><br>
					<label for="name">Punto de Venta:</label>
					<div >
				  	 	<input type="text" value="" style="width: 135px;"> % Comisión: <input type="text" value="" style="width: 135px;"> % ISLR: <input type="text" value="" style="width: 135px;"> 
				  	 	<img alt="logo" src="./images/add.png"  id="addSellPoint" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro punto" />
						<br /><br />
					</div>
					<div id="otherSellPoint" style="display:none;">
						<input type="text" value="" style="width: 135px;"> % Comisión: <input type="text" value="" style="width: 135px;"> % ISLR: <input type="text" value="" style="width: 135px;"> 
						<img alt="logo" src="./images/close.png"  id="deleteSellPoint" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro punto" />
				 		<br /><br />
				 	</div>
					<div id="otherSellPoint2" style="display:none;">
						<input type="text" value="" style="width: 135px;"> % Comisión: <input type="text" value="" style="width: 135px;"> % ISLR: <input type="text" value="" style="width: 135px;"> 
						<img alt="logo" src="./images/close.png"  id="deleteSellPoint2" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro punto" />
				  	 	<br /><br />
				  	 </div>
					 <div id="otherSellPoint3" style="display:none;">
					  	 <input type="text" value="" style="width: 135px;"> % Comisión: <input type="text" value="" style="width: 135px;"> % ISLR: <input type="text" value="" style="width: 135px;">  
					  	 <img alt="logo" src="./images/close.png"  id="deleteSellPoint3" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro punto" />				
				  	 </div>
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