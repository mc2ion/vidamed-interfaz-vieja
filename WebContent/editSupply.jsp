<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%@ page import="domain.Supply" %>
<%@ page import="domain.SupplyForm" %>
<%@ page import="java.util.ArrayList" %>
<%
@SuppressWarnings("unchecked")
ArrayList<SupplyForm> supplyForms = (ArrayList<SupplyForm>)request.getAttribute("supplyForms");
Supply supply = (Supply) request.getAttribute("supply");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Insumo</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />	
		<script>	
		function displayMedicineFields(combo) {
			sel = combo.options[combo.selectedIndex].value;
			medicine = document.getElementById('medicine');
			
			if(sel == 1){
				medicine.style.display = "block";
			} else {
				medicine.style.display = "none";
			}
		}
		</script>	
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="ListSupplyAreasServlet">Ver Áreas Insumos</a></li>
	            	<li class="menuitem"><a href="ListSuppliesServlet?supplyAreaID=<%= supply.getSupplyAreaID() %>">Ver Insumos</a></li>
	            	<li class="menuitem"><a href="CreateSupplyServlet?supplyAreaID=<%= supply.getSupplyAreaID() %>">Crear Insumo</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Editar Insumo:</h2>
				<br>
				<form action="EditSupplyServlet">
					<input type="hidden" id="supplyID" name="supplyID" value="<%= supply.getSupplyID() %>" />
					<input type="hidden" id="supplyAreaID" name="supplyAreaID" value="<%= supply.getSupplyAreaID() %>" />
					<fieldset>
						<label for="name">Nombre:</label>
						<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="<%= supply.getName() %>"/> <br><br>
						<label for="name">Tipo:</label>
						<select id="txtType" name="txtType" onchange="displayMedicineFields(this);">
							<option value="0">Seleccionar</option>
							<option value="1" <%= supply.getType() == 1 ? "selected" : "" %>>Fármaco</option>
							<option value="2" <%= supply.getType() == 2 ? "selected" : "" %>>Suministro</option>						
						</select> <br><br>
						<label for="name">Descripción:</label>
						<textarea name="txtDescription" id="txtDescription" rows="3" cols="50"><%= supply.getDescription() %></textarea> <br><br>
						<div id="medicine" style="display:<%= supply.getType() == 1 ? "block" : "none" %>;">
							<label for="name">Componente Activo:</label>
							<input type="text" name="txtActiveComponent" id="txtActiveComponent" maxlength="50" size="5" value="<%= supply.getActiveComponent() %>"/> <br><br>
							<label for="name">Fabricante:</label>
							<input type="text" name="txtManufacturer" id="txtManufacturer" maxlength="50" size="5" value="<%= supply.getManufacturer() %>"/> <br><br>
							<label for="name">Presentación:</label>
							<select id="txtForm" name="txtForm">
								<option value="0" <%= supply.getSupplyFormID() == null ? "selected" : "" %>>Seleccionar</option>
								<% for (int i = 0; i<supplyForms.size(); i++) {
										SupplyForm sf = supplyForms.get(i);	
								%>
										<option value="<%= sf.getSupplyFormID() %>" <%= supply.getSupplyFormID() != null && supply.getSupplyFormID() == sf.getSupplyFormID() ? "selected" : "" %>><%= sf.getName() %></option>	
								<% } %>
							</select> <br><br>
						</div>
						<label for="name">Cantidad:</label>
						<input type="number" min="1" name="txtAmount" id="txtAmount" maxlength="3" size="3" value="<%= supply.getAmount() %>" /> <br><br>
						<label for="name">Precio Unitario:</label>
						<input type="number" min="1" name="txtUnitPrice" id="txtUnitPrice" maxlength="3" size="3" value="<%= supply.getUnitPrice() %>" /> <br><br>
						<label for="name"> </label>
						<input type="checkbox" name="isRegulated" id="isRegulated" value="true" <%= supply.getIsRegulated() == 1 ? "checked" : "" %>> Producto Regulado <br><br>
					</fieldset>
					<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
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