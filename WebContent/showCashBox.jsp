<%@page import="domain.CashBox"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	CashBox cb = (CashBox) request.getAttribute("cashBox");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<script type="text/javascript" src="./js/jquery.js"></script>
		<title>Ver Admisión</title>
		<script>
		function printPageContentB() {
			$('#container').hide();
			$('#printable').show();
			$('body').addClass('bodyAux');
			window.print();
		}
			
		function unPrintPageContentB() {
			$('#container').show();
			$('#printable').hide();
			$('body').removeClass('bodyAux');
		}
		</script>
	</head>
	<body>
		<div id="container">
			<div id="header"></div>         
        	<jsp:include page="./upperMenu.jsp" />        
			<div id="menu">
				<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>
				<ul>
					<li class="menuitem"><a href="ListCashBoxesServlet">Ver Cajas</a></li>
            		<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
            	</ul>	
		    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Estatus Caja:</h2>   
	        	<br>
				<p>
			   	<b>Caja:</b> <%= cb.getName() %><br><br>
			    <b>Fecha Apertura:</b> <%= (cb.getOpeningDate()== null)? "-" : cb.getOpeningDate() %><br><br>
			    <b>Cajero:</b> <%= cb.getUser().getFirstName() + " " + cb.getUser().getLastName() %><br><br>
			    <b>Monto Inicio:</b>  Bs. <%= cb.getInitialAmount() %><br><br>
			    <b>Monto Cobrado:</b> Bs. <%= cb.getChargedAmount() %><br><br>
			    <b>Monto Pagado:</b>  Bs. <%= cb.getPaidAmount() %><br><br>
			   
			    <br><br>
			    </p>
				<div id="botonera" >
					<form onsubmit="printPageContentB();">
							<div id="botonP" style="display: inline; margin-right: 30px;">
										<input type="submit"  class="button"  name="sbmtButton" value="Imprimir"  onclick="printPageContentB();unPrintPageContentB();return false" />
							</div>	
							
							<div id="botonV" style="display: inline;">
										<input type="button" class="button" value="Regresar"  onClick="javascript:history.back();"  />		
							</div>	
					</form>
				</div>
			</div>
		</div>
		<div id="printable" style="display:none">  
			<h2>Estatus Caja:</h2>   
	        	<br>
				<p>
			   	<b>Caja:</b> <%= cb.getName() %><br><br>
			    <b>Fecha Apertura:</b> <%= cb.getOpeningDate() %><br><br>
			    <b>Cajero:</b> <%= cb.getUser().getFirstName() + " " + cb.getUser().getLastName() %><br><br>
			    <b>Monto Inicio:</b>  Bs. <%= cb.getInitialAmount() %><br><br>
			    <b>Monto Cobrado:</b> Bs. <%= cb.getChargedAmount() %><br><br>
			    <b>Monto Pagado:</b>  Bs. <%= cb.getPaidAmount() %><br><br>
			   
			    <br><br>
			    </p>
		</div>
	</body>
</html>