<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%@ page import="domain.Supply" %>
<%@ page import="domain.SupplyForm" %>
<%@ page import="domain.DoseUnit" %>
<%@ page import="java.util.ArrayList" %>
<%
@SuppressWarnings("unchecked")
ArrayList<SupplyForm> supplyForms = (ArrayList<SupplyForm>)request.getAttribute("supplyForms");
@SuppressWarnings("unchecked")
ArrayList<DoseUnit> doseUnits = (ArrayList<DoseUnit>)request.getAttribute("doseUnits");
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
		<script>
			$(function() {    
            	$('#sbmtButton').click(function(event) { 
            		var patternNumber = new RegExp('^\\d+$');
            		var patternDouble = new RegExp('^[0-9]+(\.[0-9]+)?$');
            		if ($('#txtName').val() == '') {
            			alert("El campo 'Nombre' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#txtType').val() == '0') {
            			alert("Debe seleccionar un valor en el campo 'Tipo'");
            			return;
            		}
            		else if ($('#txtType').val() == '1' && $('#txtActiveComponent').val() == '') {
            			alert("El campo 'Componente Activo' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#txtType').val() == '1' && $('#txtForm').val() == '0') {
            			alert("Debe seleccionar un valor para el campo 'Presentaci�n'");
            			return;
            		}
            		else if ($('#txtAmount').val() == '') {
            			alert("El campo 'Cantidad' no puede ser dejado en blanco");
            			return;
            		}
            		else if (!$('#txtAmount').val().match(patternNumber)) {
            			alert("El valor del campo 'Cantidad' debe ser num�rico. No colocar puntos ni espacios en blanco.");
            			return;
            		}
            		else {
            			$('#form1').submit();
            		}
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
	            	<li class="menuitem"><a href="ListSupplyAreasServlet">Ver �reas Insumos</a></li>
	            	<li class="menuitem"><a href="ListSuppliesServlet?supplyAreaID=<%= supply.getSupplyAreaID() %>">Ver Insumos</a></li>
	            	<li class="menuitem"><a href="CreateSupplyServlet?supplyAreaID=<%= supply.getSupplyAreaID() %>">Crear Insumo</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Editar Insumo:</h2>
				<br>
				<form id="form1" name="form1" action="EditSupplyServlet">
					<input type="hidden" id="supplyID" name="supplyID" value="<%= supply.getSupplyID() %>" />
					<input type="hidden" id="supplyAreaID" name="supplyAreaID" value="<%= supply.getSupplyAreaID() %>" />
					<fieldset>
						<label for="name">Nombre:</label>
						<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="<%= supply.getName() %>"/> <br><br>
						<label for="name">Tipo:</label>
						<select id="txtType" name="txtType" onchange="displayMedicineFields(this);">
							<option value="0">Seleccionar</option>
							<option value="1" <%= supply.getType() == 1 ? "selected" : "" %>>F�rmaco</option>
							<option value="2" <%= supply.getType() == 2 ? "selected" : "" %>>Suministro</option>						
						</select> <br><br>
						<label for="name">Descripci�n:</label>
						<textarea name="txtDescription" id="txtDescription" rows="3" cols="50"><%= supply.getDescription() %></textarea> <br><br>
						<div id="medicine" style="display:<%= supply.getType() == 1 ? "block" : "none" %>;">
							<label for="name">Componente Activo:</label>
							<input type="text" name="txtActiveComponent" id="txtActiveComponent" maxlength="50" size="5" value="<%= supply.getActiveComponent() %>"/> <br><br>
							<label for="name">Dosis:</label>
							<input type="number" name="txtDose" id="txtDose" maxlength="5" size="5" min="0" value="<%= supply.getDose() %>"/> 
							<select id="txtDoseUnit" name="txtDoseUnit">
								<% for (int i = 0; i<doseUnits.size(); i++) {
										DoseUnit d = doseUnits.get(i);
								%>
										<option value="<%= d.getId() %>" <%= supply.getDoseUnitID() != null && supply.getDoseUnitID() == d.getId() ? "selected" : "" %>><%= d.getAbbreviation() %></option>
								<% } %>
							</select> <br><br>
							<label for="name">Presentaci�n:</label>
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
						<label for="name"> </label>
						<input type="checkbox" name="isRegulated" id="isRegulated" value="true" <%= supply.getIsRegulated() == 1 ? "checked" : "" %>> Producto Regulado <br><br>
					</fieldset>
					<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="button" class="button" id="sbmtButton" name="sbmtButton" value="Modificar" />
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