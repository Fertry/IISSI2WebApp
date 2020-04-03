<?php

	session_start();
    
    if (isset($_SESSION["user"])){

        unset($_SESSION["user"]);

    }

    if (isset($_SESSION["formulario"])){

        unset($_SESSION["formulario"]);

    }
    
    session_destroy();
    header("Location: index.php");

?>
