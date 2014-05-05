<%@ page import="domain.SupplyForm" %>
<%@ page import="java.util.ArrayList" %>
<%
@SuppressWarnings("unchecked")
ArrayList<SupplyForm> supplyForms = (ArrayList<SupplyForm>)request.getAttribute("supplyForms");
Long supplyAreaID = (Long) request.getAttribute("supplyAreaID");
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
		<title>Crear Insumo</title>
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
	            	<li class="menuitem"><a href="ListSupplyAreasServlet" >Ver Áreas Insumos</a></li>
	            	<li class="menuitem"><a href="ListSuppliesServlet?supplyAreaID=<%= supplyAreaID %>" style="margin-left:10px;">Ver Insumos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Crear Insumo:</h2>
				<br>
				<form action="CreateSupplyServlet">
					<input type="hidden" id="suplyAreaID" name="supplyAreaID" value="<%= supplyAreaID %>" />
					<fieldset>
						<label for="name">Nombre:</label>
						<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
						<label for="name">Tipo:</label>
						<select id="txtType" name="txtType" onchange="displayMedicineFields(this);">
							<option value="0" selected>Seleccionar</option>
							<option value="1">Fármaco</option>
							<option value="2">Suministro</option>						
						</select> <br><br>
						<label for="name">Descripción:</label>
						<textarea name="txtDescription" id="txtDescription" rows="3" cols="50"></textarea> <br><br>
						<div id="medicine" style="display:none;">
							<label for="name">Componente Activo:</label>
							<input type="text" name="txtActiveComponent" id="txtActiveComponent" maxlength="50" size="5"/> <br><br>
							<label for="name">Fabricante:</label>
							<input type="text" name="txtManufacturer" id="txtManufacturer" maxlength="50" size="5"/> <br><br>
						
							<label for="name">Presentación:</label>
							<select id="txtForm" name="txtForm">
								<option value="0" selected>Seleccionar</option>
								<% for (int i = 0; i<supplyForms.size(); i++) {
										SupplyForm sf = supplyForms.get(i);
								%>
										<option value="<%= sf.getSupplyFormID() %>"><%= sf.getName() %></option>
								<% } %>
							</select> <br><br>
						</div>
						<label for="name">Cantidad:</label>
						<input type="number" min="1" name="txtAmount" id="txtAmount" maxlength="3" size="3" /> <br><br>
						<label for="name">Precio Unitario:</label>
						<input type="number" min="1" name="txtUnitPrice" id="txtUnitPrice" maxlength="3" size="3" /> <br><br>
						<label for="name"> </label>
						<input type="checkbox" name="isRegulated" id="isRegulated" value="true"> Producto Regulado <br><br>
					</fieldset>
					<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
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