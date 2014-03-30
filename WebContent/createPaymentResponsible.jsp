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
	@SuppressWarnings("unchecked")
	ArrayList<BussinessRules> b = (ArrayList<BussinessRules>) request.getAttribute("bussinessRules");
	@SuppressWarnings("unchecked")
	ArrayList<BussinessModels> m = (ArrayList<BussinessModels>) request.getAttribute("bussinessModels");
	@SuppressWarnings("unchecked")
	ArrayList<BussinessMicro> micros = (ArrayList<BussinessMicro>) request.getAttribute("bussinessMicros");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Crear Responsable de Pago</title>
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
	            	<li class="menuitem"><a href="ListPaymentResponsiblesServlet">Ver Responsables</a></li>
                </ul>
				<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute; overflow-y: scroll;">	
	        	<h2>Crear Responsable de Pago:</h2>
				<br>
				<% String info = (String) request.getAttribute("info"); 
					if (info != null){%>
						<div class="info-text"><%= info %></div>
				<% 
				}
				%>
				
				
				<form action="CreatePaymentResponsibleServlet" method="post" novalidate>
	  				<fieldset>
					<label for="name">Nombre:</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" size="5" /> <br><br>
					<label for="name">Regla de Negocio:</label>
					<select name="selBusinessRule" id="selBusinessRule" onchange="displayDiv(this);">
						<option value="0">Seleccionar</option>
							<% for (int i = 0; i < b.size(); i++){ 
							BussinessRules bRules = b.get(i); 
						%>
							<option value="<%= bRules.getId() %>"><%= bRules.getName() %></option>
						<% } %>
					</select> <br><br>
					<div id="genModel" style="display:none;">
						<label for="name">Modelo de Negocio:</label>
						<select name="selBusinessModel" id="selBusinessModel" onchange="displaySubDiv(this, 1);">
							<option value="0">Seleccionar</option>
							<%
							for (int i = 0; i< m.size(); i++){ 
								BussinessModels models = m.get(i);
							%>
								<option value="<%= models.getId()%>"><%= models.getName()%></option>
							<% 
							}
							%>
						</select> <br><br>
						<div id="genDesc1" style="display:none;">
							<label for="name">Porcentaje de Descuento:</label>
							<input type="number" min="1" name="txtPrice2" id="txtPrice2" maxlength="3" size="3" /> <br><br>
						</div>
						<div id="genAum1" style="display:none;">
							<label for="name">Porcentaje de Aumento:</label>
							<input type="number" min="1" name="txtPrice3" id="txtPrice3" maxlength="3" size="3" /> <br><br>
						</div>
					</div>
					<div id="espModel" style="display:none;">
						<% for (int j = 0; j < micros.size(); j++){
							BussinessMicro microE =  micros.get(j);
						%>	
							<h3><%= microE.getName() %></h3>
							<label for="name">Modelo de Negocio:</label>
							<select name="selBusinessModel<%= j+1 %>" id="selBusinessModel<%= j+1 %>" onchange="displaySubDiv(this, <%= j+2 %>);">
								<option value="0">Seleccionar</option>
								<%
								for (int i = 0; i< m.size(); i++){ 
									BussinessModels models = m.get(i);
								%>
									<option value="<%= models.getId()%>"><%= models.getName()%></option>
								<% 
								}
								%>
							</select> <br><br>
							<div id="genDesc<%= j+2 %>" style="display:none;">
							<label for="name">Porcentaje de Descuento:</label>
							<input type="number" min="1" name="txtPrice2<%= j+1 %>" id="txtPrice2<%= j+1 %>" maxlength="3" size="3" /><br><br>
							</div>
							<div id="genAum<%= j+2 %>" style="display:none;">
							<label for="name">Porcentaje de Aumento:</label>
							<input type="number" min="1" name="txtPrice3<%= j+1 %>" id="txtPrice3<%= j+1 %>" maxlength="3" size="3" /> <br><br>
							</div>
						<%
						}
						%>
					</div>
				</fieldset>
				<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Crear" />
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