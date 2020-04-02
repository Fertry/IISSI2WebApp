<?php

    // Iniciamos la sesión:
    session_start();
    
    // Llamamos a gestionBD.php
    require_once("gestionBD.php");
    
	// Comprobar que hemos llegado a esta página porque se ha rellenado el formulario:
	if (isset($_SESSION["formulario"])) {

        $reserva["nombre"] = $_REQUEST["nombre"];
        $reserva["apellidos"] = $_REQUEST["apellidos"];
        $reserva["edad"] = $_REQUEST["edad"];
        $reserva["telefono"] = $_REQUEST["telefono"];
        $reserva["numeroPersonas"] = $_REQUEST["numeroPersonas"];
        $reserva["fecha"] = $_REQUEST["fecha"];
        
        $_SESSION["formulario"] = $reserva;

    } else {

        Header("Location: reservas.php");	

    }

    // Abrimos una conexion con la base de datos:
    $conexion = abrirConexionBD();

    // Recoger los errores:
    // Validación PHP en servidor:
    $errores = validarDatos($reserva, $conexion);


    // Cerrar la conexión:
    cerrarConexionBD($conexion);

    // Si se encuentran errores se redirige a reservas.php, de lo contrario se pasa a confirmacion_reserva.php:
    if (count($errores) > 0) {

        $_SESSION["errores"] = $errores;
        Header("Location: reservas.php");

    } else {

        Header("Location: confirmacion_reserva.php");

    }

    ////////////////////////////////////////////////////
    // Validación en servidor del formulario de reserva
    ////////////////////////////////////////////////////
    function validarDatos($reserva, $conexion) {

        $errores = array();

        // Validacion del nombre:
        if ($reserva["nombre"] == "") {

            $errores[] = "<p>El nombre no puede estar vacío</p>";

        } else if (!preg_match("/[a-zA-Z]", $reserva["nombre"] || strlen($reserva["nombre"] < 3 ) || strlen($reserva["nombre"] > 30)){
            
            $errores[] = "<p>El nombre no es válido</p>";

        }

        // Validación del apellido:
        if ($reserva["apellidos"] == "") {

            $errores[] = "<p>El apellido no puede estar vacío</p>";

        } else if (!preg_match("/[a-zA-Z]/", $reserva["apellidos"] || strlen($reserva["apellidos"] < 10 ) || strlen($reserva["nombre"] > 50)){
            
            $errores[] = "<p>Los apellidos no son válidos</p>";

        }

        // Validación de la edad:
        if ($reserva["edad"] == "") {

            $errores[] = "<p>La edad no puede estar vacía</p>";

        } else if (!preg_match("/[0-9]/", $reserva["edad"])) {

            $errores[] = "<p>La edad debe ser un dato numérico</p>";

        } else if ($reserva["edad"] < 18 || $reserva["edad"] > 100) {

            $errores[] = "<p>La edad debe estar comprendida entre 18 y 100</p>";

        }

        // Validación del nº de teléfono:
        if ($reserva["telefono"] == "") {

            $errores[] = "<p>El teléfono no puede estar vacío</p>";

        } else if (!preg_match("/[0-9]/", $reserva["telefono"]) || strlen($reserva["telefono"]) != 9) {
            
            $errores[] = "<p>El teléfono no es válido</p>";

        }

        // Validación del nº de personas:
        if ($reserva["numeroPersonas"] == "") {

            $errores[] = "<p>El número de personas no puede estar vacío</p>";

        } else if (!preg_match("/[0-9]/", $reserva["numeroPersonas"])) {

            $errores[] = "<p>El número de personas debe ser un dato numérico</p>";

        } else if ($reserva["numeroPersonas"] < 1 || $reserva["numeroPersonas"] > 10) {
            
            $errores[] = "<p>El número de personas debe estar comprendido entre 1 y 10</p>";

        }

        // Validación de la fecha:
        if ($reserva["fecha"] == "") {

            $errores[] = "<p>La fecha no puede estar vacía</p>";

        } else if ($reserva["fecha"] < $now) {

            $errores[] = "<p>La fecha no debe ser posterior a hoy</p>";

        }

        // Validación de disponibilidad de mesas en la BD para el numeroPersonas introducido:
        

        return $errores;

    }

    function validacionDB

?>

