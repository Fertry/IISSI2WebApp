<?php

    // Iniciamos la sesión:
    session_start();
    
    // Llamamos a gestionBD.php
    require_once("gestionBD.php");
    
	// Comprobar que hemos llegado a esta página porque se ha rellenado el formulario:
	if (isset($_SESSION["formulario"])) {

        $admin["usuario"] = $_REQUEST["usuario"];
        $admin["password"] = $_REQUEST["password"];

        $_SESSION["formulario"] = $admin;

    } else {

        Header("Location: personal.php");	

    }
		
?>

<?php

cerrarConexionBD($conexion);

?>
