<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Protocolo</title>
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
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>         
        	   	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="pendingAdmissionDischarges.jsp">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="pendingCreditNotes.jsp">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="pendingCreditNotesReview.jsp">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="pendingInvoices.jsp">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="pendingRequest.jsp">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="pendingPharmacyDischarges.jsp">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="billing.jsp">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
				<div class="menuitemHome" ><a href="mainMenu.jsp">Home</a></div>	
		    	<ul>
	            	<li class="menuitem"><a href="admission.jsp">Ver Protocolos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
		       	<form id="SignupForm" action="admission.jsp">
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
			        <fieldset id="field2">
			            <legend>Hospitalización</legend>
			            	 <table class="table-simple">
							    	<tr id="tr1">
							    		<td>Habitación: <input type="text" value="1" name="days" class="days" size="4"> días</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    		
							    	</tr>
							    	<tr id="tr2">
							    		<td>Médico Residente</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr id="tr3">
							    		<td id="">Teléfono</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr id="tr4">
							    		<td>Televisión</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr id="tr5">
							    		<td>Acompañante</td>
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
							    		<td>Servicio de Alimentación</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>Servicios Farmacéuticos Quirúrgicos</td>
							    		<td>Bs. 2270</td>
							    		<td>
							    			<a href="addPharmaceuticals.jsp">
							    				<input type="button" class="buttonGray lessPadding" value="Editar">
							    			</a> 
							    		</td>
							    	</tr>
							    	<tr>
							    		<td>Fármacos en Habitación</td>
							    		<td>Bs. 2270</td>
							    		<td>
							    			<a href="addDrugs.jsp">
							    				<input type="button" class="buttonGray lessPadding" value="Editar">
							    			</a> 
							    		</td>
							    	</tr>
							    	<tr>
							    		<td>Material Médico Quirúrgico en Habitación</td>
							    		<td>Bs. 2270</td>
							    		<td>
							    			<a href="addMaterials.jsp">
							    				<input type="button" class="buttonGray lessPadding" value="Editar">
							    			</a> 
							    		</td>
							    	</tr>
							    	
							    </table>
							
			        </fieldset>
			        <fieldset id="field3">
			            <legend>Gastos en Quirófano</legend>
			        	  <table class="table-simple">
							    	<tr>
							    		<td>Quirófano</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>Sala de Recuperación</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>Monitoreo</td>
							    		<td>Bs. 2270</td>
							    		<td></td>
							    	</tr>
							    	<tr>
							    		<td>Gases, anestésicos y medicamentos</td>
							    		<td>Bs. 2270</td>
							    		<td>
							    			<a href="#">
							    				<input type="button" class="buttonGray lessPadding" value="Editar">
							    			</a> 
							    		</td>
							    	</tr>
							    	<tr>
							    		<td>Material Médico Quirúrgico</td>
							    		<td>Bs. 2270</td>
							    		<td>
							    			<a href="#">
							    				<input type="button" class="buttonGray lessPadding" value="Editar">
							    			</a> 
							    		</td>
							    	</tr>
						    </table>
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
			            <input id="SaveAccount" type="submit" class="button next" value="Crear Protocolo" />
			        </p>
			        </form>
				</div>
			</div>
	</body>
</html>