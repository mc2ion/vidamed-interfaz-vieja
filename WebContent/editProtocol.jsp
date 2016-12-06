<%@page import="domain.Protocol"%>
<%@page import="domain.User"%>
<%@page import="domain.AnesthesiaType"%>
<%@page import="domain.Unit"%>
<%@page import="java.util.ArrayList"%>

<%
	@SuppressWarnings("unchecked")
	ArrayList<AnesthesiaType> anesthesia = (ArrayList<AnesthesiaType>) request.getAttribute("anesthesiaTypes");
	@SuppressWarnings("unchecked")
	ArrayList<Unit> units = (ArrayList<Unit>) request.getAttribute("units");
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	String msg = (String) session.getAttribute("info");
	if (msg == null ){ msg = "";}
	session.removeAttribute("info");
	
	Protocol p = (Protocol) request.getAttribute("protocol");
	if (request.getParameter("type") != null && request.getParameter("type").equals("d")){
		p.setName("");
		p.setDescription("");
	}
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Protocolo</title>
		<script src="./js/jquery-1.9.1.min.js"></script>
	    <script>
			$(document).on('change','#typeOfProtocol',function(){
				if ($('#typeOfProtocol').val() == "H"){
					$("#days").show();
				}else{
					$("#days").hide();
				}
			});
		</script>
		<script>
			$(function() {    
            	$('#sbmtButton').click(function(event) { 
            		if ($('#txtName').val() == '') {
            			alert("Debe colocar el nombre del protocolo.");
            			return;
            		}
            		if ($('#txtORHours').val() == '') {
            			alert("Debe colocar la cantidad de horas en quirófano. Las Horas en Quirófano debe ser un valor numérico. Ejemplo: 3.5");
            			return;
            		}
            		$('#form1').submit();
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
	            	<li class="menuitem"><a href="ListProtocolsServlet">Ver Protocolos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
		       	<form id="form1" name="form1" action="EditProtocolServlet" method="post">
		       	<input type="hidden" name="protocolID" value="<%= p.getProtocolID() %>" />
				<input type="hidden" name="type" value="<%= request.getParameter("type") %>" />
				
		       		<div class="info-text"><%= msg %></div>
		        	<fieldset id="field1">
			            <h3>Informaci&oacute;n B&aacute;sica</h3><br/>
			            <label for="name">Nombre:</label>
						<input type="text" name="txtName" id="txtName" maxlength="70" size="5" value="<%= p.getName()%>"/> <br style="clear:both;">
						<label for="name">Descripci&oacute;n:</label>
						<textarea name="txtDescription" id="txtDescription" rows="3" cols="50"><%= p.getDescription()%></textarea> <br style="clear:both;"><br/>
						<label for="name">Tipo de Protocolo:</label>
						<select name="typeOfProtocol" id="typeOfProtocol" class="typeOfProtocol">
							<option value="A" <%=  (p.getType().equals("A")) ? "selected": "" %>>Ambulatorio</option>
							<option value="H" <%=  (p.getType().equals("H")) ? "selected": "" %>>No Ambulatorio</option>
						</select> <br style="clear:both;">
						<label> Sexo asociado al protocolo:</label>
						<select name="gender" id="gender">
							<option value="G" <%=  (p.getGender().equals("G")) ? "selected": "" %>>General</option>
							<option value="F" <%=  (p.getGender().equals("F")) ? "selected": "" %>>Femenino</option>
							<option value="M" <%=  (p.getGender().equals("M")) ? "selected": "" %>>Masculino</option>
						</select> <br style="clear:both;">
						<label> Unidad:</label>
						<select name="unit" id="unit">
						<%
						for(Unit u : units){
						%>
							<option value="<%= u.getUnitID() %>" <%=  (p.getUnitID().equals(u.getUnitID().toString())) ? "selected": "" %>><%= u.getName() %></option>
						<%}%>
						</select> <br style="clear:both;">
						<label> Hora de Quir&oacute;fano:</label>
						<input type="number" name="txtORHours" id="txtORHours" step="0.5" min="1" value="<%= p.getOrHours() %>" /> <br style="clear:both;"><br>
						<div id="days" style="display:none;">
							<label> D&iacute;as de Habitaci&oacute;n:</label>
							<input type="number" name="txtDays" id="txtDays" step="1" min="1" value="<%= (Double.valueOf(p.getRoomDays()) > 0) ? p.getRoomDays() : "1" %>" /> <br style="clear:both;">
						</div>
						<label> Tipo de Anestesia:</label>
						<select name="anesthesia" id="anesthesia">
						<%
						for(AnesthesiaType a : anesthesia){
						%>
							<option value="<%= a.getAnesthesiaTypeId() %>" <%= (p.getAnesthesiaID() != null && p.getAnesthesiaID().equals(String.valueOf(a.getAnesthesiaTypeId()))) ? "selected": "" %>><%= a.getName() %></option>
						<%}%>
						</select> <br><br>
			        </fieldset>
			        <p style="text-align: center;">
			            <input id="sbmtButton" name="sbmtButton" type="button" class="button next" value="Continuar" />
			            <input type="button" style="margin-left:20px;" class="button" value="Regresar" onClick="javascript:history.back();" />
			        </p>
			        </form>
				</div>
			</div>
			<script>
			var type = "<%= p.getType()%>";
			if (type == "H"){
				$("#days").show();
			}
			</script>
	</body>
</html>