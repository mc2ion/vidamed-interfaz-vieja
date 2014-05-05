<%@page import="domain.User"%>
<%
	User user2 = (User) session.getAttribute("user");
	String userName = "";
	if (user2 != null)
		userName = user2.getFirstName() ;
	Integer countPAD = (Integer) session.getAttribute("countPAD");
	Integer countPCN = (Integer) session.getAttribute("countPCN");
	Integer countPCNR = (Integer) session.getAttribute("countPCNR");
	Integer countPB = (Integer) session.getAttribute("countPB");
	Integer countPPD = (Integer) session.getAttribute("countPPD");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<script type="text/javascript" src="./js/jquery.js"></script>
		<script type="text/javascript" src="./js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>
	</head>
	<body>
		<div id="container">
			<nav>
         		<ul>
         			<li><a href="#">Bienvenido, <%= userName %></a></li>
                	<li><a href="ListAdmissionDischargesServlet">Altas Admisión<span class="badge yellow"><%= countPAD %></span></a></li>
		 			<li><a href="ListCreditNotesServlet">Prefacturas por Generar<span class="badge blue"><%= countPCN %></span></a></li>
		 			<li><a href="ListCreditNotesReviewServlet">Prefacturas por Revisar<span class="badge green"><%= countPCNR %></span></a></li>
		 			<li><a href="ListInvoicesServlet">Facturas por Generar<span class="badge red"><%= countPB %></span></a></li>
		     		<li><a href="ListRequestsServlet">Descuentos<span class="badge yellow">2</span></a></li>
		     		<li><a href="ListPharmacyDischargesServlet">Altas Farmacia<span class="badge blue"><%= countPPD %></span></a></li>
		     		<li><a href="ListBillingsServlet">Pagos Pendientes<span class="badge green">6</span></a></li>
        		</ul>
        	</nav>
    	</div>
	</body>  
</html>