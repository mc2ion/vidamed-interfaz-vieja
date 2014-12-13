<%@page import="domain.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Supply"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<Supply> sp = (ArrayList<Supply>)request.getAttribute("sp");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Fármacos en Habitación</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>	
		<script type="text/javascript" src="./js/functions.js"></script>
		<script>
			var colArray = new Array()    ;
			var idArray  = new Array()    
			var ies  	 = new Array()    ;
			var count 	 = 0;
			var iaux 	 = 0;
			<% for (int k=0; k < sp.size(); k++) { %>
				colArray[<%= k %>] = "<%= sp.get(k).getName() %>"; 
				idArray[<%= k %>] = "<%= sp.get(k).getSupplyID() %>"; 
				
			<% } %>
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
			<form action="AddDrugsServlet" method="post">
			<input type="hidden" name="protocolID" value='<%= (String) request.getParameter("protocolID") %>' />
			<input type="hidden" name="scaleID" value='<%= (String) request.getParameter("id") %>' />
			<input type="hidden" name="count" id='countrows' value='0' />
			<input type="hidden" name="actives[]" id='activeies' value='' />
			
			<div id="content" style="position:absolute;">	
	        	<h2>Fármacos en Habitación</h2> <br><br>
	        	<p>Para comenzar a agregar fármacos, haga clic en "Agregar Nuevo". Al escoger todos los deseados, haga clic en "Aceptar".</p><br>
	        	
	        	<p class="button-par"> 
	        		<input type ="button" value="Agregar Nuevo" class="buttonGray"  onclick="addRowForChild('sweetTable', colArray, idArray)"> 
	        		<input type="button" value="Eliminar Registro" class="buttonGray" onclick="deleteRowChild('sweetTable', colArray, idArray)">
	        	</p> 
			
				<table id="sweetTable" style="visibility:hidden" >
				<tr>
					 <th style="width: 40%; text-align:center">Nombre</th>
					 <th style="width: 20%; text-align:center">Cantidad</th>
					 <th style="width: 20%; text-align:center">Seleccione para Eliminar</th>
				</tr>         
				</table><br>
				 <div id="botonera" style="margin-top: -3px;">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Aceptar" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Cancelar" onClick="javascript:history.back();" />		
						</div>	
				</div>
			</div>
			</form>
		</div>
	</body>
</html>