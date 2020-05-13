<%@page import="domain.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.ProtocolService"%>
<%@page import="domain.Service"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<Service> sp = (ArrayList<Service>)request.getAttribute("sp");
	@SuppressWarnings("unchecked")
	ArrayList<ProtocolService> sps = (ArrayList<ProtocolService>)request.getAttribute("sps");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Servicios</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>	
		<script type="text/javascript" src="./js/functions.js"></script>
		<script>
			var colArray = new Array()    ;
			var idArray  = new Array()    ;
			var count 	 = <%= sps.size() %>;
			var deleted  = new Array()    ;
			var ies      = new Array();
			var iaux 	 = count;
			<% for (int k=0; k < sp.size(); k++) { %>
				colArray[<%= k %>] = "<%= StringEscapeUtils.escapeHtml(sp.get(k).getName()) %>"; 
				idArray[<%= k %>] = "<%= sp.get(k).getServiceID() %>"; 
			<% } %>
		</script>
		<script>
			$(function() {    
            	$('#sbmtButton').click(function(event) { 
            		var var1 = $('#countrows').val();
            		for (i = 0; i < var1; i++) {
            			if($('#supply' + (i+1) + '-old').val() == null) {
            				if($('#supply' + (i+1)).val() == '-') {                				
                				alert("Debe seleccionar un Nombre para cada una de las filas.");
                				return;
                			}
                			if($('#amount' + (i+1)).val() == '') {
                				alert("Debe colocar una cantidad para cada una de las filas. El campo cantidad debe ser numérico. Ejemplo 3.00");
                				return;
                			}
            			}
            			else if($('#amount' + (i+1) + '-old').val() == '') {
            				alert("Debe colocar una cantidad para cada una de las filas. El campo cantidad debe ser numérico. Ejemplo 3.00");
            				return;
            			}
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
		    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
			<form action="EditServicesServlet" id="form1" name="form1" method="post">
			<input type="hidden" name="protocolID" value='<%= (String) request.getParameter("protocolID") %>' />
			<input type="hidden" name="scaleID" value='<%= (String) request.getParameter("id") %>' />
			<input type="hidden" name="serviceTypeID" value='<%= (String) request.getParameter("serviceTypeID") %>' />
			<input type="hidden" name="count" id='countrows' value='<%= sps.size()%>' />
			<input type="hidden" name="actives" id='activeies' value='' />
			
			<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Editar Servicios</h2> <br><br>
	        	<p>Para comenzar a agregar servicios, haga clic en "Agregar Nuevo". Al escoger todos los deseados, haga clic en "Aceptar".</p><br>
	        	
	        	<p class="button-par"> 
	        		<input type ="button" value="Agregar Nuevo" class="buttonGray"  onclick="addRowForChild('sweetTable', colArray, idArray)"> 
	        		<input type="button" value="Eliminar Registro" class="buttonGray" onclick="deleteRowChild('sweetTable', colArray, idArray)">
	        	</p> 
			
				<table id="sweetTable" style="visibility: visible;">
					<tbody>
						<tr>
							 <th style="width: 40%; text-align:center">Nombre</th>
							 <th style="width: 20%; text-align:center">Cantidad</th>
							 <th style="width: 20%; text-align:center">Seleccione para Eliminar</th>
						</tr>      
						<% for (int i=0; i < sps.size(); i++) { %>
						<script>
							ies[<%= i  %>] = <%= i + 1 %>;
						</script>
						<tr>
							<td><input type="text" readonly name="supply<%= i+1%>" value="<%= sps.get(i).getServiceName()%>" style="width:100%; border:none;">
							<input type='hidden' name="supply<%= i + 1%>-old" value="<%=sps.get(i).getServiceID()%>" ><span style='display:none' class='idsp'><%= sps.get(i).getServiceID() %></span></td>
							<td style="text-align: center;"><input name="amount<%= i+1 %>-old" size="4" type="text" value="<%= sps.get(i).getTotal() %>"></td>
							<td style="text-align: center;"><input type="checkbox"></td>
						</tr>
						<% } %>
						<script>
							document.getElementById('activeies').value = ies;
						</script>
						</tbody>
				</table>
				<br>
				 <div id="botonera" style="margin-top: -3px;">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="button" class="button" id="sbmtButton" name="sbmtButton" value="Guardar" />
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