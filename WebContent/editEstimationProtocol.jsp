<%@page import="domain.Protocol"%>
<%@page import="domain.ClinicType"%>
<%@page import="domain.Unit"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.PaymentResponsible"%>
<%
	String estimationID 	= (String) request.getAttribute("spID" );
		
	@SuppressWarnings("unchecked")
	ArrayList<Protocol> pt  = (ArrayList<Protocol>) request.getAttribute("pt");
	
	@SuppressWarnings("unchecked")
	ArrayList<Protocol> lp = (ArrayList<Protocol>) request.getAttribute("lp");
	
%>
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
		<title>Crear Presupuesto</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});
		</script>
		<script type="text/javascript">
		var estimationId;
		var protocolId;
		
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x, .buttonPopUpClose " });	
			
		});
		
		function loadVars(var1, var2) {
			estimationId = var1;
			protocolId   = var2;
			$('.num').text(var1);
		};
		
		function setV(f){
			f.elements['estimationId'].value = estimationId;
			f.elements['protocolId'].value = protocolId;
			
			return true;
		}
		
		$(document).ready(function() {
			function getUrlVars() {
			    var vars = {};
			    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
			        vars[key] = value;
			    });
			    return vars;
			}
			var first = getUrlVars()["insurance"];
			var doctor = getUrlVars()["doctor"];
			var departmentId = getUrlVars()["department"];
			if (first != null){
				first = first.replace(/\+/g, ' ');
				$("#insuranceName").val(first);
			}
			
			if (doctor != null){
				doctor = doctor.replace(/\+/g, ' ');
				$("#doctorName").val(doctor);
			}
			
			if (departmentId != null){
				$("#departament").val("Alergogía");
			}
		});
		</script>
		<script>
		$( document ).ready(function() {
			$( ".target" ).change(function() {
				index = $(this).val();
				if (index != "-"){
					$('.sum-div').show();
					$.ajax({
						type: "GET",
						url: "GetSpecialistServlet",
						data: {unit: index },
						success: function(data){
							$("#state").html(data)
						}
					});
				}
			});
			
			$('#titular').change(function() {
		        if(!$(this).is(":checked")) {
		            $("#div-3").show();
		        }else
					 $("#div-3").hide();
		               
		    });
			
			$(".addpb").click(function() {
				$(".addp").show();
			});
		});
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
        	<div id="content" style="position:absolute;">	
	        	<h2>Protocolos asociados al presupuesto:</h2><br/>
	        	<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Protocolo</th>
										<th>Diagnóstico</th>
										<th>Total</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<% if (lp != null) {
										for (int i=0; i< lp.size(); i++){
										Protocol p = lp.get(i);
									%>	
									<tr class="gradeA">
										<td><%= p.getProtocolID() %></td>
										<td><%= p.getName() %></td>
										<td><%= (p.getDiagnosis() != null)? p.getDiagnosis() : "-"  %></td>
										<td><%= p.getTotal() %></td>
										<td>
											<a href="EditEstimationServlet?id=<%= p.getProtocolID() %>" style="color: transparent" >
												<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar" />
											</a>
											<a id="go" rel="leanModal" href="#deleteUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars('<%= estimationID %>','<%=p.getProtocolID() %>');" >
												<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
											</a> 
											<br>
										</td>
									</tr>
									<% }
									}
									%>
								</tbody>
							</table>
				<br>
				<div>
					<form action="./ListEstimationsServlet" method="post">
					<input type="submit" class="button" value="Aceptar" onClick="javascript:history.back();" />		
					</form>
					</div>	
					<input type="button" class="button" value="Agregar protocolo" style="float:right;" class="addpb" />
					<div style="clear:both"></div>
					<div class="addp" style="display:none;">
					<form action="CreateEstimationProtocolServlet" method="get">
					<input type="hidden" name="estimationID" value="<%= estimationID %>"/>
					<h3 style='border-bottom: 1px solid; padding-bottom:5px;'>Agregar un nuevo protocolo</h3><br/>
					<p> Seleccione el protocolo asociado al presupuesto:</p><br/>
					<div>
  						<fieldset>
						  	<label> Protocolo: </label> 
							<select name="protocoloID">	
								<option value="-"> Seleccionar </option>
								<% for (int i = 0; i < pt.size(); i++){ 
								%>
									<option value="<%= pt.get(i).getProtocolID() %>"><%= pt.get(i).getName() %></option>
								<% } %>
							</select><br/><br/>
							<label>Diágnostico:</label>
							<textarea name="diagnosis" style="width:425px; height:90px;"></textarea>
						</fieldset>
					</div>
					<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</div>
				</form>
			</div>
			</div>
		</div>
		<div id="deleteUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Eliminar Presupuesto</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar el protocolo n° <span class="num"></span> asociado a este presupuesto? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveEstimationProtocolServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="estimationId" class="good_input" name="estimationId"  value=""/>
					<input type="hidden" id="protocolId" class="good_input" name="protocolId"  value=""/>
					
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>