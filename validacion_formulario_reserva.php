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
        
        // Guardar la variable local con los datos del formulario en la sesión:
        $_SESSION["formulario"] = $reserva;

        // Validar el formulario:
        $errores = validarDatos($reserva);

    } else {

        Header("Location: reservas.php");	

    }

    // Si se encuentran errores se redirige a reservas.php, de lo contrario se pasa a confirmacion_reserva.php:
    if (count($errores) > 0) {

        $_SESSION["errores"] = $errores;
        Header("Location: reservas.php");

    } else {
		
        $conexion = abrirConexionBD();
        
		$idMesa = disponibilidadMesasYReservas($conexion, $reserva);
        guardarReserva($idMesa, $conexion, $reserva);
        
        cerrarConexionBD($conexion);
        
        Header("Location: confirmacion_reserva.php");

    }
           
    ////////////////////////////////////////////////////
    // Validación en servidor del formulario de reserva
    ////////////////////////////////////////////////////
    function validarDatos($reserva) {

        $errores = array();

        // Validacion del nombre:
        if ($reserva["nombre"] == "") {

            $errores[] = "<p>El nombre no puede estar vacío</p>";

        } else if (!preg_match("/^[a-zA-Zñáéíóú ]+$/", $reserva["nombre"])) {
            
            $errores[] = "<p>El nombre sólo puede contener carácteres alfabéticos</p>";

        }
        // Validación del apellido:
        if ($reserva["apellidos"] == "") {

            $errores[] = "<p>El apellido no puede estar vacío</p>";

        } else if (!preg_match("/^[a-zA-Zñáéíóú ]+$/", $reserva["apellidos"])) {
            
            $errores[] = "<p>Los apellidos sólo pueden contener carácteres alfabéticos</p>";

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
        $date = new DateTime($reserva["fecha"]);
        $now = new DateTime();

        if ($reserva["fecha"] == "") {

            $errores[] = "<p>La fecha no puede estar vacía</p>";

        } else if ($date < $now) {

            $errores[] = "<p>La fecha no puede ser anterior a hoy</p>";
        }

        return $errores;

    }

    // Función que comprueba si existe una mesa en la BD que satisface el estado de disponible y el nº de personas solicitado:
    function disponibilidadMesasYReservas($conexion, $reserva) {

        global $errores;
        $nPersonas = $reserva["numeroPersonas"];

        try {

            $consulta = "SELECT idMesa AS TOTAL FROM Mesas WHERE (disponible = 1 AND capacidad >= :nPersonas) AND ROWNUM = 1 ORDER BY capacidad";
            $stmt = $conexion -> prepare($consulta);
            $stmt -> bindParam(":nPersonas", $nPersonas);
            $stmt -> execute();
			
            $result = $stmt -> fetch();
			$total = $result['TOTAL'];
            return $total;

        } catch(PDOException $e) {
			
            $errores[] = "<p>Lo sentimos, no hay mesas disponibles para el nº de personas solicitado</p>";
            // echo "Error: " . $e -> GetMessage();
            return $errores;
        }

    }
    
    // Función que guarde la reserva (inserte en la BD) en la tabla de Reservas:
    function guardarReserva($idMesa, $conexion, $reserva) {

        global $errores;
        $fecha = date('d/m/Y', strtotime($reserva["fecha"]));
        
        try {

            $consulta = "CALL insertReservas(:fecha, :numeroPersonas, :mesa, null, :nombre, :apellidos, :telefono)";
            $stmt = $conexion -> prepare($consulta);

            $stmt -> bindParam(':fecha', $fecha);
            $stmt -> bindParam(':numeroPersonas', $reserva["numeroPersonas"]);
            $stmt -> bindParam(':mesa', $idMesa);
            $stmt -> bindParam(':nombre', $reserva["nombre"]);
            $stmt -> bindParam(':apellidos', $reserva["apellidos"]);
			$stmt -> bindParam(':telefono', $reserva["telefono"]);

            $stmt -> execute();

        } catch(PDOException $e) {

            $errores[] = "<p>Lo sentimos, se ha producido un fallo al guardar la reserva</p>";
            // echo "Error: " . $e -> GetMessage();
            return $errores;
        }

    }

?>
