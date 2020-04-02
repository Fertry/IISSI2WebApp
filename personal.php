<?php

    // Iniciamos la sesión:
    session_start();

    // Llamamos a gestionBD.php
    require_once("gestionBD.php");
    
    // Comprobamos que no existen datos en la sesión: por tanto se crea una entrada con valores por defecto (vacíos):
    if (!isset($_SESSION["formulario_personal"])) {

        $formulario_personal["nombre"] = "";
        $formulario_personal["apellidos"] = "";

        $_SESSION["formulario_personal"] = $formulario_personal;

    } else {

        // Si ya existen valores en la sesión se usan para inicializar el formulario:
        $formulario_personal = $_SESSION["formulario_personal"];

    }

    // Si se encuentran errores en la validación, se recogen para mostrarlos:
    if (isset($_SESSION["errores_personal"])) {
        
        $errores_personal = $_SESSION["errores_personal"];
        unset($_SESSION["errores_personal"]);

    }

    // Abrimos una conexion con la base de datos:
    // $conexion = abrirConexionBD();

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

    <!-- Scripts JS para la validación en cliente -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js" type="text/javascript"></script>
    <script src="js/validacion_reserva.js" type="text/javascript"></script>
	<title>Acceso Personal</title>
    
</head>

<body>

    <script>
    // Validación de datos en cliente mediante JS:

    </script>

    <?php 

        include_once("header_personal.php");

    ?>

    <?php 

       include_once("navegacion.php");

    ?>

    <div class = "formulario">

        <main>

            <h2> Acceso Personal </h2>

            <form id = "aacesoPersonal", method="post" action="validacion_formulario_personal.php">
                
                <fieldset>
                    <legend>
                        Acceso
                    </legend>
                    
                    <div>
                        <label for = "usuario">Usuario: </label>
                        <input id = "usuario" name = "usuario" type = "text" placeholder = "" size = "30" required autofocus/>
                    </div>

                    <div>
                        <label for = "pass">Contraseña: </label>
                        <input id = "pass" name = "pass" type = "password" placeholder = "" size = "30" required/>
                    </div>

                    <div> 
                        <input type = "submit" value = "Acceder"/>
                    </div>

            </form>

        </main>

    </div>

    <?php

    // cerrarConexionBD($conexion);

    ?>

</body>

</html>
