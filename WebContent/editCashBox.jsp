<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%@ page import="domain.CashBox" %>
<%@ page import="domain.CashBoxSalePoint" %>
<%@ page import="java.util.ArrayList" %>
<%
CashBox cb = (CashBox) request.getAttribute("cashBox");
@SuppressWarnings("unchecked")
ArrayList<CashBoxSalePoint> cbSalePoints = (ArrayList<CashBoxSalePoint>)request.getAttribute("cbSalePoints");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Caja</title>
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
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	   	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, <%= name %></a></li>
                <li><a href="ListAdmissionDischargesServlet">Altas Admisi�n<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li>
		 		<li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li>
		 		<li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListCashBoxesServlet">Ver Cajas</a></li>
            	<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Editar Caja:</h2>
				<br>
				<form action="EditCashBoxServlet">
					<input type="hidden" id="cashBoxID" name="cashBoxID" value="<%= cb.getCashBoxID() %>" />
					<fieldset>
						<label for="name">Nombre:</label>
						<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="<%= cb.getName() %>" /> <br><br>
						<label for="name">Descripci�n:</label>
						<textarea name="txtDescription" id="txtDescription" rows="3" cols="50"><%= cb.getDescription() %></textarea> <br><br>
						<label for="name">Punto de Venta:</label>
						<% 	for (int i = 0; i<cbSalePoints.size(); i++) {
								CashBoxSalePoint cbsp = cbSalePoints.get(i);
						%>
								<div id="otherSellPoint<%= i %>">
									<input type="hidden" id="txtSalePointID<%= i %>" name="txtSalePointID<%= i %>" value="<%= cbsp.getSalePointID() %>" />
									<input type="text" id="txtNameSP<%= i %>" name="txtNameSP<%= i %>" style="width: 135px;" value="<%= cbsp.getName() %>" > % Comisi�n: <input type="text" id="txtCommission<%= i %>" name="txtCommission<%= i %>" value="<%= cbsp.getCommission() %>" style="width: 135px;"> % ISLR: <input type="text" id="txtIslrPercentage<%= i %>" name="txtIslrPercentage<%= i %>" value="<%= cbsp.getIslrPercentage() %>" style="width: 135px;">
				  	 				<% 	if (i == 0) { %>
				  	 						<img alt="logo" src="./images/add.png"  id="addSellPoint" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro punto" />
									<% 	}
						  	 		   	else { 
						  	 		%>
						  	 				<img alt="logo" src="./images/close.png"  id="deleteSellPoint<%= i %>" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Eliminar punto" />
									<%	} %>
									<br /><br />
								</div>
						<% 	} 
							for (int j = cbSalePoints.size(); j<4; j++) {
						%>
									<div id="otherSellPoint<%= j %>" <%= j == 0 ? "" : "style=\"display:none;\"" %>>
										<input type="text" id="txtNameSP<%= j %>" name="txtNameSP<%= j %>" style="width: 135px;" value="" > % Comisi�n: <input type="text" id="txtCommission<%= j %>" name="txtCommission<%= j %>" value="" style="width: 135px;"> % ISLR: <input type="text" id="txtIslrPercentage<%= j %>" name="txtIslrPercentage<%= j %>" value="" style="width: 135px;">
				  	 					<% 	if (j == 0) { %>
				  	 							<img alt="logo" src="./images/add.png"  id="addSellPoint" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro punto" />
										<% 	}
						  	 		   		else { 
						  	 			%>
						  	 					<img alt="logo" src="./images/close.png"  id="deleteSellPoint<%= j %>" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Eliminar punto" />
										<%	} %>
										<br /><br />
									</div>
						<%	} %>
					</fieldset>
					<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
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