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
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
  	<script src="./js/jquery-1.9.1.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<!--JS Datapicker-->
	<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
	<script type="text/javascript">
	var idUser;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2) {
		idUser = var1;
		$('.caja').text(var2);
		
	};
	
	function setV(f){
		f.elements['userId'].value = idUser;
		return true;
	}
	</script>
	<script type="text/javascript">
			$(function(){
				$.datepicker.setDefaults($.datepicker.regional['es']);
				$('#txtDateIni').datepicker({
					showOn: "button",
					buttonImage: "images/calendar.png",
					buttonImageOnly: true,
					buttonText: "Seleccione una fecha",
					dateFormat:'dd/mm/yyyy',
					changeMonth: true,
				    changeYear: true
				});
			} );
		</script>
</head>
<body>
	<div id="container">
		<div id="header">
        	<img alt="logo" src="./images/logo.png"/>
        </div>         
    	<nav>
         	<ul>
         		<li><a href="#">Bienvenido, <%= name %></a></li>
                <li><a href="ListAdmissionDischargesServlet">Altas Admisión<span class="badge yellow">3</span></a></li>
		 		<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue">3</span></a></li><li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green">3</span></a></li><li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red">3</span></a></li>
		     	<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     	<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue">3</span></a></li>
		     	<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
         	 </ul>
         </nav>        
		<div id="menu">
					<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
			<ul>
            	<li class="menuitem"><a href="ListXRayReportsServlet">Ver Informes</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        </div>        
		 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Crear informe de rayos X:</h2>
			<br>
			 <p>
		    <b> Cédula: </b> V-12345678<br><br>
		    <b> Nombre: </b> Ana Rojas<br><br>
		    </p>
		    <fieldset>
		  	<label> Tipo de Estudio: </label>
		    <select>
		    	<option value="-" selected="selected">Seleccionar</option>
		    	<option>Rx de Tórax</option>
		    	<option>Rx de Abdomen</option>		    	
		    	<option>Rx de Senos Paranasales</option>
		    	<option>Rx de Cuello</option>
		    	<option>Rx de Boca, Dentadura</option>
		    	<option>Rx de Pelvis</option>
		    	<option>Rx de Columna Vertebral</option>
		    	<option>Rx de Manos</option>
		    	<option>Rx de Cráneo</option>
		    	<option>Rx de Extremidades</option>	
		    	<option>Rx de Huesos</option>	    	
		    	<option>Rx de Articulaciones</option>
		    </select>
		    <br><br>
		   	<label>Fecha de Estudio: </label> <input type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10"/><br><br>
			<label> Análisis de Resultados:</label>  <textarea name="insuranceName" id="insuranceName" rows="8" cols="70"></textarea><br><br>
			<label> Adjuntar Archivo:</label>  <input name="insuranceName" id="insuranceName" type="file"/><br><br>
		    </fieldset>
		    <div id="botonera">
				<form action="ListXRayReportsServlet">
					<div id="botonP" style="display: inline; margin-right: 30px;">
								<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
					</div>	
					<div id="botonV" style="display: inline;">
							<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
					</div>	
				</form>
			</div><br>
	   	</div>
   	</div>
	</body>
</html>