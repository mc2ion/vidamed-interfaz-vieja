<%@page import="domain.SupplyArea"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%@page import="domain.Supply"%>
<%@page import="domain.SupplyInventory"%>
<%@page import="domain.ProtocolScale"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	

	@SuppressWarnings("unchecked")
	ArrayList<SupplyArea> sArea = (ArrayList<SupplyArea>)request.getAttribute("supplyArea");
	@SuppressWarnings("unchecked")
	ArrayList<ProtocolScale> pScale = (ArrayList<ProtocolScale>)request.getAttribute("protocolScale");
		
	String adminId 	= (String) request.getAttribute("adminId");
	String patName 	= (String) request.getAttribute("name");
	String sec = (String) request.getAttribute("sec");
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Agregar Suministro</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>	
		<script type="text/javascript" src="./js/functions.js"></script>
		<script>
		$( document ).ready(function() {
			$( ".target" ).change(function() {
				index = $(this).val();
				if (index != "-"){
					$('.sum-div').show();
					$.ajax({
						type: "GET",
						url: "GetSuppliesServlet",
						data: {category: index },
						success: function(data){
							$("#state").html(data);
						}
					});
				}else{
					$('.sum-div').hide();
				}
			});
			
			$( ".target2" ).change(function() {
				index = $(this).val();
				if (index != "-"){
					$.ajax({
						type: "GET",
						url: "GetSupplyInventoriesServlet",
						data: {category: index },
						success: function(data){
							$("#inventory").html(data);
						}
					});
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
		    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">
        	<%
        		if(sec!=null && sec.equalsIgnoreCase("add")){
        			Supply s = (Supply)request.getAttribute("supply");
        			ArrayList<SupplyInventory> si = (ArrayList<SupplyInventory>)request.getAttribute("supplyInventories");
        			Long amount = (Long)request.getAttribute("amount");
        			Long scaleId = (Long)request.getAttribute("scaleId");
        	%>
           		<h2>Agregar Suministro:</h2> <br><br>
	        	<form action="AddPatientSupplyServlet" method="post" >
				<input type="hidden" name="admissionId" value="<%= adminId %>"/>
				<input type="hidden" name="name" value="<%= patName %>"/>
				<input type="hidden" name="sec" value="<%= sec %>"/>
				<input type="hidden" name="scaleId" value="<%= scaleId %>"/>
				<input type="hidden" name="supplyId" value="<%= s.getSupplyID() %>"/>
				<fieldset>
	        		<label>Área del suministro: </label>
					<span><%= s.getSupplyAreaName() %></span>
					<br/><br/>
					<label for="pname">Suministro:</label>
					<span><%= s.getName() %></span>
					<br/><br/>
					<label for="pname">Inventario:</label>
					<select name="inventory" id="inventory" required title="Debe seleccionar un valor en el campo 'Inventario'">
						<option value="">Seleccionar</option>
					<%
						for(int i = 0; i < si.size() ;i++){
							SupplyInventory in = si.get(i);
					%>
						<option value="<%= in.getSupplyInventoryID() %>"><%= in.getManufacturer() + " - " + in.getLotNumber() + " - " + in.getExpirationDate() %></option>
					<%
						}
					%>
					</select><br/><br/>
					<label>Cantidad:</label>
					<input type="number" name="amount" max="<%= amount %>" value="<%= amount %>" style="width:60px;" required title="El campo 'cantidad' debe ser numérico y no puede ser dejado en blanco" />
			   </fieldset>
				<br/>
				 <div id="botonera" style="margin-top: -3px;">
					<div id="botonP">
							<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
							<input type="button" style="margin-left: 15px;" class="button" value="Cancelar" onClick="javascript:history.back();" />		
					</div>	
				</div>
				</form>
           	<%		
        		}else if(sec!=null && sec.equalsIgnoreCase("replace")){
        			Supply s = (Supply)request.getAttribute("supply");
        			Long amount = (Long)request.getAttribute("amount");
        			Long scaleId = (Long)request.getAttribute("scaleId");
        	%>
        		<h2>Reemplazar Suministro:</h2> <br><br>
        		<form action="AddPatientSupplyServlet" method="post" >
				<input type="hidden" name="admissionId" value="<%= adminId %>"/>
				<input type="hidden" name="name" value="<%= patName %>"/>
				<input type="hidden" name="sec" value="<%= sec %>"/>
				<input type="hidden" name="scaleId" value="<%= scaleId %>"/>
				<input type="hidden" name="supplyId" value="<%= s.getSupplyID() %>"/>
				<fieldset>
	        		<label>Área del suministro: </label>
					<span><%= s.getSupplyAreaName() %></span>
					<br/><br/>
					<label for="pname">Suministro:</label>
					<span><%= s.getName() %></span>
					<br/><br/>
					<label>Cantidad:</label>
					<input type="number" name="amount" max="<%= amount %>" value="<%= amount %>" style="width:60px;" required title="El campo 'cantidad' debe ser numérico y no puede ser dejado en blanco" />
			   </fieldset>
			   <br><h2>Por:</h2><br>
			   <fieldset>
	        		<label>Área del suministro: </label>
					<select name="supplyArea" id="supplyArea" class="target" required title="Debe seleccionar un valor en el campo 'Área del Suministro'">	
						<option value=""> Seleccionar </option>
						<% for (int i = 0; i < sArea.size(); i++){ 
						%>
							<option value="<%= sArea.get(i).getSupplyAreaID() %>"><%= sArea.get(i).getName() %></option>
						<% } %>
					</select>
					<br/><br/>
					<p style="display: none;" class="sum-div">
						<label for="pname">Suministro:</label>
						<select name="state" id="state" class="target2" required title="Debe seleccionar un valor en el campo 'Suministro'">
							<option value="">Seleccionar</option>
						</select><br/><br/>
						<label for="pname">Inventario:</label>
						<select name="inventory" id="inventory" required title="Debe seleccionar un valor en el campo 'Inventario'">
							<option value="">Seleccionar</option>
						</select><br/><br/>
						<label>Cantidad:</label>
						<input type="number" name="amountReplaced" style="width:60px;" required title="El campo 'cantidad' debe ser numérico y no puede ser dejado en blanco" />
					</p>   
					
				</fieldset>
				<br/>
				 <div id="botonera" style="margin-top: -3px;">
					<div id="botonP">
							<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
							<input type="button" style="margin-left: 15px;" class="button" value="Cancelar" onClick="javascript:history.back();" />		
					</div>	
				</div>
				</form>
        	<%		
        		}else{
        	%>
        		<h2>Agregar Suministro:</h2> <br><br>
	        	<p>Por favor, escoja el área del suministro y haga clic en "Siguiente".</p><br>
	        	<form action="AddPatientSupplyServlet" method="post" >
				<input type="hidden" name="admissionId" value="<%= adminId %>"/>
				<input type="hidden" name="name" value="<%= patName %>"/>
				<input type="hidden" name="sec" value="<%= sec %>"/>
				<fieldset>
					<label>Ítem de Protocolo Asociado: </label>
					<select name="scaleId" id="scaleId" class="target" required title="Debe seleccionar un valor en el campo 'Ítem de Protocolo Asociado'">	
						<option value=""> Seleccionar </option>
						<% for (int i = 0; i < pScale.size(); i++){ 
						%>
							<option value="<%= pScale.get(i).getProtocolScaleID() %>"><%= pScale.get(i).getBussinessRuleMicroName() + " - " + pScale.get(i).getName() %></option>
						<% } %>
					</select>
					<br/><br/>
	        		<label>Área del suministro: </label>
					<select name="supplyArea" id="supplyArea" class="target" required title="Debe seleccionar un valor en el campo 'Área del Suministro'">	
						<option value=""> Seleccionar </option>
						<% for (int i = 0; i < sArea.size(); i++){ 
						%>
							<option value="<%= sArea.get(i).getSupplyAreaID() %>"><%= sArea.get(i).getName() %></option>
						<% } %>
					</select>
					<br/><br/>
					<p style="display: none;" class="sum-div">
						<label for="pname">Suministro:</label>
						<select name="state" id="state" class="target2" required title="Debe seleccionar un valor en el campo 'Suministro'">
							<option value="">Seleccionar</option>
						</select><br/><br/>
						<label for="pname">Inventario:</label>
						<select name="inventory" id="inventory" required title="Debe seleccionar un valor en el campo 'Inventario'">
							<option value="">Seleccionar</option>
						</select><br/><br/>
						<label>Cantidad:</label>
						<input type="number" name="amount" style="width:60px;" required title="El campo 'cantidad' debe ser numérico y no puede ser dejado en blanco" />
					</p>   
					
				</fieldset>
				<br/>
				 <div id="botonera" style="margin-top: -3px;">
					<div id="botonP">
							<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
							<input type="button" style="margin-left: 15px;" class="button" value="Cancelar" onClick="javascript:history.back();" />		
					</div>	
				</div>
				</form>
        	<%
        		}
        	%>		        	
			</div>
		</div>
	</body>
</html>