<?php

	session_start();
    
    if (isset($_SESSION["user"])){

        unset($_SESSION["user"]);

    }

    if (isset($_SESSION["formulario"])){

        unset($_SESSION["formulario"]);

    }

    if (isset($_SESSION["insertar"])){

        unset($_SESSION["insertar"]);

    }

    if (isset($_SESSION["paginacion"])){

        unset($_SESSION["paginacion"]);

    }
    
    session_destroy();
    header("Location: index.php");

?>
