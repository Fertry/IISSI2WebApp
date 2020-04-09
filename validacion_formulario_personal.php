<?php

    // Iniciamos la sesión:
    session_start();
    
    // Llamamos a gestionBD.php
    require_once("gestionBD.php");

	// Comprobar que hemos llegado a esta página porque se ha rellenado el formulario:
	if (isset($_SESSION["user"])) {

        $acceso["usuario"] = $_REQUEST["usuario"];
        $acceso["password"] = $_REQUEST["password"];

        // Guardar la variable local con los datos del formulario en la sesión:
        $_SESSION["user"] = $acceso;

    } else {

        Header("Location: personal.php");	

    }

    // Abrimos una conexion con la base de datos:
    $conexion = abrirConexionBD();

    // Obtener el nombre de usuario:
    $nombreUsuario = obtenerNombreUsuario($conexion);

    // Obtener la contraseña:
    $pass = obtenerPassword($conexion);

    // Validar el formulario:
    $erroresLogin = validarDatosLogin($acceso, $nombreUsuario, $pass);

    // Cerrar la conexión:
    cerrarConexionBD($conexion);

    // Si se encuentran errores se redirige a personal.php, de lo contrario se pasa a area_personal.php:
    if (count($erroresLogin) > 0) {

        $_SESSION["erroresLogin"] = $erroresLogin;
        Header("Location: personal.php");

    } else {

        Header("Location: area_personal.php");

    }

    //////////////////////////////////////////////////
    // Validación en servidor del formulario de login
    //////////////////////////////////////////////////
    function validarDatosLogin($acceso, $nombreUsuario, $pass) {

        $erroresLogin = array();

        // Validacion de las credenciales:
        if ($acceso["usuario"] == "" || $acceso["password"] == "") {

            $erroresLogin[] = "<p>Todos los campos son obligatorios</p>";

        }

        // Validación del nombre de usuario:
        if (!preg_match("/[a-zA-Z]/", $acceso["usuario"])) {

            $erroresLogin[] = "<p>Los datos introducidos no son válidos</p>";

        }

        // Validación de la contraseña:
        if (!preg_match("/[a-zA-Z]/", $acceso["password"])) {

            $erroresLogin[] = "<p>Los datos introducidos no son válidos</p>";

        }

        // Comprobación de las credenciales con la BD:
        if ($acceso["usuario"] != $nombreUsuario || $acceso["password"] != $pass) {

            $erroresLogin[] = "<p>Las credenciales no son válidas</p>";

        }

        return $erroresLogin;

    }

    function obtenerNombreUsuario($conexion) {

        global $erroresLogin;

        try {

            // Consulta a la BD el nombre de usuario del administrador:
            $consultaUsuario = "SELECT usuario FROM Usuarios WHERE (clase = 'GERENTE')";

            $stmt = $conexion -> prepare($consultaUsuario);

            $stmt -> execute();
            $dato = $stmt -> fetch();

            return $dato;

        } catch(PDOException $e) {

            $erroresLogin[] = "<p>Lo sentimos, se ha producido un fallo al acceder a la base de datos</p>";
            // echo "Error: " . $e -> GetMessage();
            
            return $erroresLogin;

        }

    }

    function obtenerPassword($conexion) {

        global $erroresLogin;

        try {

            // Consulta a la BD la contraseña del administrador:
            $consultaPass = "SELECT pass FROM Usuarios WHERE (clase = 'GERENTE')";

            $stmt = $conexion -> prepare($consultaPass);

            $stmt -> execute();
            $dato = $stmt -> fetch();

            return $dato;

        } catch(PDOException $e) {

            $erroresLogin[] = "<p>Lo sentimos, se ha producido un fallo al acceder a la base de datos</p>";
            // echo "Error: " . $e -> GetMessage();
            
            return $erroresLogin;

        }

    }

?>
