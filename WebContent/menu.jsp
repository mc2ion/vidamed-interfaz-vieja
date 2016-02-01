<%@page import="domain.PermissionsList"%>
<div class="ayudaitemHome" style="cursor:pointer;"><a target="popup" onclick="window.open('./HelpServlet','Ayuda','width=800,height=600')">Ayuda</a></div>	
<div id='cssmenu'>
		<ul>
			<%
		   	boolean perm = PermissionsList.hasPermission(request, PermissionsList.patient);
			if (perm){
			%>
			<li class='first'><a href='ListPatientsServlet'><span>Pacientes</span></a></li>
			<%	
			}		   	
		   	perm  = PermissionsList.hasPermission(request, PermissionsList.estimation);
		    if (perm){
		   %>
		   <li><a href='ListEstimationsServlet'><span>Presupuesto</span></a></li>
		   <% } %>
		   <%
		   	perm  = PermissionsList.hasPermission(request, PermissionsList.emergency);
		    if (perm){
		   %>
		   <li><a href='ListEmergenciesServlet'><span>Emergencia</span></a></li>
		   <% }
		   	perm  = PermissionsList.hasPermission(request, PermissionsList.admission);
		    if (perm){
		   %>
		   <li><a href='ListAdmissionsServlet'><span>Admisión</span></a></li>
		    <% } 
		   	perm  = PermissionsList.hasPermission(request, PermissionsList.hospitalization);
		    if (perm){
		   %>
		   <li><a href='ListHospitalizationsServlet'><span>Hospitalización</span></a></li>
		   <% }
		   	boolean perm1  = PermissionsList.hasPermission(request, PermissionsList.medicalTAdmin );
		   	boolean perm2  = PermissionsList.hasPermission(request, PermissionsList.medicalTPacient );
			   	
		    if (perm1 || perm2){
		   %>
		    <li class='has-sub'>
		      <a href='#'><span>Tratamientos M&eacute;dicos</span></a>
			  <ul>
		         <% if (perm1){  %>
		         <li class='first'><a href='ListMedicalTreatmentsAdminServlet'><span>Administrar</span></a></li>
		         <% } if (perm2){  %>
		         <li class='last'><a href='ListMedicalTreatmentsServlet'><span>Ver Pacientes</span></a></li>
		         <% } %>
		      </ul>
		   </li>
		   <%
		    }
		   	perm  = PermissionsList.hasPermission(request, PermissionsList.users);
		    if (perm){
		   %>
		   <li><a href='ListUsersServlet'><span>Usuarios</span></a></li>
		   <%  }
		    perm  = PermissionsList.hasPermission(request, PermissionsList.protocols);
		    if (perm){
		    %>
		   <li><a href='ListProtocolsServlet'><span>Protocolos</span></a></li>
		    <% 
		    }
		   	perm  = PermissionsList.hasPermission(request, PermissionsList.rayX);
		    if (perm){
		   %>
		   <li><a href='ListXRayReportsServlet'><span>Rayos X</span></a></li>
		   <%  } 
		  	perm1  = PermissionsList.hasPermission(request, PermissionsList.pharmacyAdmin );
		   	perm2  = PermissionsList.hasPermission(request, PermissionsList.pharmacyPatients );
			if (perm1 || perm2){
		   %>
		  	 <li class='has-sub'>
				<a href='#'><span>Farmacia</span></a>
			      <ul>
			      	 <% if (perm1){ %>
			         <li class='first'><a href='ListSupplyAreasServlet'><span>Administrar</span></a></li>
			         <% } if (perm2){ %>
			         <li class='last'><a href='ListSupplyServlet'><span>Ver Pacientes</span></a></li>
			         <% } %>
			      </ul>
		   </li>
		   <% } 
		   	perm1  = PermissionsList.hasPermission(request, PermissionsList.billsH );
		   	perm2  = PermissionsList.hasPermission(request, PermissionsList.billsRP );
		   	boolean perm3  = PermissionsList.hasPermission(request, PermissionsList.billsGN );
		   	boolean perm4  = PermissionsList.hasPermission(request, PermissionsList.billsPP );
		   	if (perm1 || perm2 || perm3 || perm4 ){
		   %>
			   <li class='has-sub'>
				<a href='#'><span>Facturación</span></a>
			      <ul>
			      	 <% if (perm1){ %>
			         <li class='first'><a href='ListBillingsHServlet'><span>Honorarios Médicos</span></a></li>
			         <% } if (perm2){ %>
			         <li><a href='ListBillingsRPServlet'><span>Relación de Pago</span></a></li>
			         <% } if (perm4){ %>
			         <li class='last'><a href='ListBillingsPPServlet'><span>Pronto Pago</span></a></li>
			         <% } %>
			      </ul>
			   </li>
		    <%
		   	}
		   	perm  = PermissionsList.hasPermission(request, PermissionsList.units);
		    if (perm){
		   %>
		   <li><a href='ListUnitsServlet'><span>Unidades</span></a></li>
		   <%  } 
		   	perm  = PermissionsList.hasPermission(request, PermissionsList.specialists);
		    if (perm){
		   %>
		   <li><a href='ListSpecialistsServlet'><span>Especialistas</span></a></li>
		   <% }
			  perm  = PermissionsList.hasPermission(request, PermissionsList.paymentResponsible);
			  if (perm){
		    %>
		   <li><a href='ListPaymentResponsiblesServlet'><span>Responsables de Pago</span></a></li>
		   <%
			  }
			  perm  = PermissionsList.hasPermission(request, PermissionsList.cashBoxes);
		      if (perm){
		   %>
		   <li><a href='ListCashBoxesServlet'><span>Cajas</span></a></li>
		   <%  }
		      perm  = PermissionsList.hasPermission(request, PermissionsList.pendingAccounts);
		      if (perm){
		      %>
		   <li><a href='ListAccountsServlet'><span>Cuentas por Cobrar</span></a></li>
		   <%  }
		      perm  = PermissionsList.hasPermission(request, PermissionsList.bloodBank);
		      if (perm){
		      %>
		   <li><a href='ListBloodBankServlet'><span>Banco de Sangre</span></a></li>
		   <%  }
		      perm  = PermissionsList.hasPermission(request, PermissionsList.eco);
		      if (perm){
		      %>
		   <li><a href='ListEcoServlet'><span>Ecosonograf&iacute;a</span></a></li>
		   <%  }
		      perm  = PermissionsList.hasPermission(request, PermissionsList.lab);
		      if (perm){
		      %>
		   <li><a href='ListLabServlet'><span>Laboratorio</span></a></li>
		   <%  }
		      perm  = PermissionsList.hasPermission(request, PermissionsList.interc);
		      if (perm){
		      %>
		   <li ><a href='ListInterServlet'><span>Interconsultas</span></a></li>
		   <%  } 
		      perm  = PermissionsList.hasPermission(request, PermissionsList.reports);
		      if (perm){
		      %>
		   <li class='last'><a href='ListReportsServlet'><span>Reportes</span></a></li>
		   <%  } %>
		</ul>
</div>   