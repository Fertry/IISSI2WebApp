<?php 

    // Iniciamos la sesión:
    session_start();
    
    // Comprobar que hemos llegado a esta página porque se ha iniciado la sesión:
	if (!isset($_SESSION["user"])) {

        Header("Location: desconexion.php");	

    }

    if (!isset($_SESSION["cambio"])) {
	
        $cambio['actualPass'] = "";
        $cambio['newPassword'] = "";
        $cambio['newPasswordConfirmation'] = "";
        
        $_SESSION["cambio"] = $cambio;

    } else {

        $cambio = $_SESSION["cambio"];

    }

    // Si se encuentran errores en la validación, se recogen para mostrarlos:
    if (isset($_SESSION["erroresCambio"])) {
        
        $erroresCambio = $_SESSION["erroresCambio"];
        unset($_SESSION["erroresCambio"]);
        
    }

?>

<!DOCTYPE html>

<html lang="es">

<head>

    <!-- Cabecera -->
	<meta charset="UTF-8">
	<meta name="author" content="Casa Salvi">
    <link rel="icon" href="images/icono.png" type="image/png">
    <link rel="stylesheet" type="text/css" href="css/personalPassCSS.css"/>
	<meta name="classification" content="Restaurante">
	<meta name="description" content="Gestión del restaurante">
	<meta name="keywords" content="HTML, Casa Salvi, IISSI, gestión, personal">

    <!-- Scripts para la validación de la contraseña -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js" type="text/javascript"></script>
    <script src="js/validacion.js" type="text/javascript"></script>

	<title>Gestión Casa Salvi</title>
    
</head>

<body>

    <?php 

        include_once("header_personal.php");

    ?>

    <?php 

        include_once("navegacion.php");

    ?>

    <?php 

        include_once("navegacion_personal.php");

    ?>

    <?php

        if (isset($erroresCambio)) {

            echo "<div class=\"error\">";
            echo "<h4> Errores: </h4>";
            foreach ($erroresCambio as $errorCambio)
                echo $errorCambio;
            echo "</div>";

        } 

    ?>

        <main>

            <h2> Cambio de contraseña </h2>
            
            <div class = "formulario">

                <form id = "cambio", method = "post" action = "validacion_formulario_cambio.php" onsubmit = "return Confirmar();">
                    
                    <fieldset>
                        <legend>
                            Cambio de Credenciales
                        </legend>
                        
                        <div>
                            <label for = "actualPass">Contraseña actual: </label>
                            <input id = "actualPass" name = "actualPass" type = "password" placeholder = "" size = "30" required autofocus/>
                        </div>

                        <div>
                            <label for = "newPassword">Nueva contraseña: </label>
                            <input id = "newPassword" name = "newPassword" type = "password" placeholder = "" size = "30" required/>
                        </div>

                        <div>
                            <label for = "newPasswordConfirmation">Confirmar contraseña: </label>
                            <input id = "newPasswordConfirmation" name = "newPasswordConfirmation" type = "password" placeholder = "" size = "30" required/>
                        </div>

                        <div id = "errorDeCambio"></div>

                        <div id = "submit"> 
                            <input type = "submit" value = "Cambiar"/>
                        </div>

                </form>

            </div>

        </main>

    <div class = "desconexion">
        <a href = "desconexion.php"><button type = "button">Desconexión</button></a>
    </div>

    <br>

    <?php 

        // include_once("pie.php");

    ?>

</body>

</html>
