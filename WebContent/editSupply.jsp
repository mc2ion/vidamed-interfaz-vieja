<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Insumo</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css" />		
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
	            	<li class="menuitem"><a href="supplyAreas.jsp">Ver Áreas Insumos</a></li>
	            	<li class="menuitem"><a href="supplies.jsp">Ver Insumos</a></li>
	            	<li class="menuitem"><a href="createSupply.jsp">Crear Insumo</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Editar Insumo:</h2>
				<br>
				<fieldset>
					<label for="name">Nombre:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Albúmina Humana 20% 50 ml"/> <br><br>
					<label for="name">Tipo:</label>
					<select onchange="displayMedicineFields(this);">
						<option value="0">Seleccionar</option>
						<option value="1" selected>Fármaco</option>
						<option value="2">Suministro</option>						
					</select> <br><br>
					<label for="name">Descripción:</label>
					<textarea name="txtDescription" id="txtDescription" rows="3" cols="50">Solución acuosa estéril de albúmina obtenida por fraccionamiento del plasma sanguíneo humano con etanol.</textarea> <br><br>
					<div id="medicine" style="display:block;">
						<label for="name">Componente Activo:</label>
						<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Albúmina Humana"/> <br><br>
						<label for="name">Fabricante:</label>
						<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="Quimbiotec, C.A."/> <br><br>
						<label for="name">Presentación:</label>
						<select>
							<option value="0">Seleccionar</option>
							<option value="2" selected>Ampolla</option>	
							<option value="2">Cápsula</option>	
							<option value="2">Colirio</option>
							<option value="2">Crema</option>
							<option value="2">Elixir</option>	
							<option value="2">Emplasto</option>
							<option value="2">Enema</option>
							<option value="2">Frasco</option>	
							<option value="2">Granulado</option>
							<option value="2">Inhalación</option>
							<option value="2">Inyección</option>
							<option value="2">Jarabe</option>
							<option value="2">Linimento</option>
							<option value="2">Loción</option>
							<option value="2">Mucilago</option>	
							<option value="2">Óvulo</option>		
							<option value="1">Pastilla</option>
							<option value="2">Polvo</option>
							<option value="2">Preparado de Liberación Prolongada</option>
							<option value="2">Solución</option>	
							<option value="2">Supositorio</option>	
							<option value="2">Suspensión</option>
							<option value="2">Tintura</option>	
							<option value="2">Trocisco</option>	
							<option value="2">Ungüento</option>											
						</select> <br><br>
					</div>
					<label for="name">Cantidad:</label>
					<input type="number" min="1" name="txtAmount" id="txtAmount" maxlength="3" size="3" value="12" /> <br><br>
					<label for="name">Precio Unitario:</label>
					<input type="number" min="1" name="txtAmount" id="txtAmount" maxlength="3" size="3" value="350" /> <br><br>
				</fieldset>
				<div id="botonera">
					<form action="supplies.jsp">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Modificar" />
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