<?php

    // Iniciamos la sesión:
    session_start();

    // Comprobamos que no existen datos en la sesión: por tanto se crea una entrada con valores por defecto (vacíos):
    if (!isset($_SESSION["user"])) {

        $user["usuario"] = "";
        $user["password"] = "";

        $_SESSION["user"] = $user;

    } else {

        // Si ya existen valores en la sesión se usan para inicializar el formulario:
        $user = $_SESSION["user"];

    }

    // Si se encuentran errores en la validación, se recogen para mostrarlos:
    if (isset($_SESSION["erroresLogin"])) {
        
        $erroresLogin = $_SESSION["erroresLogin"];
        // unset($_SESSION["erroresLogin"]);

    }

?>

<!DOCTYPE html>

<html lang="es">

<head>

    <!-- Cabecera del formulario -->
	<meta charset="UTF-8">
	<meta name="author" content="Casa Salvi">
    <link rel="icon" href="images/icono.png" type="image/png">
    <link rel="stylesheet" type="text/css" href="css/restaurante.css"/>
	<meta name="classification" content="Restaurante">
	<meta name="description" content="Acceso al personal del restaurante">
	<meta name="keywords" content="HTML, Casa Salvi, IISSI, forms, personal">

	<title>Acceso Personal</title>
    
</head>

<body>

    <?php 

        include_once("header_personal.php");

    ?>

    <?php 

       include_once("navegacion.php");

    ?>
    <br>

    <?php

        if (isset($erroresLogin) && count($erroresLogin) > 0) {

            echo "<div class=\"error\">";
            echo "<h4> Acceso denegado: </h4>";
            foreach ($erroresLogin as $errorLogin)
                echo $errorLogin;
            echo "</div>";

        } 

    ?>

    <div class = "formulario">

        <main>

            <h2> Acceso Personal </h2>

            <form id = "user", method="post" action="validacion_formulario_personal.php">
                
                <fieldset>
                    <legend>
                        Acceso
                    </legend>
                    
                    <div>
                        <label for = "usuario">Usuario: </label>
                        <input id = "usuario" name = "usuario" type = "text" placeholder = "" size = "30" required autofocus/>
                    </div>

                    <div>
                        <label for = "password">Contraseña: </label>
                        <input id = "password" name = "password" type = "password" placeholder = "" size = "30" required/>
                    </div>

                    <div> 
                        <input type = "submit" value = "Acceder"/>
                    </div>

            </form>

        </main>

    </div>

</body>

</html>
