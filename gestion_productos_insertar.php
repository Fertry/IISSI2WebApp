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
        // $introducir["tipoProducto"] = $_REQUEST["tipoProducto"];
        
        // Guardar la variable local con los datos del formulario en la sesión:
        $_SESSION["insertarProducto"] = $introducir;

        // Validar el formulario:
        $erroresInsertado = validarDatosInsertado($introducir);

    } else {

        Header("Location: insertado_producto.php");

    }

    // Si se encuentran errores se redirige a insertado_producto.php, de lo contrario se pasa a introducir el producto:
    if (count($erroresInsertado) > 0) {

        $_SESSION["erroresInsertado"] = $erroresInsertado;
        Header("Location: insertado_producto.php");

    } else {

        // Abrimos la conexion con la BD:
        $conexion = abrirConexionBD();
        
        // Obtenemos los detalles del producto:
        $insertarNombre = $introducir["nombreProducto"];
        $insertarPrecio = $introducir["precioProducto"];
        // $insertarTipo = $introducir["tipoProducto"];

        // Consulta SQL que añade el producto:
        insertarProducto($insertarNombre, $insertarPrecio, $conexion);

        // Cerramos la conexión:
        cerrarConexionBD($conexion);

        // Redirigimos a insertado_producto.php de nuevo:
        Header("Location: insertado_producto.php");

    }
    
    function insertarProducto($insertarNombre, $insertarPrecio, $conexion) {

        global $erroresInsertado;

        try {
 
            $consulta = "INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES (:nombre, null, null, null, :precio)";

            $stmt = $conexion -> prepare($consulta);

            $stmt -> bindParam(':nombre', $insertarNombre);
            // $stmt -> bindParam(':tipoProducto', $insertarTipo);
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

        // Validación del tipo:
        // if ($introducir["tipoProducto"] == "") {

        //    $erroresInsertado[] = "<p>El tipo de producto no puede ser nulo</p>";

        // } else if ($introducir["tipoProducto"] != "PRIMERPLATO" && $introducir["tipoProducto"] != "SEGUNDOPLATO" && $introducir["tipoProducto"] != "POSTRE" && $introducir["tipoProducto"] != "BEBIDA") {

        //    $erroresInsertado[] = "<p>El tipo de producto no es válido</p>";

        // }
        
        return $erroresInsertado;

    }

?>
         