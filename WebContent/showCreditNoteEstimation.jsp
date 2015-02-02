<%@page import="domain.User"%>
<%@page import="domain.Cost"%>
<%@page import="domain.Admission"%>
<%@page import="domain.BussinessMicro"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="domain.Protocol"%>
<%@page import="domain.Estimation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.Estimation"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%
DecimalFormat df = new DecimalFormat("0.00");
String est 	= (String) request.getAttribute("factId");
String f 	= (String) request.getAttribute("f");
Admission e = (Admission)request.getAttribute("admission");

@SuppressWarnings("unchecked")
ArrayList<Protocol> protocols = (ArrayList<Protocol>) request.getAttribute("protocols");

@SuppressWarnings("unchecked")
ArrayList<Protocol> costs = (ArrayList<Protocol>) request.getAttribute("costs");

DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
DateFormat hourFormat = new SimpleDateFormat("hh:mm:ss a");
Date date = new Date();
String dateTxt = dateFormat.format(date);
String hour    = hourFormat.format(date);

String name = "";
User user = (User) session.getAttribute("user");
if (user != null)	name = user.getFirstName() ;


String dateE = e.getAdmissionDate()		;
String[] split = null;
String de = "";
if (dateE != ""){
	split = dateE.split(" ");
	de 	= split[0];
}
@SuppressWarnings("unchecked")
ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) request.getAttribute("bm");

String result = (String) session.getAttribute("info");
String text = "";
if (result != null)
	text = result;
session.removeAttribute("info");

