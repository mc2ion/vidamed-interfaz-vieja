<%@page import="domain.Protocol"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="domain.Estimation"%>
<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	Estimation est = (Estimation) request.getAttribute("est");
	
	@SuppressWarnings("unchecked")
	ArrayList<Protocol> lp = (ArrayList<Protocol>) request.getAttribute("lp");
	
	String estimationID = request.getParameter("id");
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Ver Presupuesto</title>
		<link rel="stylesheet" href="./css/jquery-ui.css" />
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
			if (first != null){
				first = first.replace(/\+/g, ' ');
				if (first.indexOf("Admission") > 0){
					$("#admission").attr('class', 'active');
					$("#menuInside").hide();
					$("#botonera").hide();
					$("#botonera2").show();
					
				}
				else if (first.indexOf("stimations") > 0){
					$("#estimation").attr('class', 'active');
				}
			}
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
		    	<ul id="menuInside">
	            	<li class="menuitem"><a href="ListEstimationsServlet">Ver Presupuestos</a></li>
	            	<li class="menuitem"><a href="CreateEstimationFormServlet">Crear Presupuesto</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Presupuesto:</h2>
				<br>
				<div style="min-height:300px;">
				<div id="tabs">
					<ul>
					    <li><a href="#tabs-1">Paciente</a></li>
					    <li><a href="#tabs-2">Protocolos</a></li>
					</ul>
  					<div id="tabs-1">
  					    <table class="table-simple">
					    	<tr><td><b>Cédula:</b> <td><%= est.getIdentityCard() %></td></tr>
					    	<tr><td><b> Nombre del Paciente:</b> <td><%= est.getFirstName() + " " + est.getLastName()%></td></tr>
					    	<tr><td><b> Médico Tratante: </b> <td><%= est.getSpecialistName() %></td></tr>
					    	<tr><td><b> Responsable del Pago:</b><td><%= est.getResponsibleName() %></td></tr>
						   <% if (est.getPolicyHolderID() != null){ %>
						  	 <tr><td><b> Cédula Titular del seguro:</b><td><%= est.getPolicyHolderID() %></td></tr>
						  	 <tr><td><b> Nombre Titular del seguro:</b><td><%= est.getPolicyHolderName() %></td></tr>
						   <% } %>
						   <%
						   double amount = Estimation.format.parse(est.getTotal()).doubleValue();
						   /* DecimalFormat formatter = new DecimalFormat("#,###.00");*/
						   %>
							<tr><td><b>Total: Bs.</b></td><td><%= est.getTotal() %></td></tr>
							<% if(est.getTotalWithDiscount()!= null){
								double amountWithDisc = Estimation.format.parse(est.getTotalWithDiscount()).doubleValue();
								double disc = amount - amountWithDisc;
								String number = Estimation.format.format(disc);
							%>
							<tr><td><b>Descuento: Bs.</b></td><td><%= number %></td></tr>
							<%	//number = formatter.format(amountWithDisc); %>
							<tr><td><b>Total con Descuento: Bs.</b></td><td><%= est.getTotalWithDiscount() %></td></tr>
							<% } %>
						   <tr><td><b>Fecha Creación</b></td><td><%= est.getEditionDate() %></td></tr>
					   </table>
					</div>
  					<div id="tabs-2">
  						<br>
					   	<table id="sweetTable" style="margin-bottom: 10px;">
					   		<tr style="background: rgb(136, 162, 190);">
					   			<td>Nombre</td>
					   			<td>Precio</td>
					   			<td>Acción</td>
					   		</tr>
					   		<% for (int i=0; i <lp.size(); i++){ %>
							<tr>
					   			<td><%= lp.get(i).getName() %></td>
					   			<td>Bs. <%= lp.get(i).getTotalWithPercentage() %></td>
					   			<td>
									<a href="ShowProtocolEstimationDetailServlet?protocolID=<%= lp.get(i).getProtocolID() %>&estimationID=<%= estimationID %>&n=<%= lp.get(i).getName() %>" style="color: transparent" >
												<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
									</a>
								</td>
					   		</tr>
					   		<% } %>
					   	</table>
					</div>
  				</div>
				</div>
				<div id="botonera" style="width:280px;">
					<form action="PrintEstimationServlet">
						<div id="botonP" style="display: inline; margin-right: 10px;">
							<a id="go" rel="leanModal" href="#printUser" style="color: #f7941e; font-weight: bold;" 
												onclick="return loadVars('<%= est.getId() %>','<%= est.getFirstName() + " " + est.getLastName() %>');" >
								<input type="button"  class="button"  name="sbmtButton" value="Imprimir" />
							</a> 
						</div>	
						<div id="botonV" style="display: inline; margin-right: 10px;">
								<a id="go" rel="leanModal" href="#refreshUser" style="color: #f7941e; font-weight: bold;" 
											onclick="return loadVars('<%= est.getId() %>','<%= est.getFirstName() + " " + est.getLastName() %>');" >
								<input type="button" class="button" value="Actualizar"  />			
								</a>
						</div>	
						<a href="./ListEstimationsServlet" class="button" style="display:inline-block;">Regresar</a>	
					</form>
				</div><br>
				<div id="botonera2" style="display:none;">
					<a href="./ListEstimationsServlet" class="button">Regresar</a>	
				</div><br>
			</div>
		</div>
		<div id="printUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Imprimir Presupuesto</h3>
				<br><br>
				<span>Seleccione en qué formato desea imprimir el presupuesto n° <span class="cliente"></span>: </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="PrintEstimationCompatServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete2"  name="sbmtButton" value="Compacto"  />
					</div>
		 		</form>
				<form action="PrintEstimationDetailServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete3"  name="sbmtButton" value="Detallado"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="refreshUser">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Actualizar Presupuesto</h3>
				<br><br>
				<span>¿Desea actualizar fecha y costos del presupuesto? </span> <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="UpdateEstimationServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>