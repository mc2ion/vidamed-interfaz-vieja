<%@page import="domain.User"%>
<%@page import="domain.AnesthesiaType"%>
<%@page import="java.util.ArrayList"%>

<%
	@SuppressWarnings("unchecked")
	ArrayList<AnesthesiaType> anesthesia = (ArrayList<AnesthesiaType>) request.getAttribute("anesthesiaTypes");
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
		<title>Crear Protocolo</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<script src="./js/jquery-1.9.1.min.js"></script>
	    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />	
		<script type="text/javascript" src="./js/functions.js"></script>
		
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
		       	<form id="SignupForm" action="ListAdmissionsServlet">
		        	<fieldset id="field1">
			            <legend>Informaci&oacute;n B&aacute;sica</legend>
			           <label for="name">Nombre:</label>
						<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
						<label for="name">Descripci&oacute;n:</label>
						<textarea name="txtDescription" id="txtDescription" rows="3" cols="50"></textarea> <br><br>
						<label for="name">Parecido A:</label>
						<input type="button" name="txtSimilar" id="txtSimilar" value="Escoger"/> <br><br>
						<label for="name">Tipo de Protocolo:</label>
						<select id="typeOfProtocol">
							<option value="A">Ambulatorio</option>
							<option value="H">No Ambulatorio</option>
						</select> <br><br>
						<label> Sexo asociado al protocolo:</label>
						<select id="gender">
							<option value="G">General</option>
							<option value="F">Femenino</option>
							<option value="M">Masculino</option>
						</select> <br><br>
						<label> Hora de Quir&oacute;fano:</label>
						<input type="number" name="txtORHours" id="txtORHours" step="0.5" min="1" /> <br><br>
						<label> D&iacute;as de Habitaci&oacute;n:</label>
						<input type="number" name="txtDays" id="txtDays" step="1" min="1" /> <br><br>
						<label> Tipo de Anestesia:</label>
						<select id="anesthesia">
						<%
						for(AnesthesiaType a : anesthesia){
						%>
							<option value="<%= a.getAnesthesiaTypeId() %>"><%= a.getName() %></option>
						<%}%>
						</select> <br><br>
			        </fieldset>
			        <p>
			            <input id="SaveAccount" type="submit" class="button next" value="Crear Protocolo" />
			        </p>
			        </form>
				</div>
			</div>
	</body>
</html>