<?php

    // Llamamos a gestionBD.php
    require_once("gestionBD.php");

    // Comprobar que hemos llegado a esta página porque se ha iniciado la sesión:
	if (!isset($_SESSION["user"])) {

        Header("Location: desconexion.php");	

    } else {

        $gestionProductos["actualizar"] = $_REQUEST["actualizar"];

    }

    $_SESSION["user"] = $gestionProductos;

    // Abrimos la conexion con la BD:
    $conexion = abrirConexionBD();
    
    // Obtenemos el nº del producto que se quiere actualizar:
    $actualizar = $gestionProductos["actualizar"];

    // Consulta SQL que elimina el producto de la BD:
    eliminarProducto($conexion, $actualizar);

    // Cerramos la conexión:
    cerrarConexionBD($conexion);

    // Redirigimos a area_personal_productos.php de nuevo:
    Header("Location: area_personal_productos.php");

    function actualizarProducto($conexion, $eliminar) {

        try {

            //$consulta = "DELETE Reservas WHERE mesa = $table";

            //$stmt = $conexion -> query($consulta);

            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: area_personal.php");

        }

    }

?>
