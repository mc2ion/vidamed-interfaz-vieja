<%@page import="domain.BussinessMicro"%>
<%@page import="domain.ProtocolScale"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.User"%>
<%@page import="domain.Unit"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="domain.Estimation"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<ProtocolScale> ps = (ArrayList<ProtocolScale>)request.getAttribute("est");
	
	@SuppressWarnings("unchecked")
	ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>)request.getAttribute("bm");
	String id = (String) request.getParameter("id");
	
	@SuppressWarnings("unchecked")
	ArrayList<Unit> sArea = (ArrayList<Unit>)request.getAttribute("units");
	
	String nameProtocol = request.getParameter("n");
	
	Integer hms = (Integer) request.getAttribute("hms");

	String adminID 			= (String) request.getParameter("adminID");
	String estimationID 	= (String) request.getParameter("estimationID" );
	String protocolID 		= (String) request.getParameter("protocolID" );
	String fnc = request.getParameter("fnc");
	Boolean edit			= request.getParameter("edit") != null ? true : false;
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Detalle protocolo - hospitalización</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
		<script>
			$(function() {
			  $( "#accordion" ).accordion();
			});

			$( document ).ready(function() {
				$( ".target" ).change(function() {
					elem = this;
					index = $(this).val();
					specialist = $(this).data("specialist");
					identifier = $(this).attr('name').replace("unitId", "");

					if (index != "-"){
						$.ajax({
							type: "GET",
							dataType: "json",
							url: "GetSpecialistServlet",
							data: {unit: index, specialist: specialist, element: "#state" + identifier },
							success: function(data){
								$(data.element).html(data.options);
							}
						});
					}
				});
				
				$( ".target" ).change();
				
				$('#titular').change(function() {
			        if(!$(this).is(":checked")) {
			            $("#div-3").show();
			        }else
						 $("#div-3").hide();
			               
			    });
				
				$( ".honorarios" ).keyup(function() {
					elem = this;
					$( ".honorarios" ).each(function( index ) {
						perc = $(this).closest(".mem").find(".perc").text().replace(",",'.');
						perc = parseFloat(perc);
						vale = $(elem).val();
						newVal = vale * perc;
						if (isFloat(newVal) || isInt(newVal))$(this).val(newVal);
					});
				});
			});
			
			function isFloat(n) {
				return n === +n && n !== (n|0);
			}
			
			function isInt(n) {
				return n === +n && n === (n|0);
			}
		
		</script>
		<script>
			$(function() {    
        		$('#sbmtButton').click(function(event) {
        			var error = 0;
					$('#form1 select').each(function(index){  
			        	var input = $(this);
			        	if (input.val() == '-' || input.val() == '') {
			        		if (error == 0) {
			        			error = 1;
				        		alert("Debes seleccionar todas las unidades de especialistas y los médicos tratantes para cada una de las areas.");
				        		return;
			        		};			        		
			       		};
			    	});
					if (error == 0) {
						$('#form1').submit();
					};					
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
		    	<ul id="menuInside">
	            	<li class="menuitem"><a href="ListHospitalizationsServlet">Ver Hospitalizaciones</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
        		<form id="form1" name="form1" action="ShowProtocolEstimationDetailServlet" method="post">
				<input type="hidden" name="adminID" value="<%= adminID %>"/>
				<input type="hidden" name="estimationID" value="<%= estimationID %>"/>
				<input type="hidden" name="protocolID" value="<%= protocolID %>"/>
				<input type="hidden" name="fnc" value="<%= fnc %>"/>
        		<h3 style="color:#006C92;">Detalle protocolo "<%= nameProtocol %>" en hospitalización:</h3>
				<%
		       			for (int i = 0; i < bm.size(); i++){ 
		       				BussinessMicro b = bm.get(i);
		       	%>
				    <br/><br/><h3 style="margin-bottom:7px;"><%= b.getName() %></h3>
					<div>
				    <table class="table-simple">
				    	<%
							for (int j = 0; j < ps.size(); j++){ 
								ProtocolScale p = ps.get(j);
								if (p.getBussinessRuleMicroID() == b.getId()){
						%>
						<% if (p.getTotal() != null) { %>
						<tr id="tr<%=j%>" >
							<% if (p.getGeneratedCostTypeID() == 9 && edit) { %>
							<td class='lft'  style="vertical-align:top;"><%= p.getName()%></td>
							<td class='mem'>
								<label class="w200">Unidad del Especialista: </label>
								<select name="unitId<%= p.getProtocolScaleID() %>" id="unitId<%= p.getProtocolScaleID() %>" class="target" data-specialist="<%= p.getSpecialistID() %>">	
									<option value="-"> Seleccionar </option>
									<% for (int h = 0; h < sArea.size(); h++){ %>
									<option value="<%= sArea.get(h).getUnitID() %>" <%= (sArea.get(h).getUnitID() == p.getUnitID())? "selected" : ""%>><%= sArea.get(h).getName() %></option>
									<% } %>
								</select><br/><br/>
								<p class="sum-div">
									<label for="pname" class="w200">Médico Tratante:</label>
									<select class="spec" name="specialist<%= p.getProtocolScaleID() %>" id="state<%= p.getProtocolScaleID() %>">
										<option value="-">Seleccionar</option>
									</select>
								</p>  <br/> 
								<%  
									String cl = "honorarios" ; 
									NumberFormat nf = NumberFormat.getInstance(Locale.FRANCE);
									Number n = nf.parse(p.getCost());
									Double perc = n.doubleValue();
									if (perc == 0.00 || hms==0) cl = "fijos"; else if(perc != 1.00) cl = "hidden honorarios"; %>
								<label class="w200">Honorarios: Bs. </label>
								<input class="<%= cl%>" type="text" name="hon<%=p.getProtocolScaleID() %>" value="<%= Estimation.format.parse(p.getTotal()) %>" />
								<div style="display:none" class="perc"><%= (hms==0) ? "0.00" : p.getCost() %></div>
							</td>
							<td><input type="hidden" name="ids" value="<%= p.getProtocolScaleID() %>" /></td>
							<% }else{ %>
			    			<td class='lft'  style="vertical-align:top;"><%= p.getName()%></td>
							<td> Bs. <%= p.getTotal()%></td>
							<% } %>
						</tr>
						<% } %>
						<% }
						}
						%>
				    </table>
					</div>
				  <% } %>
				<div id="botonera2" style="display: inline-block; width: 100%; text-align: center;">
					<div id="botonV" style="display: inline; margin-right: 30px;" >
						<input type="button"  class="button"  name="sbmtButton" value="Regresar" onclick="history.go(-1);" />	
					</div>
					<% if (edit) { %>
		            <div id="botonP" style="display: inline; margin-right: 30px;">
			            <input type="button" class="button" id="sbmtButton" name="sbmtButton" value="Editar"/>
					</div>
					<% } %>
				</div><br>
				</form>
			</div>
		</div>
	</body>
	<style>
		.table-simple td {
			padding: 7px 0px;
			border-bottom: 1px dotted rgb(231, 231, 231);
		}
		td.lft {
			width:50%;
		}
		.w200 {
			width:145px; 
			display:inline-block;
		}
		.target, #state {
			width:220px !important;
		}
	</style>
</html>