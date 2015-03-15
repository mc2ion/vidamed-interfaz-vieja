<%@page import="domain.PermissionsList"%>
<%@page import="domain.User"%>
<%
	User user2 = (User) session.getAttribute("user");
	String userName = "";
	if (user2 != null)
		userName = user2.getFirstName() ;
	Integer countPAD = (Integer) session.getAttribute("countPAD");
	Integer countPCN = (Integer) session.getAttribute("countPCN");
	Integer countPCNR = (Integer) session.getAttribute("countPCNR");
	Integer countPB  = (Integer) session.getAttribute("countPB");
	Integer countPPD = (Integer) session.getAttribute("countPPD");
	Integer countPED = (Integer) session.getAttribute("countPED");
	Integer countPPP = (Integer) session.getAttribute("countPPP");
	Integer countPA = (Integer) session.getAttribute("countPA");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta http-equiv="refresh" content="600">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<script type="text/javascript" src="./js/jquery.js"></script>
		<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	</head>
	<body>
		<div id="container">
			<div id="header">
	        	<img alt="logo" src="./images/logo.png"/>
	        </div>   
			<nav>
         		<ul>
         			<% if (PermissionsList.hasPermission(request, PermissionsList.admissionDischarge)){ %>
	                	<li><a href="ListAdmissionDischargesServlet" target="_parent">Altas Admisión
	                	<% if (countPAD != 0){ %>
	                	<span class="badge yellow"><%= countPAD %></span>
			 			<% } %>
	                	</a></li>
                	<% }if (PermissionsList.hasPermission(request, PermissionsList.creditNotes)){  %>
	                	<li><a href="ListCreditNotesServlet" target="_parent">Prefacturas por Generar
	                	<% if (countPCN != 0){ %>
	                	<span class="badge blue"><%= countPCN %></span>
			 			<% } %>
	                	</a></li>
	                <% }if (PermissionsList.hasPermission(request, PermissionsList.creditNotesReview)){ %>
	                	<li><a href="ListCreditNotesReviewServlet" target="_parent">Prefacturas por Revisar
			 			<% if (countPCNR != 0){ %>
	                	<span class="badge green"><%= countPCNR %></span>
			 			<% } %>
	                	</a></li>
	                <% }if (PermissionsList.hasPermission(request, PermissionsList.invoices)){ %>
	                	<li><a href="ListInvoicesServlet" target="_parent">Facturas por Generar
			 			<% if (countPB != 0){ %>
	                	<span class="badge red"><%= countPB %></span>
			     		<% } %>
	                	</a></li>
	                <% }if (PermissionsList.hasPermission(request, PermissionsList.discounts)){ %>
	                	<li><a href="ListRequestsServlet" target="_parent">Descuentos
			     		<% if (countPED != 0){ %>
	                	<span class="badge yellow"><%= countPED %></span>
			     		<% } %>
	                	</a></li>
	                <% } if (PermissionsList.hasPermission(request, PermissionsList.pharmacyDischarges)){ %>
                		<li><a href="ListPharmacyDischargesServlet" target="_parent">Altas Farmacia
			     		<% if (countPPD != 0){ %>
	                	<span class="badge blue"><%= countPPD %></span>
			     		<% } %>
			     		</a></li>
			     	<% } if (PermissionsList.hasPermission(request, PermissionsList.pendingPayments)){ %>
		     			<li><a href="ListPendingPaymentsServlet" target="_parent">Pagos Pendientes
			     		<% if (countPPP != 0){ %>
	                	<span class="badge green"><%= countPPP %></span>
	                	<% } %>
	                	</a></li>
	                <% } if (PermissionsList.hasPermission(request, PermissionsList.pendingAccounts)){ %>
		     			<li><a href="ListAccountsServlet" target="_parent">Cuentas Pendientes
			     		<% if (countPA != 0){ %>
	                	<span class="badge red"><%= countPA %></span>
	                	<% } %>
	                	</a></li>
	                	<% } %>
	                
        		</ul>
        	</nav>
    	</div>
	</body>  
</html>