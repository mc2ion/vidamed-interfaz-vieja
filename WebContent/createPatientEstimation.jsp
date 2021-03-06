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
		<title>Crear Paciente:</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
		<script type="text/javascript">
		var idUser;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });
			$("#addPhone").click(function() {
				  $("#otherPhone").show();
				  $(this).hide();
			});
			
			$("#deletePhone").click(function() {
				  $("#otherPhone").hide();
				  $("#addPhone").show();
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
	            	<li class="menuitem"><a href="ListEstimationsServlet">Ver Presupuestos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Crear Paciente:</h2>
				<br>
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Datos Personales</a></li>
					    <li><a href="#tabs-2">Datos de Contacto</a></li>
					  
			  		</ul>
  					<div id="tabs-1">
  						<br>
					    <fieldset>
							<label>C�dula de Identidad:</label>
							<select id="cedId" name="cedId">
								<option value="V-" >V</option>
								<option value="E-" >E</option>
							</select>
						  	 <input type="text" value="" style="width: 29%;"> <br /><br />
						  	  <label>Nombres:</label>
						  	 <input type="text" value=""> <br /><br />
						  	  <label>Apellidos:</label>
						  	 <input type="text" value=""> <br /><br />
						  	  <label>Fecha de Nacimiento:</label>
						  	 <input type="text" value=""> <br /><br />
						  	  <label>Sexo:</label>
							  	<select id="sex" name="sex">
									<option value="F" >Femenino</option>
									<option value="M" >Masculino</option>
								</select>
				   		 </fieldset>
  					</div>
  					<div id="tabs-2">
  						<br>
					    <fieldset>
							<label>Direcci�n:</label>
							 <textarea rows="4" cols="40"></textarea> <br /><br />
						  	  <label>Correo Electr�nico:</label>
						  	 <input type="text" value=""> <br /><br />
						  	  <label>Tel�fono:</label>
						  	  	<select id="phone" name="phone">
									<option value="L" >Local</option>
									<option value="P" >Particular</option>
									<option value="T" >Trabajo</option>
								</select>
						  	 <input type="text" value="" style="width: 135px;">
					  	 	<img alt="logo" src="./images/add.png"  id="addPhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
							 <br /><br />
							 <div id="otherPhone" style="display:none;">
								 <select id="phone" name="phone">
										<option value="L" >Local</option>
										<option value="P" >Particular</option>
										<option value="T" >Trabajo</option>
									</select>
							  	 <input type="text" value="" style="width: 135px;">
							  	 <img alt="logo" src="./images/close.png"  id="deletePhone" height="16" width="16" style="margin-left:10px; cursor: pointer;" title="Agregar otro telefono" />
							
						  	 </div>
						 </fieldset>
  					</div>
  				</div>
				<div id="botonera">
					<form action="CreateEstimationServlet">
						<div id="botonP" style="display: inline; margin-right: 30px;">
								<input type="submit"  class="button"  name="sbmtButton" value="Crear" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</form>
				</div>
			</div>
		</div>
		<div id="refreshUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Actualizar Presupuesto</h3>
				<br><br>
				<span>�Desea actualizar fecha y costos del presupuesto seleccionado? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="ListEstimationsServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>