<?php

    // Iniciamos la sesión:
    session_start();

    // Llamamos a gestionBD.php
    require_once("gestionBD.php");

    // Comprobar que hemos llegado a esta página porque se ha iniciado la sesión:
	if (!isset($_SESSION["user"])) {

        Header("Location: desconexion.php");	

    } 
    
    // Comprobar que hemos llegado a esta página porque se ha rellenado el formulario:
    if (isset($_SESSION["modificarMenu"])) {

        $modificarM["nombrePrimero"] = $_REQUEST["nombrePrimero"];
        $modificarM["precioPrimero"] = $_REQUEST["precioPrimero"];
        $modificarM["nombreSegundo"] = $_REQUEST["nombreSegundo"];
        $modificarM["precioSegundo"] = $_REQUEST["precioSegundo"];
        $modificarM["nombrePostre"] = $_REQUEST["nombrePostre"];
        $modificarM["precioPostre"] = $_REQUEST["precioPostre"];
        $modificarM["nombreBebida"] = $_REQUEST["nombreBebida"];
        $modificarM["precioBebida"] = $_REQUEST["precioBebida"];

        // Guardar la variable local con los datos del formulario en la sesión:
        $_SESSION["modificarMenu"] = $modificarM;

        // Validar el formulario:
        $erroresMenu = validarDatosMenu($modificarM);

    } else {

        Header("Location: actualizar_menu.php");

    }

    // Si se encuentran errores se redirige a actualizar_menu.php, de lo contrario se pasa a modificar el menú:
    if (count($erroresMenu) > 0) {

        $_SESSION["erroresMenu"] = $erroresMenu;
        Header("Location: actualizar_menu.php");

    } else {

        // Abrimos la conexion con la BD:
        $conexion = abrirConexionBD();
        
        // Obtenemos los detalles del producto:
        $nombrePP = $modificarM["nombrePrimero"];
        $precioPP = $modificarM["precioPrimero"];
        $nombreSP = $modificarM["nombreSegundo"];
        $precioSP = $modificarM["precioSegundo"];
        $nombreP = $modificarM["nombrePostre"];
        $precioP = $modificarM["precioPostre"];
        $nombreB = $modificarM["nombreBebida"];
        $precioB = $modificarM["precioBebida"];

        // Consulta SQL que añade el producto:
        actualizarMenuPrimero($nombrePP, $precioPP, $conexion);
        actualizarMenuSegundo($nombreSP, $precioSP, $conexion);
        actualizarMenuPostre($nombreP, $precioP, $conexion);
        actualizarMenuBebida($nombreB, $precioB, $conexion);

        // Cerramos la conexión:
        cerrarConexionBD($conexion);

        // Redirigimos a actualizar_menu.php de nuevo:
        Header("Location: actualizar_menu.php");

    }

    function actualizarMenuPrimero($nombrePP, $precioPP, $conexion) {

        global $erroresMenu;

        try {
 
            $consulta = "UPDATE ProductoMenu SET nombre = :nombrePP, precio = :precioPP WHERE tipoPlato = 'PRIMERPLATO'";

            $stmt = $conexion -> prepare($consulta);
            $stmt -> bindParam(':nombrePP', $nombrePP);
            $stmt -> bindParam(':precioPP', $precioPP);
            $stmt -> execute();

            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: actualizar_menu.php");

            $erroresMenu[] = "<p>Ha ocurrido un error al actualizar los datos en la BD para el primer plato</p>";
            return $erroresMenu;

        }

    }

    function actualizarMenuSegundo($nombreSP, $precioSP, $conexion) {

        global $erroresMenu;

        try {
 
            $consulta = "UPDATE ProductoMenu SET nombre = :nombreSP, precio = :precioSP WHERE tipoPlato = 'SEGUNDOPLATO'";

            $stmt = $conexion -> prepare($consulta);
            $stmt -> bindParam(':nombreSP', $nombreSP);
            $stmt -> bindParam(':precioSP', $precioSP);
            $stmt -> execute();

            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: actualizar_menu.php");

            $erroresMenu[] = "<p>Ha ocurrido un error al actualizar los datos en la BD para el segundo plato</p>";
            return $erroresMenu;

        }

    }

    function actualizarMenuPostre($nombreP, $precioP, $conexion) {

        global $erroresMenu;

        try {
 
            $consulta = "UPDATE ProductoMenu SET nombre = :nombreP, precio = :precioP WHERE tipoPlato = 'POSTRE'";

            $stmt = $conexion -> prepare($consulta);
            $stmt -> bindParam(':nombreP', $nombreP);
            $stmt -> bindParam(':precioP', $precioP);
            $stmt -> execute();

            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: actualizar_menu.php");

            $erroresMenu[] = "<p>Ha ocurrido un error al actualizar los datos en la BD para el postre</p>";
            return $erroresMenu;

        }

    }

    function actualizarMenuBebida($nombreB, $precioB, $conexion) {

        global $erroresMenu;

        try {
 
            $consulta = "UPDATE ProductoMenu SET nombre = :nombreB, precio = :precioB WHERE tipoPlato = 'BEBIDA'";

            $stmt = $conexion -> prepare($consulta);
            $stmt -> bindParam(':nombreB', $nombreB);
            $stmt -> bindParam(':precioB', $precioB);
            $stmt -> execute();

            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: actualizar_menu.php");

            $erroresMenu[] = "<p>Ha ocurrido un error al actualizar los datos en la BD para la bebida</p>";
            return $erroresMenu;

        }

    }

    function validarDatosMenu($modificarM) {

        $erroresMenu = array();

        // Validación de los nombres de los productos:
        if ($modificarM["nombrePrimero"] == "") {

            $erroresMenu[] = "<p>El nombre del primer plato no puede estar vacío</p>";

        } else if (!preg_match("/^[a-zA-Z ]+$/", $modificarM["nombrePrimero"])) {

            $erroresMenu[] = "<p>El nombre del primer plato sólo puede contener carácteres alfabéticos</p>";

        }

        if ($modificarM["nombreSegundo"] == "") {

            $erroresMenu[] = "<p>El nombre del segundo plato no puede estar vacío</p>";

        } else if (!preg_match("/^[a-zA-Z ]+$/", $modificarM["nombreSegundo"])) {

            $erroresMenu[] = "<p>El nombre del segundo plato sólo puede contener carácteres alfabéticos</p>";

        }

        if ($modificarM["nombrePostre"] == "") {

            $erroresMenu[] = "<p>El nombre del postre no puede estar vacío</p>";

        } else if (!preg_match("/^[a-zA-Z ]+$/", $modificarM["nombrePostre"])) {

            $erroresMenu[] = "<p>El nombre del postre sólo puede contener carácteres alfabéticos</p>";

        }

        if ($modificarM["nombreBebida"] == "") {

            $erroresMenu[] = "<p>El nombre de la bebida no puede estar vacío</p>";

        } else if (!preg_match("/^[a-zA-Z ]+$/", $modificarM["nombreBebida"])) {

            $erroresMenu[] = "<p>El nombre de la bebida sólo puede contener carácteres alfabéticos</p>";

        }

        // Validación de los precios de los productos:
        if ($modificarM["precioPrimero"] == "") {

            $erroresMenu[] = "<p>El precio del primer plato no puede ser nulo</p>";

        } else if (!preg_match("/[0-9]/", $modificarM["precioPrimero"])) {

            $erroresMenu[] = "<p>El precio del primer plato debe ser un dato numérico</p>";

        } else if ($modificarM["precioPrimero"] <= 0) {

            $erroresMenu[] = "<p>El precio del primer plato no puede ser menor o igual a 0</p>";

        }

        if ($modificarM["precioSegundo"] == "") {

            $erroresMenu[] = "<p>El precio del segundo plato no puede ser nulo</p>";

        } else if (!preg_match("/[0-9]/", $modificarM["precioSegundo"])) {

            $erroresMenu[] = "<p>El precio del segundo plato debe ser un dato numérico</p>";

        } else if ($modificarM["precioSegundo"] <= 0) {

            $erroresMenu[] = "<p>El precio del segundo plato no puede ser menor o igual a 0</p>";

        }

        if ($modificarM["precioPostre"] == "") {

            $erroresMenu[] = "<p>El precio del postre no puede ser nulo</p>";

        } else if (!preg_match("/[0-9]/", $modificarM["precioPostre"])) {

            $erroresMenu[] = "<p>El precio del postre debe ser un dato numérico</p>";

        } else if ($modificarM["precioPostre"] <= 0) {

            $erroresMenu[] = "<p>El precio del postre no puede ser menor o igual a 0</p>";

        }

        if ($modificarM["precioBebida"] == "") {

            $erroresMenu[] = "<p>El precio de la bebida no puede ser nulo</p>";

        } else if (!preg_match("/[0-9]/", $modificarM["precioBebida"])) {

            $erroresMenu[] = "<p>El precio de la bebida debe ser un dato numérico</p>";

        } else if ($modificarM["precioBebida"] <= 0) {

            $erroresMenu[] = "<p>El precio de la bebida no puede ser menor o igual a 0</p>";

        }

        return $erroresMenu;

    }

?>
