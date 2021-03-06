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
		<title>Material M�dico Quir�rgico en Habitaci�n</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>	
		<script type="text/javascript" src="./js/functions.js"></script>
			

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
	        	<h2>Material M�dico Quir�rgico en Habitaci�n</h2> <br><br>
	        	<p>Para comenzar a agregar materiales, haga clic en "Agregar Nuevo". Al escoger todos los deseados, haga clic en "Aceptar".</p><br>
	        	
	        	<p class="button-par"> 
	        		<input type="button" value="Agregar Nuevo" class="buttonGray"  onclick="addRowForChild('sweetTable')"> 
	        		<input type="button" value="Eliminar Registro" class="buttonGray" onclick="deleteRowChild('sweetTable')">
	        	</p> 
			
				<table id="sweetTable" style="visibility:hidden" >
				<tr>
					 <th style="width: 20%; text-align:center">Id</th>
					 <th style="width: 40%; text-align:center">Nombre</th>
					 <th style="width: 20%; text-align:center">Cantidad</th>
					 <th style="width: 20%; text-align:center">Seleccione para Eliminar</th>
				</tr>         
				</table><br>
				 <div id="botonera" style="margin-top: -3px;">
					<form action="CreateProtocolServlet">
						<div id="botonP" style="display: none; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Aceptar" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Cancelar" onClick="javascript:history.back();" />		
						</div>	
					</form>
				</div>
				
			
			</div>
		</div>
	</body>
</html>