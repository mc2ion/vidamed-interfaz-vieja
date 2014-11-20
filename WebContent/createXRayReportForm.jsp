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
	<title>Cargar Informe de Rayos X</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript">
		var idUser;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });	
			
				$('#cedNumber').on('input', function() {
				    $("#go").hide();
				    $("#form").show();
				    $('#form').css({'display':'inline'});
				    
				});
		});
		
		function loadVars(var1, var2) {
			idUser = var1;
			$('.cliente').text(var2);
			
		};
		
		function setV(f){
			f.elements['userId'].value = idUser;
			return true;
		}
		
		
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
            	<li class="menuitem"><a href="ListXRayReportsServlet">Ver Informes</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Crear informe de rayos X:</h2><br><br>
			Ingrese el número de cédula de identidad del paciente: <br>
	        	<br>
	        	<select id="cedId" name="cedId">
					<option value="V-" >V</option>
					<option value="E-" >E</option>
				</select> &nbsp;<input id="cedNumber" type="text">
				
				
					 <form action="CreateXRayReportServlet"  id="form" style="display: none; ">
					 	<input type="image" src="./images/detail.png" height="16" width="16" title="Ver Detalle" />
					 </form>
		        	<a id="go" rel="leanModal"  href="#deleteVitalSign" style="color: #f7941e; font-weight: bold;" >
						<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
					</a>	 
	        		<div id="botonera" style="width:100px;">
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>		
					</div>	
	   	</div>
	   	<div id="deleteVitalSign">
			<div id="signup-ct">
				<form action="CreateXRayReportFormServlet">
				<h3 id="see_id" class="sprited" > Paciente Inexistente</h3>
				<br><br>
				<span style="font-size: 16px; text-align: center;">El paciente indicado no se encuentra registrado en el sistema.</span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<div class="btn-fld">
					<input type="submit" class="buttonPopUpClose"  name="sbmtButton" value="Aceptar"  />
				</div>
				</form>
			</div>
		</div>
   	</div>
	</body>
</html>