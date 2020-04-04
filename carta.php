<?php

    session_start();

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
	<meta name="description" content="Carta del restaurante">
	<meta name="keywords" content="HTML, Casa Salvi, IISSI, carta">

	<title>Nuestra carta</title>
    
</head>

<body>

    <?php 

    include_once("header_carta.php");

    ?>

    <?php 

    include_once("navegacion.php");

    ?>
    <br>

    <!-- Paginación -->
    <!-- Carta del restaurante -->
    <div class = "paginacion">

        <a href="#">&laquo;</a>
        <a href="#">1</a>
        <a class="activo" href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">5</a>
        <a href="#">6</a>
        <a href="#">&raquo;</a>

    </div> 

    <?php 

        include_once("pie.php");

    ?>

</body>

</html>
