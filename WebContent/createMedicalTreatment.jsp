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
		<title>Crear Tratamiento Médico</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<script src="./js/jquery-1.9.1.min.js"></script>
	    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />	
		<script type="text/javascript" src="./js/formToWizard.js"></script>
		<script type="text/javascript">
		        $(document).ready(function(){
		            $("#SignupForm").formToWizard({ submitButton: 'SaveAccount' })
		        });
		   </script>
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
	            	<li class="menuitem"><a href="ListMedicalTreatmentsServlet">Ver Tratamientos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
		       	<form id="SignupForm" action="ListMedicalTreatmentsServlet">
		        	<fieldset id="field1">
			            <legend>Información Básica</legend>
			           <label for="name">Nombre:</label>
						<input type="text" name="txtName" id="txtName" maxlength="50" size="5"/> <br><br>
						<label for="name">Descripción:</label>
						<textarea name="txtDescription" id="txtDescription" rows="3" cols="50"></textarea> <br><br>
						<label for="name">Parecido A:</label>
						<input type="button" name="txtSimilar" id="txtSimilar" value="Escoger"/> <br><br>
						<label for="name">Tipo de Protocolo:</label>
						<select id="typeOfProtocol">
							<option value="A">Ambulatorio</option>
							<option value="H">No Ambulatorio</option>
						</select>
			        </fieldset>
			       <fieldset id="field4">
			            <legend>Servicios Médicos</legend>
			        	  <table class="table-simple">
							    	<tr>
							    		<td>Bancos de Sangre (Tipiaje)</td>
							    		<td>Bs. 2270</td>
							    	</tr>
							    	<tr>
							    		<td>Electrocardiograma (EKG)</td>
							    		<td>Bs. 2270</td>
							    	</tr>
							    	<tr>
							    		<td>Evaluación Cardiovascular pre-operatoria</td>
							    		<td>Bs. 2270</td>
							    	</tr>
							    	<tr>
							    		<td>Laboratorio Clínico</td>
							    		<td>Bs. 2270</td>
							    	</tr>
							    	<tr>
							    		<td>Rayos X</td>
							    		<td>Bs. 2270</td>
							    	</tr>
						    </table>
			        </fieldset>
					<fieldset>
			            <legend>Honorarios Médicos</legend>
		        		<table class="table-simple">
							    	<tr>
							    		<td>Consulta Pre-anestésica</td>
							    		<td></td>
							    		<td>Bs. 2270</td>
							    	</tr>
						</table><br>
						<div class="divisor"></div>
						<h3>Personal Médico</h3>
						<p class="button-par-doctors"> 
			        		<input type ="button" value="Agregar Personal" class="buttonGray lessPadding"  onclick="addRowForDoctor('tableDoctors')"> 
			        		<input type="button" value="Eliminar Personal" class="buttonGray lessPadding" onclick="deleteRowForDoctor('tableDoctors')">
			        	</p> 
	        			<table id="tableDoctors" class="sweetTable">
							    	<tr>
							    		<th style="width: 30%;">Personal</th>
							    		<th style="width: 30%;">Cédula</th>
							    		<th style="width: 20%;">Honorario</th>
							    		<th style="width: 20%;">Seleccione para eliminar</th>
							    	</tr>
							    	<tr>
							    		<td>Cirujano Principal</td>
							    		<td>V-7103598</td>
							    		<td>Bs. <input type="text" value="2270"></td>
							    		<td><input type="checkbox"></td>
							    	</tr>
							    </table>
			        </fieldset>
			        <p>
			            <input id="SaveAccount" type="submit" class="button next" value="Crear Tratamiento" />
			        </p>
			        </form>
				</div>
			</div>
	</body>
</html>