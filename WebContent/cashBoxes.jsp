<%@ page import="domain.CashBox" %>
<%@ page import="domain.User"%>
<%@ page import="java.util.ArrayList" %>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
	@SuppressWarnings("unchecked")
	ArrayList<CashBox> cashBoxes = (ArrayList<CashBox>)request.getAttribute("cashBoxes");
	
	String info_text = "";
	String info = (String) session.getAttribute("info");
	if (info != null ){
		info_text = info;
	}
	session.removeAttribute("info");
%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Cajas</title>
	<script type="text/javascript" src="./js/jquery.js"></script>
	<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$('#example').dataTable( {
			"iDisplayLength": 7,
			"bLengthChange": false,
			"sScrollY": "250px",
			"bPaginate": false,
			"aoColumns": [
				null,
				null,
				null,
				null,
				{ "bSearchable": false, "asSorting": false, "sWidth": "18%" }
			],
			"oLanguage": {
	            "sLengthMenu": "Mostrar _MENU_ registros",
	            "sZeroRecords": "No hay ningún registro que coincida con su búsqueda",
	            "sInfo": " ",
	            "sInfoEmpty": " ",
	            "sInfoFiltered": "(filtrando de _MAX_ registros totales)",
	            "sEmptyTable": "No hay cajas disponibles",
	            "sLoadingRecords": "Por favor, espere - cargando...",
	            "sSearch": "Buscar:"
        	}
		} );
	} );
	</script>
	<script type="text/javascript">
	var idCashBox;
	var amountTotal;
			
	$(function() {
		$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });		
	});
	
	function loadVars(var1, var2, var3) {
		idCashBox = var1;
		amountTotal = var3;
		$('.caja').text(var2);
		$('.totalAmount').text(var3);
	};
	
	function setV(f){
		f.elements['cashBoxID'].value = idCashBox;
		f.elements['totalAmount'].value = amountTotal;
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
			<ul>
            	<li class="menuitem"><a href="CreateCashBoxServlet">Crear Caja</a></li>
            </ul>
	    	<div class="menuitemSalir"><a href="LogoutServlet">Salir</a></div>	
        </div>        
			 <jsp:include page="./menu.jsp" />
		<div id="content">  
			<h2>Cajas:</h2>
			<div id="printCashBox"><a href="SearchCashBoxFormServlet" id="printCashBoxText" >Imprimir cierre de cajas</a></div>
			<div class="info-text"><%= info_text %></div>
			<div id="dt_example">
					<div id="container">
						<div id="demo">
							<table class="display" id="example">
								<thead>
									<tr>
										<th>ID</th>
										<th>Nombre</th>
										<th>Status</th>
										<th>Monto Inicial</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<% 	for (int i = 0; i<cashBoxes.size(); i++) {
											CashBox cb = cashBoxes.get(i);	
									%>			
											<tr class="gradeA">
												<td><%= cb.getCashBoxID() %></td>
												<td><%= cb.getName() %></td>
												<td><%= cb.getIsOpen() == 0 ? "Cerrada" : "Abierta" %></td>
												<td><%= cb.getIsOpen() == 0 ? "-" : cb.getInitialAmount() %></td>
												<td>
													<% 	if(cb.getIsOpen() == 0) { %>
															<a id="go" rel="leanModal" href="#openCashW" style="color: #f7941e; font-weight: bold;"
																onclick="return loadVars(<%= cb.getCashBoxID() %>,'<%= cb.getName() %>', '');"  >
																<img alt="logo" src="./images/open.png"  height="16" width="16" title="Abrir Caja" />
															</a>
													<% 	}
														else {
													%>
															<a id="go" rel="leanModal" href="#closeCashW" style="color: #f7941e; font-weight: bold;"
																onclick="return loadVars(<%= cb.getCashBoxID() %>,'<%= cb.getName() %>', '<%= cb.getTotalAmount() %>');" >
																<img alt="logo" src="./images/close.png"  height="16" width="16" title="Cerrar Caja" />
															</a>
															<a href="CreatePaymentServlet?cashBoxID=<%= cb.getCashBoxID() %>" style="color: transparent" >
																<img alt="logo" src="./images/movements.png"  height="16" width="16" title="Registrar Pago" />
															</a>
													<% 	} %>											
													<a href="ShowCashBoxServlet?cashBoxID=<%= cb.getCashBoxID() %>" style="color: transparent" >
														<img alt="logo" src="./images/detail.png"  height="16" width="16" title="Ver Detalle" />
													</a>
													<% 	if (cb.getCashBoxID() != 1) { %>
															<a href="EditCashBoxServlet?cashBoxID=<%= cb.getCashBoxID() %>" style="color: transparent" >
																<img alt="logo" src="./images/edit.png"  height="16" width="16" title="Editar Caja" />
															</a>
															<a id="go" rel="leanModal" href="#deleteCash" style="color: #f7941e; font-weight: bold;" 
																onclick="return loadVars(<%= cb.getCashBoxID() %>,'<%= cb.getName() %>', '');" >
																<img alt="logo" src="./images/delete.png" height="16" width="16" title="Eliminar"/>
															</a> 
													<% 	} %>
													<br>
												</td>
											</tr>
									<% 	} %>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="spacer"></div>
        	</div>
       	</div>
		<div id="openCashW">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Abrir Caja</h3>
				<form action="OpenCashBoxServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="cashBoxID" class="good_input" name="cashBoxID"  value="" />
					<input type="hidden" id="totalAmount" class="good_input" name="totalAmount" value="" />
					<input type="hidden" id="userID" class="good_input" name="userID" value="<%= user.getUserID() %>" />
					<div class="text">
						<div class="leftColum"><b>Caja:</b></div><span class="caja"></span> <br>
						<div class="leftColum"><b>Status:</b></div>Cerrada<br>
						<div class="leftColum"><b>Clave:</b></div><input type="password" id="password" name="password" /><br>
						<div class="leftColum"><b>Monto:</b></div><input type="text" id="initialAmount" name="initialAmount" /><br><br>
						<span>¿Está seguro que desea abrir la caja</span>  <span class="caja"></span>?  
					</div>
					<div id="signup-header">
						<a class="close_x" id="close_x_aux"  href="#"></a>
					</div>	
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpAux"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
				
		
		<div id="closeCashW">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Cerrar Caja</h3>
				<form action="CloseCashBoxServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="cashBoxID" class="good_input" name="cashBoxID"  value="" />
					<input type="hidden" id="totalAmount" class="good_input" name="totalAmount" value="" />
					<input type="hidden" id="userID" class="good_input" name="userID" value="<%= user.getUserID() %>" />
					<div class="text">
						<div class="leftColum"><b>Caja:</b></div><span class="caja"></span> <br>
						<div class="leftColum"><b>Status:</b></div>Abierta<br>
						<div class="leftColum"><b>Clave:</b></div><input type="text" id="password" name="password" /><br>
						<div class="leftColum"><b>Monto:</b></div><span class="totalAmount"></span><br><br>
						<span>¿Está seguro que desea cerrar la caja</span>  <span class="caja"></span>?  
					</div>
					<div id="signup-header">
						<a class="close_x" id="close_x_aux"  href="#"></a>
					</div>
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpAux"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		<div id="deleteCash">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" > Eliminar Caja</h3>
				<br><br>
				<span>¿Está seguro que desea eliminar la caja</span>  <span class="caja"></span>?  <br><br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="RemoveCashBoxServlet" method="post"  onsubmit="return setV(this)">
					<input type="hidden" id="cashBoxID" class="good_input" name="cashBoxID"  value="" />
					<input type="hidden" id="totalAmount" class="good_input" name="totalAmount" value="" />
					<div class="btn-fld">
						<input type="submit"  class="buttonPopUpDelete"  name="sbmtButton" value="Aceptar"  />
					</div>
		 		</form>
			</div>
		</div>
		
	</body>
</html>