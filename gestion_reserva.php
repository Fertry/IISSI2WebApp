<?php

    // Llamamos a gestionBD.php
    require_once("gestionBD.php");

    // Comprobar que hemos llegado a esta página porque se ha rellenado el formulario y se ha validado:
	if (!isset($_SESSION["user"])) {

        Header("Location: desconexion.php");	

    } else {

        $gestion["eliminar"] = $_REQUEST["eliminar"];

    }

    $_SESSION["user"] = $gestion;

    // Abrimos la conexion con la BD:
    $conexion = abrirConexionBD();
    
    // Obtenemos el nº de la mesa que se recibe a través del formulario:
    $table = $gestion["eliminar"];

    // Consulta SQL que elimina la reserva en función de la mesa:
    eliminarReserva($conexion, $table);

    // Consulta SQL que libera el estado de la mesa:
    liberarMesa($conexion, $table);
    
    // Cerramos la conexión:
    cerrarConexionBD($conexion);

    // Redirigimos a area_personal.php de nuevo:
    Header("Location: area_personal.php");

    function eliminarReserva($conexion, $table) {

        try {

            $consulta = "DELETE Reservas WHERE mesa = $table";

            $stmt = $conexion -> query($consulta);

            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: area_personal.php");

        }

    }

    function liberarMesa($conexion, $table) {

        try {

            $consulta = "UPDATE Mesas SET disponible = 1 WHERE idMesa = $table";

            $stmt = $conexion -> query($consulta);
 
            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: area_personal.php");

        }

    }

?>
