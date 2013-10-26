<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Escoger Especialista</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		var oTable = $('#example').dataTable( {
			"iDisplayLength": 7,
			"bLengthChange": false,
			"sScrollY": "150px",
			"bPaginate": false,
			"aoColumns": [
				{ "bSearchable": false, "asSorting": false, "sWidth": "10%"},
				null,
				null,
				null
			],
			"oLanguage": {
	            "sLengthMenu": "Mostrar _MENU_ registros",
	            "sZeroRecords": "No hay ning�n registro que coincida con su b�squeda",
	            "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ registros",
	            "sInfoEmpty": "Mostrando 0 a 0 de 0 registros",
	            "sInfoFiltered": "(filtrando de _MAX_ registros totales)",
	            "sEmptyTable": "No hay datos disponibles en la tabla",
	            "sLoadingRecords": "Por favor, espere - cargando...",
	            "sSearch": "Buscar:"
        	}
		} );
		oTable.fnSort( [ [1,'asc'] ] );
	} );
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			
			function getUrlVars() {
			    var vars = {};
			    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
			        vars[key] = value;
			    });
			    return vars;
			}

			var first = getUrlVars()["function"];
			first = first.replace(/\+/g, ' ');
			if (first != null){
				if (first.indexOf("CreditNote") > 0){
					$("#admission").attr('class', 'active');
					if (first == "editCreditNoteEstimation")
						$("#form").attr('action', 'EditCreditNoteEstimationServlet');
				}
				else if (first.indexOf("Admission") > 0){
					$("#admission").attr('class', 'active');
					if (first == "editAdmissionEstimation")
						$("#form").attr('action', 'EditAdmissionEstimationServlet');
				}
				else if (first.indexOf("Pharmacy") > 0){
					$("#supplyAreas").attr('class', 'active');
					if (first == "editPharmacyEstimation")
						$("#form").attr('action', 'EditPharmacyEstimationServlet');
				}
				else if (first.indexOf("Estimation") > 0){
					$("#estimation").attr('class', 'active');
					if (first == "editEstimation")
						$("#form").attr('action', 'EditEstimationServlet');
					else if(first == "createEstimation")
						$("#form").attr('action', 'CreateEstimationServlet');
				}
				else if (first.indexOf("Hospitalization") > 0){
					$("#hospitalization").attr('class', 'active');
					if (first == "editHospitalization")
						$("#form").attr('action', 'EditHospitalizationServlet');
					
				}
				else if (first.indexOf("Patient") > 0){
					$("#admission").attr('class', 'active');
					if (first == "admitPatient")
						$("#form").attr('action', 'AdmitPatientServlet');
					
				}
			}
				
		});
		
	</script>
	<script type="text/javascript">
	var idUser;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });
		
		$("#next").click(function() {
			$("#beds").css("visibility","visible"); 
			$("#botonReg").hide();
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
        	<img alt="logo" src="./images/logo.png"/>
        </div>         
      	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, Prueba</a></li>
                <li><a href="ListAdmissionDischargesServlet">Altas Admisi�n<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
	    	<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<form action="" method="get" id="form" style="display: inline;">
				
			<h2>Escoger medico tratante:</h2><br>
			<p> Por favor seleccione la unidad del m�dico tratante y haga clic en "Siguiente": </p><br>
			<p><b>Unidad:  </b> 
				<select id="department" name="department" style="width: 230px;">
								<option value="337" >ALERGOLOG�A</option>
							 	<option value="660" >ANALISTAS DE SEGUROS</option>
								<option value="338" >ANESTESIOLOG�A</option>
								<option value="340" >BIOAN�LISIS</option>
								<option value="240" >CARDIOLOG�A</option>
								<option value="342" >CARDIOVASCULAR PERIF�RICO</option>
								<option value="343" >CIRUG�A BARI�TRICA</option>
								<option value="344" >CIRUG�A COLUMNA</option>
								<option value="345" >CIRUG�A DE T�RAX</option>
								<option value="887" >CIRUGIA EN ORTOPEDIA INFANTIL</option>
								<option value="235" >CIRUGIA GENERAL</option>
								<option value="346" >CIRUG�A GINECOL�GICA</option>
								<option value="544" >CIRUG�A LAPAROSCOPICA</option>
								<option value="348" >CIRUG�A M�XILO-FACIAL </option>
								<option value="349" >CIRUG�A ONCOL�GICA </option>
								<option value="350" >CIRUG�A PEDI�TRICA</option>
								<option value="351" >CIRUG�A PL�STICA, EST�TICA Y RECONSTRUCTIVA</option>
								<option value="935" >COLOPROCTOLOG�A</option>
								<option value="658" >COORDINADOR DE APS / SUP. DE SECRETARIAS</option>
								<option value="236" >DERMATOLOG�A</option>
								<option value="352" >ENDOCRINOLOG�A</option>
								<option value="231" >FISIATR�A</option>
								<option value="353" >FISIOTERAPEUTAS</option>
								<option value="238" >GASTROENTEROLOG�A</option>
								<option value="418" >GASTROENTEROLOG�A INFANTIL</option>
								<option value="355" >GINECO OBSTETRICIA</option>
								<option value="356" >GINECOLOG�A CL�NICA</option>
								<option value="239" >HEMATOLOG�A</option>
								<option value="357" >INFERTILIDAD</option>
								<option value="419" >LABORATORIO</option>
								<option value="359" >MASTOLOG�A</option>
								<option value="245" >MEDICINA INTERNA</option>
								<option value="362" >M�DICOS RESIDENTES</option>
								<option value="656" >NEFROLOGIA DE ADULTOS</option>
								<option value="364" >NEONATOLOG�A</option>
								<option value="365" >NEUMONOLOG�A</option>
								<option value="366" >NEUMONOLOG�A PED�ATRICA</option>
								<option value="367" >NEUROCIRUG�A</option>
								<option value="233" >NEUROLOG�A</option>
								<option value="229" >NUTRICI�N</option>
								<option value="232" >OFTALMOLOG�A</option>
								<option value="370" >ONCOLOG�A M�DICA</option>
								<option value="244" >OTORRINOLARINGOLOG�A</option>
								<option value="371" >PATOLOG�A</option>
								<option value="372" >PEDIATR�A</option>
								<option value="373" >PROCTOLOG�A</option>
								<option value="374" >PSQUIATR�A</option>
								<option value="375" >RADIOLOG�A, IMAGENOLOG�A</option>
								<option value="376" >REUMATOLOG�A</option>
								<option value="659" >SECRETARIAS</option>
								<option value="378" >T�CNICOS RADI�LOGOS</option>
								<option value="379" >TOMOGRAF�A Y RESONANCIA</option>
								<option value="657" >TRAUMATOLOGIA ESPECIALISTA EN COLUMNA</option>
								<option value="380" >TRAUMATOLOG�A Y ORTOPEDIA</option>
								<option value="242" >UROLOG�A</option>
								<option value="381" >UROLOG�A PEDI�TRICA</option>
				</select>
				<input id="next" type="button" value="Siguiente">
			</p>
				<div id="botonReg" style="position: absolute; margin-top: 40px; margin-left: 320px;">
					<br><input type="button" class="button" value="Regresar"
						onClick="javascript:history.back();" />
				</div>
			<br><br>
			<div id="beds" style="visibility: hidden;">
				<p>Escoga el m�dico tratante haciendo clic en la columna izquierda de la tabla y luego haga clic en "Seleccionar":</p>
					<div id="dt_example">
						<div id="container">
							<div id="demo">
								<table class="display" id="example">
									<thead>
										<tr>
											<th>Escoger</th>
											<th>ID</th>
											<th>Nombre</th>
											<th>Consultorio</th>
										</tr>
									</thead>
									<tbody>
										<tr class="gradeA">
											<td><input type="radio" name="doctor" value="Adrian Beltran"><br>
											</td>
											<td>1</td>
											<td>Adrian Beltran</td>
											<td>132</td>

										</tr>
										<tr class="gradeA">
											<td><input type="radio" name="doctor" value="Alvaro Gomez"><br>
											</td>
											<td>2</td>
											<td>Alvaro G�mez</td>
											<td>-</td>

										</tr>
										<tr class="gradeA">
											<td><input type="radio" name="doctor" value="Antonio Dapuzzo"><br></td>
											<td>3</td>
											<td>Antonio Dapuzzo</td>
											<td>325</td>

										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<br>
						<div id="botonera">
								<div id="botonP" style="display: inline; margin-right: 30px;">
											<input type="submit"  class="button"  name="sbmtButton" value="Seleccionar" />
								</div>	
								<div id="botonV" style="display: inline;">
										<input type="submit" class="button" value="Regresar" />		
								</div>	
						</div>
				</div>
				
			</div>
			</form>
			<div class="spacer"></div>
        	</div>
       	</div>
		
	</body>
</html>