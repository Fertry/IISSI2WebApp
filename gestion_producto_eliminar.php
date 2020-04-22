<?php

    // Llamamos a gestionBD.php
    require_once("gestionBD.php");

    // Comprobar que hemos llegado a esta página porque se ha iniciado la sesión:
	if (!isset($_SESSION["user"])) {

        Header("Location: desconexion.php");	

    } else {

        $gestionProductosEliminar["eliminarProducto"] = $_REQUEST["eliminarProducto"];

    }

    $_SESSION["user"] = $gestionProductosEliminar;

    // Abrimos la conexion con la BD:
    $conexion = abrirConexionBD();
    
    // Obtenemos el nº del producto que se quiere eliminar:
    $producto = $gestionProductosEliminar["eliminarProducto"];

    // Consulta SQL que elimina el producto de la BD:
    eliminarProducto($conexion, $producto);

    // Cerramos la conexión:
    cerrarConexionBD($conexion);

    // Redirigimos a area_personal_productos.php de nuevo:
    Header("Location: area_personal_productos.php");

    function eliminarProducto($conexion, $producto) {

        try {

            $consulta = "DELETE Productos WHERE idProducto = $producto";

            $stmt = $conexion -> query($consulta);

            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: area_personal.php");

        }


    }

?>
