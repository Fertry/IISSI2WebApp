<?php

    // Iniciamos la sesión:
    session_start();
    
    // Llamamos a gestionBD.php
    require_once("gestionBD.php");
    
	// Comprobar que hemos llegado a esta página porque se ha rellenado el formulario:
	if (isset($_SESSION["user"])) {

        $acceso["usuario"] = $_REQUEST["usuario"];
        $acceso["password"] = $_REQUEST["password"];

        $_SESSION["user"] = $acceso;

    } else {

        Header("Location: personal.php");	

    }

    // Abrimos una conexion con la base de datos:
    $conexion = abrirConexionBD();

    // Recoger los errores:
    $erroresLogin = validarDatosLogin($acceso, $conexion);

    // Cerrar la conexión:
    cerrarConexionBD($conexion);

    // Si se encuentran errores se redirige a personal.php, de lo contrario se pasa a confirmacion_reserva.php:
    if (count($erroresLogin) > 0) {

        $_SESSION["erroresLogin"] = $erroresLogin;
        Header("Location: personal.php");

    } else {

        Header("Location: area_personal.php");

    }

    //////////////////////////////////////////////////
    // Validación en servidor del formulario de login
    //////////////////////////////////////////////////
    function validarDatosLogin($acceso, $conexion) {

        $erroresLogin = array();

        // Validacion de las credenciales:
        if ($acceso["usuario"] == "" || $acceso["password"] == "") {

            $erroresLogin[] = "<p>Todos los campos son obligatorios</p>";

        }

        return $erroresLogin;

    }

?>
