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
	
	
	String function = (String) request.getAttribute("function");
	System.out.println(function);
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
		<title>Agregar Protocolo</title>
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
		var idUser;
				
		$(function() {
			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x, .buttonPopUpClose " });	
			
		});
		
		function loadVars(var1, var2) {
			idUser = var1;
			$('.cliente').text(var2);
			
		};
		
		function setV(f){
			f.elements['userId'].value = idUser;
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
				<h2>Agregar protocolo:</h2><br/>
        		<div class="addp">
				<div>
					<form action="AddAdmissionProtocolServlet" method="post">
					<input type="hidden" name="estimationID" value="<%= estimationID %>"/>
					<input type="hidden" name="function" value="<%= function %>"/>
					<p> Seleccione el protocolo que desea agregar:</p><br/>
					<div>
  						<fieldset>
						  	<label> Protocolo: </label> 
							<select name="protocoloID">	
								<option value="-"> Seleccionar </option>
								<% for (int i = 0; i < pt.size(); i++){ 
									boolean found = false; 
									if (lp != null){ 
										for (int j = 0; j < lp.size(); j++){
										Protocol p = lp.get(j);
										if (p.getProtocolID() ==  pt.get(i).getProtocolID()){ found = true;}
										}
									}
									if (found == false){
								%>
									<option value="<%= pt.get(i).getProtocolID() %>"><%= pt.get(i).getName() %></option>
								<%
								}
								}
							%>
							</select><br/><br/>
							<label>Diágnostico:</label>
							<textarea name="diagnosis" style="width:425px; height:90px;"></textarea>
						</fieldset>
					</div>
					<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Agregar" />
						</div>	
					</div>
				</form>
				</div>
				</div>
			</div>
		</div>
	</body>
</html>