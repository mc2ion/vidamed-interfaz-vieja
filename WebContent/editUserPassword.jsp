<%@page import="domain.User"%>
<%
	User user = (User) session.getAttribute("user");
	String name = "";
	if (user != null)
		name = user.getFirstName() ;
%>
<% Long userID = (Long) request.getAttribute("userID"); %>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
		<title>Editar Contrase�a</title>
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/ui-lightness/jquery-ui.css" />
		<link href="./css/multi-select.css" media="screen" rel="stylesheet" type="text/css">
	  	<script src="./js/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script type="text/javascript" src="./js/jquery.leanModal.min.js"></script>		
		<!--JS Datapicker-->
		<script type="text/javascript" src="./js/jquery.ui.datepicker-es.js"></script>
		<!--JS Buscador de Multiselect-->
		<script type="text/javascript" src="./js/jquery.quicksearch.js"></script>
		<script>
			$(function() {
				 $("#txtPasswordRpt").keyup(function(e) {
				        var pass = $("#txtPassword").val();
				        var re_pass=$("#txtPasswordRpt").val();
				 
				        if(pass != re_pass) {
				            $("#txtPasswordRpt").css({"background":"#F22" }); 
				        }
				        else if(pass == re_pass) {
				            $("#txtPasswordRpt").css({"background":"#8F8"});
				        }
				    });
			});
		</script>
		<script>
			$(function() {    
            	$('#sbmtButton').click(function(event) { 
            		/*if ($('#txtOldPassword').val() == '') {
            			alert("Debe colocar su contrase�a actual.");
            		}
            		else*/ if ($('#txtPassword').val() == '') {
            			alert("Debe colocar su nueva contrase�a.");
            		}
            		else if ($('#txtPasswordRpt').val() == '') {
            			alert("Debe reescribir su nueva contrase�a.");
            		}
            		else {
            			//var tPassword=$('#txtOldPassword').val();
                    	//var tUserID=$('#userID').val(); 
                    	if ($('#txtPassword').val() == $('#txtPasswordRpt').val()) {
                    		/*$.get('verifyPassword.jsp',{userID:tUserID, password:tPassword}, function(responseText) { 
                    			if(responseText.trim() == 'valid') {
                           			$('#form1').submit();
                        		}
                        		else {
                           			alert("La contrase�a actual que introdujo no es v�lida.");
                        		}
                    		});*/
                    		$('#form1').submit();
                    	}
                    	else {
                    		alert("Las contrase�as no coinciden");
                    	}
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
		    	<ul>
	            	<li class="menuitem"><a href="ListUsersServlet">Ver Usuarios</a></li>
            		<li class="menuitem"><a href="CreateUserServlet">Crear Usuario</a></li>
	            </ul>
				<div class="menuitemSalir"><a href="LogoutServlet"><%= name %> (Salir)</a></div>	
        	</div>        
			 <jsp:include page="./menu.jsp" />
        	<div id="content" style="position: absolute; left: 0; top: 75px;">	
	        	<h2>Editar Contrase�a:</h2>
				<br>
				<form id="form1" action="EditUserPasswordServlet">
					<input type="hidden" id="userID" name="userID" value="<%= userID %>" />
					<fieldset>
						<br><br>
						<!-- <label for="name">Contrase�a anterior:</label>
						<input type="password" name="txtOldPassword" id="txtOldPassword" maxlength="50" title="Debe colocar su contrase�a actual." required /><br><br>
						 --><label for="name">Contrase�a nueva:</label>
						<input type="password" name="txtPassword" id="txtPassword" maxlength="50" title="Debe colocar su nueva contrase�a." required /><br><br>
						<label for="name">Repita contrase�a:</label>
						<input type="password" name="txtPasswordRpt" id="txtPasswordRpt" maxlength="50" title="Debe reescribir su nueva contrase�a." required /><br><br>
						<br><br><br><br><br>	
					</fieldset>	
					<div id="botonera">
						<div id="botonP" style="display: inline; margin-right: 30px;">
							<input type="button"  class="button" id="sbmtButton"  name="sbmtButton" value="Modificar" />
						</div>	
						<div id="botonV" style="display: inline;">
							<input type="button" class="button" value="Regresar" onClick="javascript:history.back();" />		
						</div>	
					</div><br>
				</form>
			</div>
		</div>
	</body>
</html>