<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<%@page import="domain.ResponsibleRule"%>
<%@ page import="domain.PaymentResponsible" %>
<%@ page import="domain.BussinessRules" %>
<%@ page import="domain.BussinessModels" %>
<%@ page import="domain.BussinessMicro" %>
<%@ page import="domain.Unit" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>

<%
	PaymentResponsible responsible = (PaymentResponsible)request.getAttribute("responsible");
	@SuppressWarnings("unchecked")
	ArrayList<BussinessRules> b = (ArrayList<BussinessRules>) request.getAttribute("bussinessRules");
	@SuppressWarnings("unchecked")
	ArrayList<BussinessModels> m = (ArrayList<BussinessModels>) request.getAttribute("bussinessModels");
	@SuppressWarnings("unchecked")
	ArrayList<BussinessMicro> micros = (ArrayList<BussinessMicro>) request.getAttribute("bussinessMicros");
	ArrayList<ResponsibleRule> rrList = responsible.getResponsableRulesList();
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Responsable de Pago</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<script type="text/javascript">
		
		function displayDiv(combo) {
			sel = combo.options[combo.selectedIndex].value;
			div1 = document.getElementById('genModel');
			div2 = document.getElementById('espModel');
			
			if(sel == 1){
				div1.style.display = "block";
				div2.style.display = "none";
			} else if (sel == 2){
				div1.style.display = "none";
				div2.style.display = "block";				
			} else {
				div1.style.display = "none";
				div2.style.display = "none";				
			}
		}
		
		function displaySubDiv(combo, i) {
			sel = combo.options[combo.selectedIndex].value;
			div2 = document.getElementById('genDesc'+i);
			div3 = document.getElementById('genAum'+i);
			
			if(sel == 2){
				div2.style.display = "block";
				div3.style.display = "none";
			} else if (sel == 3){
				div2.style.display = "none";
				div3.style.display = "block";				
			} else {
				div2.style.display = "none";
				div3.style.display = "none";				
			}
		}
		
		</script>
		<script>
			$(function() {    
            	$('#sbmtButton').click(function(event) { 
            		var patternDouble = new RegExp('^[0-9]+(\.[0-9]+)?$');
            		if ($('#txtName').val() == '') {
            			alert("El campo 'Nombre' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#selBusinessRule').val() == '0') {
            			alert("Debe seleccionar un valor en el campo 'Regla de Negocio'");
            			return;
            		}
            		else if ($('#selBusinessRule').val() == '1' && $('#selBusinessModel').val() == '0') {
            			alert("El campo 'Modelo de Negocio' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#selBusinessRule').val() == '1' && $('#selBusinessModel').val() == '2' && $('#txtPrice2').val() == '') {
            			alert("El campo 'Porcentaje de Descuento' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#selBusinessRule').val() == '1' && $('#selBusinessModel').val() == '2' && !$('#txtPrice2').val().match(patternDouble)) {
            			alert("El campo 'Porcentaje de Descuento' debe ser un campo numérico");
            			return;
            		}
            		else if ($('#selBusinessRule').val() == '1' && $('#selBusinessModel').val() == '3' && $('#txtPrice3').val() == '') {
            			alert("El campo 'Porcentaje de Aumento' no puede ser dejado en blanco");
            			return;
            		}
            		else if ($('#selBusinessRule').val() == '1' && $('#selBusinessModel').val() == '3' && !$('#txtPrice3').val().match(patternDouble)) {
            			alert("El campo 'Porcentaje de Aumento' debe ser un campo numérico");
            			return;
            		}
            		else if ($('#selBusinessRule').val() == '2') {
            			<% for (int j = 0; j < micros.size(); j++){	%>	
            				if ($('#selBusinessModel<%= j + 1%>').val() == '0') {
                    			alert("El campo 'Modelo de Negocio' no puede ser dejado en blanco");
                    			return;
                    		}
            				else if ($('#selBusinessModel<%= j + 1%>').val() == '2' && $('#txtPrice2<%= j + 1%>').val() == '') {
                				alert("El campo 'Porcentaje de Descuento' no puede ser dejado en blanco");
                				return;
                			}
                			else if ($('#selBusinessModel<%= j + 1%>').val() == '2' && !$('#txtPrice2<%= j + 1%>').val().match(patternDouble)) {
                				alert("El campo 'Porcentaje de Descuento' debe ser un campo numérico");
                				return;
                			}
                			else if ($('#selBusinessModel<%= j + 1%>').val() == '3' && $('#txtPrice3<%= j + 1%>').val() == '') {
                				alert("El campo 'Porcentaje de Aumento' no puede ser dejado en blanco");
                				return;
                			}
                			else if ($('#selBusinessModel<%= j + 1%>').val() == '3' && !$('#txtPrice3<%= j + 1%>').val().match(patternDouble)) {
                				alert("El campo 'Porcentaje de Aumento' debe ser un campo numérico");
                				return;
                			}
            			<% } %>
            		}
            		$('#form1').submit();
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
	            	<li class="menuitem"><a href="ListPaymentResponsiblesServlet">Ver Responsables</a></li>
            		<li class="menuitem"><a href="CreatePaymentResponsibleServlet">Crear Responsable</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute; overflow-y: scroll;">	
	        	<h2>Editar Responsable de Pago:</h2>
				<br>
				<% String info = (String) request.getAttribute("info"); 
					if (info != null){%>
						<div class="info-text"><%= info %></div>
				<% 
				}
				%>
				
				
				<form id="form1" name="form1" action="EditPaymentResponsibleServlet" method="post" novalidate>
	  				<input type="hidden" id="rId" name="rId" value="<%= responsible.getId() %>" /> 
	  				<input type="hidden" id="rName" name="rName" value="<%= responsible.getName() %>" /> 
	  				<input type="hidden" id="rbrId" name="rbrId" value="<%= responsible.getBussinessRuleId() %>" /> 
			  		
			  		<fieldset>
					<label for="name">Nombre:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5" value="<%= responsible.getName() %>"/> <br><br>
					<label for="name">Regla de Negocio:</label>
					<select name="selBusinessRule" id="selBusinessRule" onchange="displayDiv(this);">
						<option value="0">Seleccionar</option>
							<% for (int i = 0; i < b.size(); i++){ 
							BussinessRules bRules = b.get(i); 
							String selected = "";
							if (bRules.getId() == responsible.getBussinessRuleId())
								selected = "selected";
						%>
							<option value="<%= bRules.getId() %>" <%= selected %> ><%= bRules.getName() %></option>
						<% } %>
					</select> <br><br>
					<% 
					String styleModel = "style=\"display:block;\"";
					String styleModel2 = "style=\"display:none;\"";
					if (responsible.getBussinessRuleId() == 1){
						styleModel = "style=\"display:block;\"";
						styleModel2 = "style=\"display:none;\"";
					}else{
						styleModel = "style=\"display:none;\"";
						styleModel2 = "style=\"display:block;\"";
					} %>
					
					<div id="genModel" <%= styleModel %> >
						<label for="name">Modelo de Negocio:</label>
						<select name="selBusinessModel" id="selBusinessModel" onchange="displaySubDiv(this, 1);">
							<option value="0">Seleccionar</option>
							<%
							for (int i = 0; i< m.size(); i++){ 
								BussinessModels models = m.get(i);
								Long id2 = responsible.getResponsableRulesList().get(0).getBussinessModelId();
								String selected = "";
								if (id2  == models.getId())
									selected = "selected";
							%>
								<option value="<%= models.getId()%>" <%= selected %>><%= models.getName()%></option>
							<% 
							}
							%>
						</select> <br><br>
						<% 
						String style = "style=\"display:none;\"";
						String style2 = "style=\"display:none;\"";
						
						if (responsible.getResponsableRulesList().get(0).getBussinessModelId() == 2)
							style = "";
						else if (responsible.getResponsableRulesList().get(0).getBussinessModelId() == 3)
							style2 = "";
						
							System.out.println(responsible.getResponsableRulesList().get(0).getPercentage() );
						%>
						<div id="genDesc1" <%= style %>>
							<label for="name">Porcentaje de Descuento:</label>
							<input type="number" min="1" name="txtPrice2" id="txtPrice2" maxlength="3" size="3" value="<%= responsible.getResponsableRulesList().get(0).getPercentage() %>" /> <br><br>
						</div>
						<div id="genAum1" <%= style2 %>>
							<label for="name">Porcentaje de Aumento:</label>
							<input type="number" min="1" name="txtPrice3" id="txtPrice3" maxlength="3" size="3" value="<%= responsible.getResponsableRulesList().get(0).getPercentage() %>" /> <br><br>
						</div>
					</div>
					<div id="espModel" <%= styleModel2 %>>
						<% for (int j = 0; j < micros.size(); j++){
							BussinessMicro microE =  micros.get(j);
							String displayInput2 = "style=\"display:none;\"";
							String displayInput3 = "style=\"display:none;\"";
							Double percentage = 0.0;
							
						%>	
							<h3><%= microE.getName() %></h3>
							<label for="name">Modelo de Negocio:</label>
							<select name="selBusinessModel<%= j+1 %>" id="selBusinessModel<%= j+1 %>" onchange="displaySubDiv(this, <%= j+2 %>);">
								<option value="0">Seleccionar</option>
								<%
								for (int i = 0; i< m.size(); i++){ 
									BussinessModels models = m.get(i);
									
									Long rule = (long) 0;
									for (int z = 0; z < rrList.size(); z++){
										ResponsibleRule microRule = rrList.get(z);
										// Estoy en el micro corrrespondiente
										System.out.println(microRule.getBussinesRuleMicroId() + " " + microE.getId());
										if (microRule.getBussinesRuleMicroId() == microE.getId()){
											//Verifico cual regla de negocio tiene:
												rule = microRule.getBussinessModelId();
												percentage = microRule.getPercentage();
										}
									}
									String rulSelected = "";
									if (models.getId() == rule){
										rulSelected = "selected";
									}	
									
									
									if (rule == 2){
										displayInput2 = "style=\"display:block;\"";
									}
									else if (rule == 3){
										displayInput3 = "style=\"display:block;\"";
									}
										
										
								%>
									<option value="<%= models.getId()%>" <%= rulSelected %>><%= models.getName()%></option>
								<% 
								}
								%>
							</select> <br><br>
							<div id="genDesc<%= j+2 %>" <%= displayInput2 %>>
							<label for="name">Porcentaje de Descuento:</label>
							<input type="number" min="1" name="txtPrice2<%= j+1 %>" id="txtPrice2<%= j+1 %>" maxlength="3" size="3" value="<%= percentage %>" /><br><br>
							</div>
							<div id="genAum<%= j+2 %>" <%= displayInput3 %>>
							<label for="name">Porcentaje de Aumento:</label>
							<input type="number" min="1" name="txtPrice3<%= j+1 %>" id="txtPrice3<%= j+1 %>" maxlength="3" size="3" value="<%= percentage %>" /> <br><br>
							</div>
						<%
						}
						%>
					</div>
				</fieldset>
				<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="button" class="button" id="sbmtButton" name="sbmtButton" value="Modificar" />
						</div>	
						<div id="botonV" style="display: inline;">
								<a href="ListPaymentResponsiblesServlet" class="button">Regresar</a>	
						</div>	
					
				</div><br>
				</form>
			</div>
		</div>
	</body>
</html>