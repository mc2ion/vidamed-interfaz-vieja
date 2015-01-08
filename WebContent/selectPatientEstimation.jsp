<%@page import="domain.Estimation"%>
<%@page import="domain.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Hospitalization"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	String patientID = request.getParameter("patientID");
	String txtCedNumber = request.getParameter("txtCedNumber");
	String txtName = request.getParameter("txtName");
	String txtLastName = request.getParameter("txtLastName");
	
	ArrayList<Estimation> est = (ArrayList<Estimation>) request.getAttribute("estimations");
	
	System.out.println(patientID + " " + txtCedNumber + " " + txtName + " "+ txtLastName);
	
	String text_result = (String) session.getAttribute("text");
	if (text_result == null)
		text_result = "";
	session.removeAttribute("text");
	
	User pat = new User();
	pat.setFirstName(txtName);
	pat.setLastName(txtLastName);
	pat.setIdentityCard(txtCedNumber);
	session.setAttribute("userInfo", pat);
	
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Seleccionar presupuesto</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript"  src="./js/jquery.leanModal.min.js"></script>
		<script>
		$(document).ready(function() {
		$('#submit').click(function(event) {  
				numPres = $('input[name=estimationID]:checked').val();
				
					$.get('SearchPatientServlet', {patientType: "", txtCedId: "" , 
												txtCedIdNum: "", estimation: numPres}, function(responseText) { 
							var json = JSON.stringify(eval("(" + responseText + ")"));
							obj = JSON.parse(json);
						
							//if (isAdult){
								var estimationID = obj[0].estimationID;
								var patientId = obj[0].patientID;
								var ced 	  = obj[0].identityCard;
								var name 	  = obj[0].firstName;
								var lastname  = obj[0].lastName;
								
								$("#patientID").val(patientId);
								$("#txtCedNumber").val(ced);
								$("#txtName").val(name);
								$("#txtLastName").val(lastname);
								$("#estimationId").val(estimationID);
								$("#submit-form").click();
							//}
						
					});
		
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
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Presupuesto asociado:</h2>
				<br>
				<form action="CreateEstimationServlet" style="float:right;">
							<input type="hidden" name="function"     value="admision" />
							<input type="hidden" name="patientID"    value="<%= patientID %>" />
							<input type="hidden" name="txtCedNumber" value="<%= txtCedNumber %>" />
							<input type="hidden" name="txtName"      value="<%= txtName %>" />
							<input type="hidden" name="txtLastName"  value="<%= txtLastName %>" />
							<input type="submit" value="Crear un nuevo presupuesto"/>
				</form>
				<div style="clear:both;"></div>
				<div id="dt_example">
					<div id="container">
						<div id="demo">
							<form action="AdmitPatientServlet" id="form-create" method="post" >
							<input type="hidden" id="patientID" name="patientID" value="" />
							<input type="hidden" id="txtCedNumber" name="txtCedNumber" value=""/>
							<input type="hidden" id="txtName" name="txtName" value=""/>
							<input type="hidden" id="txtLastName" name="txtLastName" value=""/>
							<input type="hidden" id="estimationId" name="estimationId" value=""/>
							<input type="hidden" id="function" name="function" value="admitPatientForm"/>
							<% if (est != null && est.size() > 0) { %>
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<% for (int i=0; i< est.size(); i++){
										Estimation p = est.get(i);
									%>	
									<tr class="gradeA">
										<td style="width:5%"><%= p.getId() %></td>
										<td><input type="radio" name="estimationID" value="<%= p.getId() %>"/></td>
									</tr>
									<% } %>
								</tbody>
							</table>
							<% }else{ %>
							<p style="font-size:14px;">El paciente nombre, cedula no tiene presupuestos asociados.</p>
							<% } %>
							<div id="botonV" style="width:100%; text-align:center; margin-top:10px;">
								<input type="button" class="button" id="submit" value="Seleccionar" />
								<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" style="margin-left:20px;" />	
								<input type="submit" id="submit-form" name="admitPatientForm" value="" style="display:none;" />
							</div>
							</form>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</body>
</html>