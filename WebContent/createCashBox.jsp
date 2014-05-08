<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%><!DOCTYPE HTML>
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
					
					if($('#otherSellPoint1').is(':hidden')) {
						$("#otherSellPoint1").show();
					} else {
						if($('#otherSellPoint2').is(':hidden')) {
							$("#otherSellPoint2").show();
						} else {
							$("#otherSellPoint3").show();
						}
					}
					
					if($('#otherSellPoint1').is(':visible') && $('#otherSellPoint2').is(':visible') && $('#otherSellPoint3').is(':visible')){
						$(this).hide();						
					}
					  
				});
				
				$("#deleteSellPoint1").click(function() {
					  $("#otherSellPoin1t").hide();
					  $("#addSellPoint").show();
					  $("#txtNameSP1").val("");
					  $("#txtCommission1").val("");
					  $("#txtIslrPercentage1").val("");
				});
				
				$("#deleteSellPoint2").click(function() {
					  $("#otherSellPoint2").hide();
					  $("#addSellPoint").show();
					  $("#txtNameSP2").val("");
					  $("#txtCommission2").val("");
					  $("#txtIslrPercentage2").val("");
				});
				
				$("#deleteSellPoint3").click(function() {
					  $("#otherSellPoint3").hide();
					  $("#addSellPoint").show();
					  $("#txtNameSP3").val("");
					  $("#txtCommission3").val("");
					  $("#txtIslrPercentage3").val("");
				});
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
		    	<ul>
	            	<li class="menuitem"><a href="ListCashBoxesServlet">Ver Cajas</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
				 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Crear Caja:</h2>
				<br>
				<form action="CreateCashBoxServlet">
					<fieldset>
						<label for="name">Nombre:</label>
						<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
						<label for="name">Descripción:</label>
						<textarea name="txtDescription" id="txtDescription" rows="3" cols="50"></textarea> <br><br>
						<label for="name">Punto de Venta:</label>
						<div >
				  	 		<input type="text" id="txtNameSP0" name="txtNameSP0" value="" style="width: 135px;"> % Comisión: <input type="text" id="txtCommission0" name="txtCommission0" value="" style="width: 135px;"> % ISLR: <input type="text" id="txtIslrPercentage0" name="txtIslrPercentage0" value="" style="width: 135px;"> 
				  	 		<img alt="logo" src="./images/add.png"  id="addSellPoint" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro punto" />
							<br /><br />
						</div>
						<% 	for (int i = 1; i<4; i++) { %>
								<div id="otherSellPoint<%= i %>" style="display:none;">
									<input type="text" id="txtNameSP<%= i %>" name="txtNameSP<%= i %>" value="" style="width: 135px;"> % Comisión: <input type="text" id="txtCommission<%= i %>" name="txtCommission<%= i %>" value="" style="width: 135px;"> % ISLR: <input type="text" id="txtIslrPercentage<%= i %>" name="txtIslrPercentage<%= i %>" value="" style="width: 135px;"> 
									<img alt="logo" src="./images/close.png"  id="deleteSellPoint<%= i %>" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Eliminar punto" />
				 					<br /><br />
				 				</div>
				 		<% 	} %>
					</fieldset>
					<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
						</div>	
						<div id="botonV" style="display: inline;">
							<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>
					</div><br>
				</form>
			</div>
		</div>
	</body>
</html>