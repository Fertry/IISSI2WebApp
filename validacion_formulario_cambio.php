<?php

    // Iniciamos la sesión:
    session_start();
    
    // Llamamos a gestionBD.php
    require_once("gestionBD.php");

	// Comprobar que hemos llegado a esta página porque se ha rellenado el formulario:
	if (isset($_SESSION["user"])) {

        $cambio["actualPass"] = $_REQUEST["actualPass"];
        $cambio["newPassword"] = $_REQUEST["newPassword"];
        $cambio["newPasswordConfirmation"] = $_REQUEST["newPasswordConfirmation"];

        // Guardar la variable local con los datos del formulario en la sesión:
        $_SESSION["user"] = $cambio;

        // Comprobar que los datos son válidos:
        $erroresCambio = validarDatosCambio($cambio);

    } else {

        Header("Location: desconexion.php");	

    }

    // Si se encuentran errores se redirige a area_personal_pass.php y se muestran:
    if (count($erroresCambio) > 0) {

        $_SESSION["erroresCambio"] = $erroresCambio;
        Header("Location: area_personal_pass.php");

    } else {
        
        // Abrir la conexión:
        $conexion = abrirConexionBD();
        
        // Obtener la contraseña actual de la BD:
        //$actualPass = obtenerPassword($conexion);

        // Obtener la nueva contraseña introducida por el usuario:
        $newPass = $cambio["newPassword"];

        // Cambiar la contraseña en la BD:
		cambiarPassword($conexion, $newPass);
        
        // Cerrar la conexión:
        cerrarConexionBD($conexion);
        
        Header("Location: area_personal_pass.php");

    }

    //////////////////////////////////////////////////////////////
    // Validación en servidor del formulario de cambio de password
    //////////////////////////////////////////////////////////////

    function validarDatosCambio($cambio) {

        $erroresCambio = array();

        // Validación de la contraseña:


        return $erroresCambio;

    }

    function obtenerPassword($conexion) {

        global $erroresCambio;

        try {

            // Consulta a la BD la contraseña del administrador:
            $consultaPass = "SELECT pass AS TOTAL FROM Usuarios WHERE (clase = 'GERENTE')";

            $stmt = $conexion -> prepare($consultaPass);
            $stmt -> execute();
            $result = $stmt -> fetch();
            $total = $result['TOTAL'];
            return $total;

        } catch(PDOException $e) {

            $erroresCambio[] = "<p>No se ha podido acceder a la base de datos</p>";
            // echo "Error: " . $e -> GetMessage();
            
            return $erroresCambio;

        }

    }

    function cambiarPassword($conexion, $newPass) {

        try {

            $consulta = "UPDATE Usuarios SET pass = $newPass WHERE clase = 'GERENTE'";

            $stmt = $conexion -> query($consulta);
 
            return "";

        } catch (PDOException $e) {

            // echo "Error: " . $e -> GetMessage();
            Header("Location: desconexion.php");


        }

    }

?>