%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Ver Prefactura por Revisar</title>
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
	            	<li class="menuitem"><a href="ListCreditNotesReviewServlet">Ver Prefacturas por Revisar</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
	        	<h2>Ver Prefactura por Revisar:</h2><br/>
	        	<div class="info-text"><%= text %></div>
				<div style="min-height:300px;">
				<div class="wrapper">
				<div id="title" style="font-size:14px; font-weight: bold;text-align:center;"> PREFACTURA <%= Estimation.leftPadStringWithChar(est, 9, '0') %> </div>
				<hr/>
				<br/>
				<div class="header">
				<% 
					String nombre 	= e.getFirstName() + " " + e.getLastName();
					String cedula 	= e.getIdentityCard();
				%>
			<div><b>Nombre del Paciente: </b> <%= nombre %></div>
			<div><b>Cédula de Identidad: </b> <%= cedula %></div>
		</div><br>
		<div class="header">
			<b>Médico Tratante: </b><%= e.getSpecialist().getFirstName() +  " " + e.getSpecialist().getLastName() %>    	
        </div>
		<div class="header">
			<b>Responsable de Pago: </b><%= e.getResponsibleName() %>     	
        </div><br>
        <table id="sweetTable">
			<tbody>
				<tr>
					<th style="width:10%">Número</th>
					<th style="width:45%">Diagnóstico</th>
					<th style="width:45%">Protocolo</th>
				</tr>				
				<% for (int i = 0 ; i < protocols.size(); i++){ 
					Protocol p = protocols.get(i);
				%>
					<tr>
						<td><%= p.getProtocolID() %></td>
						<td><%= p.getDiagnosis() %></td>
						<td><%= p.getName() %></td>
				<% } %>
				
			</tbody>
		</table>
		<br>
		<table id="sweetTable">
			<tbody>
			<% 
			long micro = 1;
			double subtotal = 0.00;
			%>
			<tr>
				<th ><%= costs.get(0).getBussinessRuleMicroName() %></th>
				<th style="width:20%;text-align:right;">Precio Bs.F.</th>
			</tr>
			<%
			for (int j = 0; j < costs.size(); j++){
				Protocol ct = costs.get(j);
				if(ct.getEstimationCost() != null){
					if(micro == ct.getBussinessRuleMicroID()){
						double d = Estimation.format.parse(ct.getEstimationCost()).doubleValue();
						subtotal = subtotal + d;
						%>
						<tr>
							<td style="width:50%"><%= ct.getProtocolScaleName() %></td>
							<td style="width:20%;text-align:right;"><%= ct.getEstimationCost() %></td>
						</tr>		
					<%
					} else {
						%>
						<tr id="totalTr">
							<td>*** SUB-TOTAL ***</td>
							<td style="width:20%;text-align:right;"><%= Estimation.format.format(subtotal) %></td>
						</tr>
						<tr>
							<th ><%= ct.getBussinessRuleMicroName() %></th>
							<th style="width:20%;text-align:right;">Precio Bs.F.</th>
						</tr>
						<tr>
							<td style="width:50%"><%= ct.getProtocolScaleName() %></td>
							<td style="width:20%;text-align:right;"><%= ct.getEstimationCost() %></td>
						</tr>
					<%
						subtotal = Estimation.format.parse(ct.getEstimationCost()).doubleValue();
						micro = ct.getBussinessRuleMicroID();
					}
				}
			}
			%>
				<tr id="totalTr">
					<td>*** SUB-TOTAL ***</td>
					<td style="width:20%;text-align:right;"><%= Estimation.format.format(subtotal) %></td>
				</tr>
				<%
					double t = (e.getEstimation().getTotalWithDiscount()==null) ? Estimation.format.parse(e.getTotal()).doubleValue() : 
						Estimation.format.parse(e.getEstimation().getTotal()).doubleValue() + (Estimation.format.parse(e.getTotal()).doubleValue() - Estimation.format.parse(e.getEstimation().getTotalWithDiscount()).doubleValue());
					double d = ((e.getTotalWithDiscount()==null) ? 0 : Estimation.format.parse(e.getTotal()).doubleValue() - 
							Estimation.format.parse(e.getTotalWithDiscount()).doubleValue()) + ((e.getEstimation().getTotalWithDiscount()==null) ? 0 : 
							Estimation.format.parse(e.getEstimation().getTotal()).doubleValue() - Estimation.format.parse(e.getEstimation().getTotalWithDiscount()).doubleValue());
					/*double t = (d == 0) ? Estimation.format.parse(e.getTotal()).doubleValue() : Estimation.format.parse(e.getTotal()).doubleValue() + d;*/
					/*double t = Estimation.format.parse(e.getTotal()).doubleValue();*/
					double wd = (e.getTotalWithDiscount() == null) ? Estimation.format.parse(e.getTotal()).doubleValue() :Estimation.format.parse(e.getTotalWithDiscount()).doubleValue();
					double r = wd - Estimation.format.parse(e.getTotalPaid()).doubleValue();
				%>
				<tr id="totalTr2">
					<td>*** TOTAL ***</td>
					<td style="width:20%;text-align:right;"><%= Estimation.format.format(t) %></td>
				</tr>
				<tr id="totalTr">
					<td>*** DESCUENTO ***</td>
					<td style="width:20%;text-align:right;"><%= Estimation.format.format(d) %></td>
				</tr>
				<tr id="totalTr2">
					<td>I.V.A.</td>
					<td style="width:20%;text-align:right;">0,00</td>
				</tr>
				<tr id="totalTr">
					<td>*** TOTAL GENERAL ***</td>
					<td style="width:20%;text-align:right;"><%= Estimation.format.format(wd)  %></td>
				</tr>
				<tr id="totalTr2">
					<td>*** TOTAL PAGADO ***</td>
					<td style="width:20%;text-align:right;"><%= e.getTotalPaid() %></td>
				</tr>
				<tr id="totalTr">
					<td>*** RESTANTE ***</td>
					<td style="width:20%;text-align:right;"><%= Estimation.format.format(r) %></td>
				</tr>
			</tbody>
			</table>				
		<br>
		<div id="botonera">
				<div id="botonP" style="display:inline-block;">
							<a id="go" rel="leanModal" href="#discount" style="color: #f7941e; font-weight: bold;" onclick="return loadVars(<%= e.getAdmissionID() %>,'');" class="button">
												Aplicar Descuento			
							</a>
				</div>	
				<div id="botonV" style="display:inline-block;">
				<form action="./ListCreditNotesReviewServlet">
							<input type="submit" class="button" value="Regresar" style="margin-left:40%;" />		
				</form></div>	
				
			</div>
		<div class="push"></div>
        </div>
		</div>
		</div>
		</div>
		<div id="discount">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Aplicar Descuento</h3><br><br>
				Por favor, indique la siguiente información.
				<form action="ApplyDiscountServlet" method="post"  onsubmit="return setV(this)">
				<input type="hidden" id="userId" class="good_input" name="userId"  value=""/>
				<input type="hidden" class="good_input" name="function"  value="showCreditNoteReview"/>
				<input type="hidden" class="good_input" name="fact"  value="<%= request.getParameter("factId")%>"/>
				
					<div class="text">
						<div class="leftColum"><b>Descuento:</b></div>
							<select name="type">
								<option value="P">%</option>
								<option value="M">Bs.</option>
							</select>
							<input type="text" pattern="^[0-9]+(\.[0-9]+)?$" name="amount" size='10' required title="Este campo es numerico y no puede ser dejado en blanco"/>
						<br>
						<div class="leftColum"><b>Justicación:</b></div><textarea name="justification" style="width: 148px;" required title="El campo 'Justificación' no puede ser dejado en blanco"></textarea><br>
					</div>
					<div id="signup-header">
						<a class="close_x" id="close_x_aux"  href="#"></a>
					</div>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpAux"  name="sbmtButton" value="Aplicar"  />
					</div>
		 		</form>
			</div>
		</div>
	</body>
</html>