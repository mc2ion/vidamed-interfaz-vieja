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
		<title>Ver Corte de Cuenta</title>
		<link rel="stylesheet" href="/resources/demos/style.css" />
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	
	        </div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>
				<ul>
            		<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
            	</ul>	
		    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
		<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Corte de cuenta del(la) paciente Ana Rojas:</h2>   
	        	<br>
				<p>
			   	<b>Caja:</b> Administracion<br><br>
			    <b>Fecha Apertura:</b> 20/07/2013<br><br>
			    <b>Hora de apertura:</b> 9:30am<br><br>
			    <b>Cajero:</b> Ana Roja<br><br>
			    <b>Monto Inicio:</b> Bs. 100<br><br>
			    <b>Monto Cobrado:</b> Bs. 0<br><br>
			    <b>Monto Pagado:</b> Bs. 0<br><br>
			   
			    <br><br>
			    </p>
				<div id="botonera" >
					<form action="PrintCashBoxServlet">
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="submit"  class="button"  name="sbmtButton" value="Imprimir" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</form>
				</div>
			</div>
		</div>
	</body>
</html>