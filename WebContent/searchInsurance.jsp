<%@page import="domain.PaymentResponsible"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<PaymentResponsible> resp = (ArrayList<PaymentResponsible>)request.getAttribute("responsibles");

	
	String id 		 = (String) request.getAttribute("id");
	String function	 = (String) request.getAttribute("function");
	
%>
<!DOCTYPE>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Escoger Responsable de Pago</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#titular').change(function() {
		        if(!$(this).is(":checked")) {
		            $("#div-3").show();
		        }else
					 $("#div-3").hide();
		               
		    });
				
		});
		
	</script>
	<script type="text/javascript">
	var idUser;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
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
        	
        </div>         
      	<jsp:include page="./upperMenu.jsp" />        
		<div id="menu">
			
			<div class="menuitemHome" ><a href="UserLoginServlet">Home</a></div>	
	    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Escoger responsable del pago:</h2><br>
			<p> Por favor seleccione el responsable de pago y agregue la información solicitada</p><br/><br/>
			<form action="SearchInsuranceServlet" method="post" id="form" style="display: inline;">
			<input type="hidden" name="id" 		 value="<%= id %>"/>
			<input type="hidden" name="function" value="<%= function %>"/>
			<div >
					<div id="container">
					<fieldset>
						<label>Responsable de Pago: </label>
						<select name="paymentId">
						<option value="-">Seleccionar</option>
						<% for (int i = 0; i < resp.size(); i++){
							PaymentResponsible p = resp.get(i);
							String info = p.getName();
							if (p.getAddress() != null)
								info += p.getAddress();
						%>
							<option value="<%= p.getId()%>" > <%= info %></option>
						<% } %>
						</select><br><br>
						<label> </label><label style="font-weight: normal; width: auto"><input type="checkbox" id="aval" name="aval" value="1" /> &iquest; El paciente tiene carta aval?</label><br><br>
						<label> </label><label style="font-weight: normal; width: auto"><input type="checkbox" id="titular" name="titular" value="1" checked /> &iquest; Es el paciente el titular del seguro?</label><br><br>
						<div id="div-3" style="display: none;">
							<h2>Datos del titular:</h2><br><br>
							<label> Cédula Titular: </label> 
							<select name="cedId" id="cedula">
								<option value="V-">V</option>
								<option value="E-">E</option>
							</select><input type="text" name="cedula" id="cedula" value="" style="width: 194px; margin-left: 3px;"><br><br>
							<label> Nombre Titular: </label>
							<input type="text" name="name" id="name" value="" style="width: 234px;"><br><br>
						</div>
					</fieldset>
					</div>
						
					<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Seleccionar" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="submit" class="button" value="Regresar" />		
						</div>	
					</div>
			</div>
			</form>
			<div class="spacer"></div>
        	</div>
       	</div>
		
	</body>
</html>