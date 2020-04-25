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
    if (isset($_SESSION["actualizarProducto"])) {

        $modificarPrecio["nombreProductoSeleccionado"] = $_REQUEST["nombreProductoSeleccionado"];
        $modificarPrecio["nuevoPrecioProducto"] = $_REQUEST["nuevoPrecioProducto"];

        // Guardar la variable local con los datos del formulario en la sesión:
        $_SESSION["actualizarProducto"] = $modificarPrecio;

        // Validar el formulario:
        $erroresActualizado = validarDatosActualizado($modificarPrecio);

    } else {

        Header("Location: insertado_producto.php");

    }

    // Si se encuentran errores se redirige a insertado_producto.php, de lo contrario se pasa a actualizar el producto:
    if (count($erroresActualizado) > 0) {

        $_SESSION["erroresActualizado"] = $erroresActualizado;
        Header("Location: insertado_producto.php");

    } else {

        // Abrimos la conexion con la BD:
        $conexion = abrirConexionBD();
        
        // Obtenemos el producto actualizado y el nuevo precio:
        $seleccionarNombre = $modificarPrecio["nombreProductoSeleccionado"];
        $modificarPrecio = $modificarPrecio["nuevoPrecioProducto"];

        // Consulta SQL que modifica el producto:
        modificarPrecioProducto($seleccionarNombre, $modificarPrecio, $conexion);

        // Cerramos la conexión:
        cerrarConexionBD($conexion);

        // Redirigimos a insertado_producto.php de nuevo:
        Header("Location: insertado_producto.php");

    }
    
    function modificarPrecioProducto($seleccionarNombre, $modificarPrecio, $conexion) {

        global $erroresActualizado;

        try {
 
            $consulta = "UPDATE Productos SET precioProducto = :precio WHERE nombre = :nombre";
            
            $stmt = $conexion -> prepare($consulta);

            $stmt -> bindParam(':nombre', $seleccionarNombre);
            $stmt -> bindParam(':precio', $modificarPrecio);

            $stmt -> execute();

            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: insertado_producto.php");

            $erroresActualizado[] = "<p>No se encuentra ningún producto para el nombre especificado</p>";
            return $erroresActualizado;

        }

    }

    function validarDatosActualizado($modificarPrecio) {

        $erroresActualizado = array();

        // Validación del nombre seleccionado:
        if ($modificarPrecio["nombreProductoSeleccionado"] == "") {

            $erroresActualizado[] = "<p>El nombre no puede estar vacío</p>";

        } else if (!preg_match("/[a-zA-Z]/", $modificarPrecio["nombreProductoSeleccionado"])) {

            $erroresActualizado[] = "<p>El nombre sólo puede contener carácteres alfabéticos</p>";

        }

        // Validación del nuevo precio:
        if ($modificarPrecio["nuevoPrecioProducto"] == "") {

            $erroresActualizado[] = "<p>El precio no puede ser nulo</p>";

        } else if (!preg_match("/[0-9]/", $modificarPrecio["nuevoPrecioProducto"])) {

            $erroresActualizado[] = "<p>El precio debe ser un dato numérico</p>";

        } else if ($modificarPrecio["nuevoPrecioProducto"] <= 0) {

            $erroresActualizado[] = "<p>El precio no puede ser menor o igual a 0</p>";

        }

        return $erroresActualizado;

    }

?>
         