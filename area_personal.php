<?php

    session_start();

    // Comprobar que hemos llegado a esta página porque se ha rellenado y validado el formulario:
	if (!isset($_SESSION["user"])) {

        Header("Location: personal.php");	

    } 

?>

<!DOCTYPE html>

<html lang="es">

<head>

    <!-- Cabecera -->
	<meta charset="UTF-8">
	<meta name="author" content="Casa Salvi">
    <link rel="icon" href="images/icono.png" type="image/png">
    <link rel="stylesheet" type="text/css" href="css/restaurante.css"/>
	<meta name="classification" content="Restaurante">
	<meta name="description" content="Gestión del restaurante">
	<meta name="keywords" content="HTML, Casa Salvi, IISSI, gestión, personal">

	<title>Gestión Casa Salvi</title>
    
</head>

<body>

    <?php 

    include_once("header_personal.php");

    ?>

    <?php 

    include_once("navegacion.php");

    ?>
    <br>

    <main>

        <h3> Restaurante Casa Salvi - Gerencia </h3>

        <!-- Detalles de facturación y últimas reservas -->
        <?php
            
            // Abrir la conexión:

            // Consulta BD:

            // Mostrar los datos:

            // Cerrar la conexión:

        ?>

        <a href = "desconexion.php"><button type = "button">Desconexión</button></a>

    </main>

    <?php 

        include_once("pie.php");

    ?>

</body>

</html>
