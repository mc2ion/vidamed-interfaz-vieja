<%@page import="domain.PaymentResponsible"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	PaymentResponsible r = (PaymentResponsible)request.getAttribute("responsible");
	
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
	    	<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        </div>        
		<jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Editar responsable del pago:</h2><br>
			<form action="EditEstimationPaymentResponsibleServlet" method="post" id="form" style="display: inline;">
			<input type="hidden" name="id" 		  value="<%= id %>"/>
			<input type="hidden" name="function"  value="<%= function %>"/>
			<input type="hidden" name="paymentId" value="<%= r.getId() %>"/>
			
			<div >
					<div id="container">
					<fieldset>
						<label>Responsable de Pago: </label>
						<h3><%= r.getName() %></h3><br/><br/>
						<%
						String checked = "";
						if (r.getHasGuaranteeLetter() == 1) 
							checked = "checked";
						%>
						<label> </label><label style="font-weight: normal; width: auto"><input type="checkbox" id="aval" name="aval" value="1" <%= checked %> /> &iquest; El paciente tiene carta aval?</label><br><br>
						<%
						checked = "";
						if (r.getIsPolicyHolder() == 1) 
							checked = "checked";
						%>
						<label> </label><label style="font-weight: normal; width: auto"><input type="checkbox" id="titular" name="titular" value="1" <%= checked %> /> &iquest; Es el paciente el titular del seguro?</label><br><br>
						
						<% 
						String style = "";
						if (r.getIsPolicyHolder() == 1)
							style = "style=\"display: none;\"";
						%>
						<div id="div-3" <%= style %>>
							<h2>Datos del titular:</h2><br><br>
							<label> Cédula Titular: </label> 
							<% 
							if (r.getPolicyHolderIdentityCard() != null && !r.getPolicyHolderIdentityCard().equals("")){
								String[] ci = r.getPolicyHolderIdentityCard().split("-"); %>
							<select name="cedId" id="cedula">
								<option value="V-" <%= ci[0].equals("V") ? "selected" : "" %>>V</option>
								<option value="E-" <%= ci[0].equals("E") ? "selected" : "" %>>E</option>
							</select>
							<input type="text" name="cedula" id="cedula" value="<%= ci[1] %>" style="width: 194px; margin-left: 3px;"><br><br>
							<% }else{ %>
							<select name="cedId" id="cedula">
								<option value="V-">V</option>
								<option value="E-">E</option>
							</select>
							<input type="text" name="cedula" id="cedula" value="" style="width: 194px; margin-left: 3px;"><br><br>
							<% }%>
							<label> Nombre Titular: </label>
							<input type="text" name="name" id="name" value="<%= r.getPolicyHolderName() %>" style="width: 234px;"><br><br>
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