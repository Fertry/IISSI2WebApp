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
    if (isset($_SESSION["cambio"])) {

        $modificarPass["actualPass"] = $_REQUEST["actualPass"];
        $modificarPass["newPassword"] = $_REQUEST["newPassword"];

        // Guardar la variable local con los datos del formulario en la sesión:
        $_SESSION["modificarPass"] = $modificarPass;

    } else {

        Header("Location: area_personal_pass.php");

    }

    // Abrimos la conexion con la BD:
    $conexion = abrirConexionBD();

    // Obtener la contraseña actual:
    $passBD = comprobarPassword($conexion);
        
    // Validar el formulario:
    $erroresCambio = validarDatosCambio($modificarPass, $passBD);
        
    // Cerramos la conexión:
    cerrarConexionBD($conexion);

    // Si se encuentran errores se redirige a area_personal_pass.php, de lo contrario se pasa a modificar la contraseña:
    if (count($erroresCambio) > 0) {

        $_SESSION["erroresCambio"] = $erroresCambio;
        Header("Location: area_personal_pass.php");

    } else {

        // Abrimos la conexion con la BD:
        $conexion = abrirConexionBD();

        // Obtenemos la contraseña nueva:
        $passNueva = $modificarPass["newPassword"];

        // Consulta SQL que modifica la contraseña:
        cambiarPassword($passNueva, $conexion);

        // Cerramos la conexión:
        cerrarConexionBD($conexion);

        // Redirigimos a area_personal_pass.php de nuevo:
        Header("Location: area_personal_pass.php");

    }

    //////////////////////////////////////////////////////////////
    // Validación en servidor del formulario de cambio de password
    //////////////////////////////////////////////////////////////

    function validarDatosCambio($modificarPass, $passBD) {

        $erroresCambio = array();
        
        // Validación de la contraseña:
        if ($modificarPass["actualPass"] != $passBD) {

            $erroresCambio[] = "La contraseña actual no es válida";

        } else if (!preg_match("/^[a-zA-Z0-9]+$/", $modificarPass["newPassword"])) {

            $erroresCambio[] = "La nueva contraseña debe contener caracteres alfabéticos y numéricos exclusivamente";

        } else if ($modificarPass["newPassword"] == "") {

            $erroresCambio[] = "La nueva contraseña no puede estar vacía";

        }
    
        return $erroresCambio;

    }

    function comprobarPassword($conexion) {

        global $erroresCambio;

        try {

            // Consulta a la BD la contraseña del administrador:
            $consulta = "SELECT pass AS TOTAL FROM Usuarios WHERE (clase = 'GERENTE')";

            $stmt = $conexion -> prepare($consulta);
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

    function cambiarPassword($passNueva, $conexion) {

        global $erroresCambio;

        try {

            $consulta = "UPDATE Usuarios SET pass = :passNueva WHERE clase = 'GERENTE'";

            $stmt = $conexion -> prepare($consulta);
            $stmt -> bindParam(":passNueva", $passNueva);
            $stmt -> execute();

            return "";

        } catch (PDOException $e) {

            $erroresCambio[] = "<p>No se ha podido modificar la contraseña</p>";
            // echo "Error: " . $e -> GetMessage();
            
            return $erroresCambio;

        }

    }

?>
