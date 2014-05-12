<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="./css/styleAdmin.css" />
	<title>Vidamed - Administrador</title>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body >
	<div id="containerIni">
		<div id="header">
			
        </div>  
        <div id="menu"> </div>            
       			 <div id="wrapper">
       			 			<% String error = (String) request.getAttribute("error");
							if (error != null){
							%>
								<div class="login-error"><%= error %></div>
							<%
							}
							%>
	                        <div id="login" class="animate form">
	                            <form  action="/vidamed/UserLoginServlet" method="post" > 
	                                <h1> </h1> 
	                                <p> 
	                                    <label for="username" class="uname" data-icon="u" > Nombre de usuario </label>
	                                    <input id="username" name="username" type="text" placeholder="MiNombreUsuario" title="Debe colocar el Nombre de Usuario" required/>
	                                </p>
	                                <p> 
	                                    <label for="password" class="youpasswd" data-icon="p"> Tu contrase&ntilde;a </label>
	                                    <input id="password" name="password" type="password" placeholder="Ej. X8df!90EO" title="Debe colocar la contraseña" required /> 
	                                </p>
									 <div class="buttonCenter">
										<input type="submit" name="sbmtButton" class="button" value="Acceder" />
									</div>
								   
	                            </form>
	                        </div>
	                       </div>
	       </div>
   </body>
</html>