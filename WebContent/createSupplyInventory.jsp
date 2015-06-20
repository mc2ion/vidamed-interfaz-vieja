<%@ page import="domain.SupplyProvider" %>
<%@ page import="java.util.ArrayList" %>
<%
@SuppressWarnings("unchecked")
ArrayList<SupplyProvider> supplyProviders = (ArrayList<SupplyProvider>)request.getAttribute("supplyProviders");
Long supplyAreaID = (Long) request.getAttribute("supplyAreaID");
Long supplyID = (Long) request.getAttribute("supplyID");
%>
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
		<title>Crear Inventario</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$.datepicker.setDefaults($.datepicker.regional['es']);
				$('#txtExpirationDate').datepicker({
					showOn: "button",
					buttonImage: "images/calendar.png",
					buttonImageOnly: true,
					buttonText: "Seleccione una fecha",
					dateFormat:'dd/mm/yy',
					changeMonth: true,
				    changeYear: true,
				    yearRange: "-100:+20"
				});
			} );
		</script>
		<script>
		$( document ).ready(function() {
			$( "#txtBoxes" ).keyup(function() {
				index = $(this).val();
				index2 = $( "#txtAmountPerBox" ).val();
				$( "#txtAmount" ).text(index*index2);
			});
			
			$( "#txtAmountPerBox" ).keyup(function() {
				index = $(this).val();
				index2 = $( "#txtBoxes" ).val();
				$( "#txtAmount" ).text(index*index2);
			});
			
			$("#txtPurchasePrice").keyup(function(){
				index = $(this).val();
				$("#txtSalePrice").val(index*1.30);
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
	            	<li class="menuitem"><a href="ListSupplyAreasServlet" >Ver Áreas Insumos</a></li>
	            	<li class="menuitem"><a href="ListSuppliesServlet?supplyAreaID=<%= supplyAreaID %>" style="margin-left:10px;">Ver Insumos</a></li>
	            	<li class="menuitem"><a href="ListSupplyInventoriesServlet?supplyAreaID=<%= supplyAreaID %>&supplyID=<%= supplyID %>" style="margin-left:10px;">Ver Inventarios</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Crear Inventario:</h2>
				<br>
				<form action="CreateSupplyInventoryServlet" method="post">
					<input type="hidden" id="supplyAreaID" name="supplyAreaID" value="<%= supplyAreaID %>" />
					<input type="hidden" id="supplyID" name="supplyID" value="<%= supplyID %>" />
					<fieldset>
						<label for="name">Fabricante:</label>
						<input type="text" name="txtManufacturer" id="txtManufacturer" maxlength="50" size="5" required/> <br><br>
						<label for="name">N&uacute;mero de Cajas:</label>
						<input type="number" name="txtBoxes" id="txtBoxes" min="1" step="1" required/> <br><br>
						<label for="name">N&uacute;mero de Dosis por Caja:</label>
						<input type="number" name="txtAmountPerBox" id="txtAmountPerBox" min="1" step="1" required/> <br><br>
						<label for="name">Cantidad:</label>
						<label id="txtAmount"></label><br><br>
						<label for="name">Precio de Compra:</label>
						<input type="number" name="txtPurchasePrice" id="txtPurchasePrice" step="0.01" required/> <br><br>
						<label for="name">Precio de Venta:</label>
						<input type="number" name="txtSalePrice" id="txtSalePrice" step="0.01" required readonly/> <br><br>
						<label for="name">Proveedor:</label>
						<select id="txtProvider" name="txtProvider">
							<% for (int i = 0; i<supplyProviders.size(); i++) {
									SupplyProvider p = supplyProviders.get(i);
							%>
									<option value="<%= p.getProviderID() %>"><%= p.getName() %></option>
							<% } %>
						</select> <br><br>
						<label for="name">Número de Lote:</label>
						<input type="text" name="txtLotNumber" id="txtLotNumber" maxlength="50" size="50" required/> <br><br>
						<label for="name">Fecha de Vencimiento:</label>
						<input type="text" name="txtExpirationDate" id="txtExpirationDate" maxlength="50" size="10" required/> <br><br>
					</fieldset>
					<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="submit" class="button" id="sbmtButton" name="sbmtButton" value="Agregar" />
						</div>	
						<div id="botonV" style="display: inline;">
							<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</div>
				</form>
			</div>
		</div>
	</body>
</html>