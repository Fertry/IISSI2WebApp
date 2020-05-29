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

        $modificarPrecio["IdProductoSeleccionado"] = $_REQUEST["IdProductoSeleccionado"];
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
        $seleccionarId = $modificarPrecio["IdProductoSeleccionado"];
        $modificarPrecio = $modificarPrecio["nuevoPrecioProducto"];

        // Comprobar que existe el id:
        $existe = existenciaId($seleccionarId, $conexion);

        if ($existe != 1) {

            $erroresActualizado[] = "<p>No se encuentra ningún producto para el Id especificado</p>";
            $_SESSION["erroresActualizado"] = $erroresActualizado;
            
            // Cerramos la conexión:
            cerrarConexionBD($conexion);

            // Redirigimos a insertado_producto.php de nuevo:
            Header("Location: insertado_producto.php");

        } else {

            // Consulta SQL que modifica el producto:
            modificarPrecioProducto($seleccionarId, $modificarPrecio, $conexion);

            // Cerramos la conexión:
            cerrarConexionBD($conexion);
    
            // Redirigimos a insertado_producto.php de nuevo:
            Header("Location: insertado_producto.php");

        }

    }

    function existenciaId($seleccionarId, $conexion) {

        global $erroresActualizado;

        try {

            $existencia = "SELECT COUNT(idProducto) AS TOTAL FROM Productos WHERE idProducto = :idSeleccionado";

            $stmt = $conexion -> prepare($existencia);
            $stmt -> bindParam(':idSeleccionado', $seleccionarId);
            $stmt -> execute();

            $result = $stmt -> fetch();
            $total = $result['TOTAL'];

            return $total;

        } catch (PDOException $e)  {

            // Header("Location: insertado_producto.php");

            // echo "Error: " . $e -> GetMessage();
            $erroresActualizado[] = "<p>No se encuentra ningún producto para el Id especificado</p>";
            return $erroresActualizado;

        }

    }
    
    function modificarPrecioProducto($seleccionarId, $modificarPrecio, $conexion) {

        global $erroresActualizado;

        try {

            $consulta = "UPDATE Productos SET precioProducto = :precio WHERE idProducto = :id";
            
            $stmt = $conexion -> prepare($consulta);

            $stmt -> bindParam(':id', $seleccionarId);
            $stmt -> bindParam(':precio', $modificarPrecio);

            $stmt -> execute();

            return "";

        } catch (PDOException $e) {

            // Header("Location: insertado_producto.php");

            // echo "Error: " . $e -> GetMessage();
            $erroresActualizado[] = "<p>Se ha producido un error al cambiar el precio</p>";
            return $erroresActualizado;

        }

    }

    function validarDatosActualizado($modificarPrecio) {

        $erroresActualizado = array();

        // Validación del nombre seleccionado:
        if ($modificarPrecio["IdProductoSeleccionado"] == "") {

            $erroresActualizado[] = "<p>El ID no puede estar vacío</p>";

        } else if (!preg_match("/[0-9]/", $modificarPrecio["IdProductoSeleccionado"])) {

            $erroresActualizado[] = "<p>El IS sólo puede ser numérico</p>";

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
         