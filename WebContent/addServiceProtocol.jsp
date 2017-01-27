<%@page import="domain.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Supply"%>
<%@page import="domain.ProtocolScale"%>
<%@page import="domain.BussinessMicro"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	
	@SuppressWarnings("unchecked")
	ArrayList<Supply> sp = (ArrayList<Supply>)request.getAttribute("sp");
	
	@SuppressWarnings("unchecked")
	ArrayList<ProtocolScale> ps = (ArrayList<ProtocolScale>) request.getAttribute("ps");
	
	@SuppressWarnings("unchecked")
	ArrayList<BussinessMicro> bm = (ArrayList<BussinessMicro>) request.getAttribute("bm");
		
	String id = (String) request.getParameter("id");	
	
	Properties propertiesFile = new Properties();
	propertiesFile.load( new FileInputStream( getServletContext().getInitParameter("properties") ) );
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Servicios Adicionales</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<!--JS Buscador de Multiselect-->
		<script type="text/javascript" src="./js/jquery.quicksearch.js"></script>
		<script>
		$(function() {
				$('.my-select').multiSelect({
					  selectableHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='Buscar' style='width:100%'>",
					  selectionHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='Buscar' style='width:100%'>",
					  afterInit: function(ms){
					    var that = this,
					        $selectableSearch = that.$selectableUl.prev(),
					        $selectionSearch = that.$selectionUl.prev(),
					        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
					        selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';

					    that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
					    .on('keydown', function(e){
					      if (e.which === 40){
					        that.$selectableUl.focus();
					        return false;
					      }
					    });

					    that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
					    .on('keydown', function(e){
					      if (e.which == 40){
					        that.$selectionUl.focus();
					        return false;
					      }
					    });
					  },
					  afterSelect: function(){
					    this.qs1.cache();
					    this.qs2.cache();
					  },
					  afterDeselect: function(){
					    this.qs1.cache();
					    this.qs2.cache();
					  }
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
			 <form id="form1" name="form1" action="AddServiceProtocolServlet" method="post">
			 <input type="hidden" id="protocolID" name="protocolID" value="<%= id %>" /> 
			  	
			 <%
				for (int i = 0; i < bm.size(); i++){ 
					BussinessMicro b = bm.get(i);
		     %>
			 <div class="scale <%= b.getName()%>">
			 <br/><h3 class='nts'><%= b.getName() %></h3><br/>
			<select multiple="multiple" class="my-select" name="my-select[]">
			<%
			 	for (int j = 0; j < ps.size(); j++){ 
					ProtocolScale p = ps.get(j);
					if (p.getBussinessRuleMicroID() == b.getId()){
						if (p.getIsMandatory() == 0 ){
				%>
						<option value="<%= p.getProtocolScaleID() %>" <%= (p.getIsSelected() == 1)? "selected" : ""%>><%= p.getName().toUpperCase()%></option>
				<%  	
						}
					}
					
				}
				%>
			</select>	
			<script src="./js/jquery.multi-select.js" type="text/javascript"></script>	
			</div>		
						    	
			 <% } %>
			 <div id="botonera" style="margin-top: 20px;">
						<div id="botonP" style="display: inline; margin-right: 30px;">
									<input type="submit"  class="button"  name="sbmtButton" value="Aceptar" />
						</div>	
						<div id="botonV" style="display: inline;">
								<input type="button" class="button" value="Cancelar" onClick="javascript:history.back();" />		
						</div>	
				</div>
			 </form>
			 </div>
		</div>
	<script>
	$('.my-select').each(function(i) {
	    //alert(obj
		if ($(this).find('option').length == 0){
			$(this).closest('div').hide();
		}
	});
	
	</script>
	</body>
</html>