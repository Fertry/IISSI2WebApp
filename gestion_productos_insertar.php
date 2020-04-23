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
    if (isset($_SESSION["insertarProducto"])) {

        $introducir["nombreProducto"] = $_REQUEST["nombreProducto"];
        $introducir["precioProducto"] = $_REQUEST["precioProducto"];

        // Guardar la variable local con los datos del formulario en la sesión:
        $_SESSION["insertarProducto"] = $introducir;

        // Validar el formulario:
        $erroresInsertado = validarDatosInsertado($introducir);

    } else {

        Header("Location: area_personal_productos.php");

    }

    // Si se encuentran errores se redirige a area_personal_productos.php, de lo contrario se pasa a introducir el producto:
    if (count($erroresInsertado) > 0) {

        $_SESSION["erroresInsertado"] = $erroresInsertado;
        Header("Location: insertado_producto.php");

    } else {

        // Abrimos la conexion con la BD:
        $conexion = abrirConexionBD();
        
        // Obtenemos los detalles del producto:
        $insertarNombre = $introducir["nombreProducto"];
        $insertarPrecio = $introducir["precioProducto"];

        // Consulta SQL que añade el producto:
        insertarProducto($insertarNombre, $insertarPrecio, $conexion);

        // Cerramos la conexión:
        cerrarConexionBD($conexion);

        // Redirigimos a area_personal_productos.php de nuevo:
        Header("Location: insertado_producto.php");

    }
    
    function insertarProducto($insertarNombre, $insertarPrecio, $conexion) {

        global $erroresInsertado;

        try {
 
            $consulta = "INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES (:nombre, null, null, null, :precio)";

            $stmt = $conexion -> prepare($consulta);

            $stmt -> bindParam(':nombre', $insertarNombre);
            $stmt -> bindParam(':precio', $insertarPrecio);

            $stmt -> execute();

            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: insertado_producto.php");

            $erroresInsertado[] = "<p>Ha ocurrido un error al guardar los datos en la BD</p>";
            return $erroresInsertado;

        }

    }

    function validarDatosInsertado($introducir) {

        $erroresInsertado = array();

        // Validación del nombre:
        if ($introducir["nombreProducto"] == "") {

            $erroresInsertado[] = "<p>El nombre no puede estar vacío</p>";

        } else if (!preg_match("/[a-zA-Z]/", $introducir["nombreProducto"])) {

            $erroresInsertado[] = "<p>El nombre sólo puede contener carácteres alfabéticos</p>";

        }

        // Validación del precio:
        if ($introducir["precioProducto"] == "") {

            $erroresInsertado[] = "<p>El precio no puede ser nulo</p>";

        } else if (!preg_match("/[0-9]/", $introducir["precioProducto"])) {

            $erroresInsertado[] = "<p>El precio debe ser un dato numérico</p>";

        } else if ($introducir["precioProducto"] <= 0) {

            $erroresInsertado[] = "<p>El precio no puede ser menor o igual a 0</p>";

        }

        return $erroresInsertado;

    }

?>
         