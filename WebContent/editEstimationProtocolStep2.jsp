<%@page import="domain.EstimationSpecialist"%>
<%@page import="domain.BussinessMicro"%>
<%@page import="domain.ProtocolScale"%>
<%@page import="domain.Protocol"%>
<%@page import="domain.ClinicType"%>
<%@page import="domain.Unit"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.PaymentResponsible"%>
<%
	String estimationID 	= (String) request.getParameter("estimationID" );
	String protocolID 		= (String) request.getParameter("protocoloID" );
	
	@SuppressWarnings("unchecked")
	ArrayList<ProtocolScale> ps = (ArrayList<ProtocolScale>)request.getAttribute("p");
	
	@SuppressWarnings("unchecked")
	ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>)request.getAttribute("bm");
	
	@SuppressWarnings("unchecked")
	ArrayList<Unit> sArea = (ArrayList<Unit>)request.getAttribute("units");
	
	@SuppressWarnings("unchecked")
	ArrayList<EstimationSpecialist> spec = (ArrayList<EstimationSpecialist>) request.getAttribute("spec");
	
	
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
		$( document ).ready(function() {
			var isNew = 1;
			$( ".target" ).change(function() {
				var elem = this;
				var index = $(this).val();
				if (index != "-"){
					$.ajax({
						type: "GET",
						url: "GetSpecialistServlet",
						data: {unit: index },
						success: function(data){
							$(elem).closest("td").find(".state").html(data);
							specialist = $(elem).closest(".mem").find(".spID").text();
							if (isNew == 1) { 
							$(elem).closest(".mem").find(".state").val(specialist); 
							count--; 
							if (count == 0) isNew = 0 }
						}
					});
				}
			});
			
			var count = $(".target").length;
			$( ".target" ).each(function(ind, el) {
				$(el).change();
			});
			
			
			
			$('#titular').change(function() {
		        if(!$(this).is(":checked")) {
		            $("#div-3").show();
		        }else
					 $("#div-3").hide();
		               
		    });
			
			$( ".honorarios" ).keyup(function() {
				elem = this;
				$( ".honorarios" ).each(function( index ) {
					perc = $(this).closest(".mem").find(".perc").text();
					vale = $(elem).val();
					newVal = vale * perc
				    $(this).val(newVal);
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
		    	<ul>
	            	<li class="menuitem"><a href="ListEstimationsServlet">Ver Presupuestos</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>           
			<jsp:include page="./menu.jsp" />
        	<div id="content" style="position:absolute;">	
				<form action="EditEstimationProtocolServlet" method="post">
				<input type="hidden" name="estimationid" value="<%= estimationID %>"/>
				<input type="hidden" name="protocolid" value="<%= protocolID %>"/>
				
        			<%
		       			for (int i = 0; i < bm.size(); i++){ 
		       				BussinessMicro b = bm.get(i);
		       		%>
		       		    <br/><h3 class='nts'><%= b.getName() %></h3><br/>
						<table class="table-simple">
						<%
							for (int j = 0; j < ps.size(); j++){ 
								ProtocolScale p = ps.get(j);
								if (p.getBussinessRuleMicroID() == b.getId()){
							%>
								<tr id="tr<%=j%>" >
									<% if (p.getGeneratedCostTypeID() == 9) { 
									%>
									<td class='lft'  style="vertical-align:top;"><%= p.getName()%></td>
									<td class='mem'>
										<% 
										Long unitID 		= 0L;
										Long specialistID 	= 0L;
										for (int l = 0; l < spec.size(); l++){ 
											EstimationSpecialist e = spec.get(l);
											if (e.getProtocolScaleID() == p.getProtocolScaleID()){
												unitID = e.getUnitID();
												specialistID = e.getSpecialistID();
											}
										}
										%>
										<label class="w200">Unidad del Especialista: </label>
										<select name="unitId<%= p.getProtocolScaleID() %>" id="unitId" class="target">	
											<option value="-"> Seleccionar </option>
											<% for (int h = 0; h < sArea.size(); h++){ 
											%>
												<option value="<%= sArea.get(h).getUnitID() %>" <%= (sArea.get(h).getUnitID() == unitID) ? "selected" : "" %>><%= sArea.get(h).getName() %></option>
											<% } %>
										</select><br/><br/>
										<div class="spID" style="display:none"><%= specialistID%></div>
										<p class="sum-div">
											<label for="pname" class="w200">Médico Tratante:</label>
											<select name="specialist<%= p.getProtocolScaleID() %>" class="state">
												<option value="-">Seleccionar</option>
											</select>
										</p>  <br/> 
										<% String cl = "" ; if (p.getProtocolScaleID() != 29) cl = "hidden"; %>
										<label class="w200">Honorarios: Bs. </label>
										<input class="<%= cl%> honorarios" type="text" name="hon<%=p.getProtocolScaleID() %>" value="<%= p.getTotal() %>" />
										<div style="display:none" class="perc"><%= p.getCost() %></div>
									</td>
									<td><input type="hidden" name="ids" value="<%= p.getProtocolScaleID() %>" /></td>
									<% }else{ %>
										<td class='lft'  style="vertical-align:top;"><%= p.getName()%></td>
										<% if (p.getTotal() == null && p.getGeneratedCostTypeID() == 10) { %>
											<td>Bs. <input type="text" name="variable<%=p.getProtocolScaleID() %>"/>
											<input type="hidden" name="variableids" value="<%= p.getProtocolScaleID() %>"/></td>									
										<% } %>
										<td><% if (p.getTotal() != null) { %> Bs. <%= p.getTotal()%><% } %></td>
									<% } %>
								</tr>
								<%
								}
							}
						%>
						
						</table>
					<% } %>
			    	<p style="width:100%; text-align:center; margin-top:20px;">
			            <input type="submit" class="button" value="Editar Presupuesto"/>
			        </p>
			</form>
       	</div>
		</div>
	</body>
	<style>
		.w200{width:145px; display:inline-block;}
		.table-simple td {
			padding: 7px 0px;
			border-bottom: 1px dotted rgb(231, 231, 231);
		}
		td.lft{width:340px;}
		.target, .state{width:220px !important;}
	</style>
</html>