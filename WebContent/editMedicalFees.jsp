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
		<title>Editar Protocolo</title>
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
	            	<li class="menuitem"><a href="ListEstimationsServlet">Ver Presupuestos</a></li>
	            	<li class="menuitem"><a href="CreateEstimationServlet">Crear Presupuesto</a></li>
	     
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<form id="SignupForm" action="EditHospitalizationServlet#tabs-2">
		        	<fieldset id="field1">
			            <legend>Informaci�n B�sica</legend>
			           	<label for="name">Nombre:</label>
						<div>Frenuloplastia</div><br><br>
						<label for="name">Descripci�n:</label>
						<div>Cirug�a se realiza de forma ambulatoria con anestesia local y tiene una duraci�n de 15 minutos.</div> <br><br>
						<label for="name">Tipo de Protocolo:</label>
						<div>No Ambulatorio</div>
			        </fieldset>
			        <fieldset id="field2">
			            <legend>Hospitalizaci�n</legend>
			            	 <table class="table-simple">
							    	<tr id="tr1">
							    		<td>Habitaci�n: 1 d�a</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    		
							    	</tr>
							    	<tr id="tr2">
							    		<td>M�dico Residente</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr id="tr3">
							    		<td id="">Tel�fono</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr id="tr4">
							    		<td>Televisi�n</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr id="tr5">
							    		<td>Acompa�ante</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr id="tr6">
							    		<td>Kit Paciente</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>Servicio de Asistencia Permanente</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>Servicio de Alimentaci�n</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>Servicios Farmac�uticos Quir�rgicos</td>
							    		<td>Bs. 2270</td>
							    		<td>
							    		</td>
							    	</tr>
							    	<tr>
							    		<td>F�rmacos en Habitaci�n</td>
							    		<td>Bs. 2270</td>
							    		<td> 
							    		</td>
							    	</tr>
							    	<tr>
							    		<td>Material M�dico Quir�rgico en Habitaci�n</td>
							    		<td>Bs. 2270</td>
							    		<td> 
							    		</td>
							    	</tr>
							    	
							    </table>
							
			        </fieldset>
			        <fieldset id="field3">
			            <legend>Gastos en Quir�fano</legend>
			        	  <table class="table-simple">
							    	<tr>
							    		<td>Quir�fano</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>Sala de Recuperaci�n</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>Monitoreo</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>Gases, anest�sicos y medicamentos</td>
							    		<td>Bs. 2270</td>
							    		<td>
							    		</td>
							    	</tr>
							    	<tr>
							    		<td>Material M�dico Quir�rgico</td>
							    		<td>Bs. 2270</td>
							    		<td>
							    		</td>
							    	</tr>
						    </table>
			       	</fieldset>
					<fieldset id="field4">
			            <legend>Servicios M�dicos</legend>
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
							    		<td>Evaluaci�n Cardiovascular pre-operatoria</td>
							    		<td>Bs. 2270</td>
							    	</tr>
							    	<tr>
							    		<td>Laboratorio Cl�nico</td>
							    		<td>Bs. 2270</td>
							    	</tr>
							    	<tr>
							    		<td>Rayos X</td>
							    		<td>Bs. 2270</td>
							    	</tr>
						    </table>
			        </fieldset>
					<fieldset>
			            <legend>Honorarios M�dicos</legend>
		        		<table class="table-simple">
							    	<tr>
							    		<td>Consulta Pre-anest�sica</td>
							    		<td></td>
							    		<td>Bs. 2270</td>
							    	</tr>
						</table><br>
						<div class="divisor"></div>
						<h3>Personal M�dico</h3>
						<p class="button-par-doctors"> 
			        		<input type ="button" value="Agregar Personal" class="buttonGray lessPadding"  onclick="addRowForDoctor('tableDoctors')"> 
			        		<input type="button" value="Eliminar Personal" class="buttonGray lessPadding" onclick="deleteRowForDoctor('tableDoctors')">
			        	</p> 
	        			<table id="tableDoctors" class="sweetTable">
							    	<tr>
							    		<th style="width: 30%;">Personal</th>
							    		<th style="width: 30%;">C�dula</th>
							    		<th style="width: 20%;">Honorario</th>
							    		<th style="width: 20%;">Seleccione para eliminar</th>
							    	</tr>
							    	<tr>
							    		<td>Cirujano Principal</td>
							    		<td>V-7103598</td>
							    		<td>Bs. <input type="text" value="15000"></td>
							    		<td><input type="checkbox"></td>
							    	</tr>
							    	<tr>
							    		<td>Cirujano Ayudante I</td>
							    		<td>V-123410</td>
							    		<td>Bs. <input type="text" value="6000"></td>
							    		<td><input type="checkbox"></td>
							    	</tr>
							    	<tr>
							    		<td>Cirujano Ayudante II</td>
							    		<td>V-7103598</td>
							    		<td>Bs. <input type="text" value="4500"></td>
							    		<td><input type="checkbox"></td>
							    	</tr>
							    </table>
			        </fieldset>
			        <p>
			            <input id="SaveAccount" type="submit" class="button next" value="Editar Protocolo" />
			        </p>
			        </form>
			</div>
		</div>
	</body>
</html>