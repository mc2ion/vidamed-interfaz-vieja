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
	String msg = (String) session.getAttribute("info");
	if (msg == null ){ msg = "";}
	session.removeAttribute("info");
	
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
		<script type="text/javascript" src="./js/functions.js"></script>
		<script>
			$(document).on('change','#typeOfProtocol',function(){
				if ($('#typeOfProtocol').val() == "H"){
					$("#days").show();
				}else{
					$("#days").hide();
				}
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
		       	<form id="SignupForm" action="CreateProtocolServlet" method="post">
		       		<div class="info-text"><%= msg %></div>
		        	<fieldset id="field1">
			            <legend>Informaci&oacute;n B&aacute;sica</legend>
			            <label for="name">Nombre:</label>
						<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br style="clear:both;">
						<label for="name">Descripci&oacute;n:</label>
						<textarea name="txtDescription" id="txtDescription" rows="3" cols="50"></textarea> <br style="clear:both;"><br/>
						<label for="name">Parecido A:</label>
						<input type="button" name="txtSimilar" id="txtSimilar" value="Escoger"/> <br style="clear:both;">
						<label for="name">Tipo de Protocolo:</label>
						<select name="typeOfProtocol" id="typeOfProtocol" class="typeOfProtocol">
							<option value="A">Ambulatorio</option>
							<option value="H">No Ambulatorio</option>
						</select> <br style="clear:both;">
						<label> Sexo asociado al protocolo:</label>
						<select name="gender" id="gender">
							<option value="G">General</option>
							<option value="F">Femenino</option>
							<option value="M">Masculino</option>
						</select> <br style="clear:both;">
						<label> Hora de Quir&oacute;fano:</label>
						<input type="number" name="txtORHours" id="txtORHours" step="0.5" min="1" /> <br style="clear:both;">
						<div id="days" style="display:none;">
							<label> D&iacute;as de Habitaci&oacute;n:</label>
							<input type="number" name="txtDays" id="txtDays" step="1" min="1" /> <br style="clear:both;">
						</div>
						<label> Tipo de Anestesia:</label>
						<select name="anesthesia" id="anesthesia">
						<%
						for(AnesthesiaType a : anesthesia){
						%>
							<option value="<%= a.getAnesthesiaTypeId() %>"><%= a.getName() %></option>
						<%}%>
						</select> <br><br>
			        </fieldset>
			        <p>
			            <input id="SaveAccount" type="submit" class="button next" value="Continuar" />
			        </p>
			        </form>
				</div>
			</div>
	</body>
</html>