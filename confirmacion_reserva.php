<?php

    session_start();

    // Comprobar que hemos llegado a esta página porque se ha rellenado y validado el formulario:
	if (!isset($_SESSION["formulario"])) {

        Header("Location: reservas.php");	

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
	<meta name="description" content="Confirmación de la reserva">
	<meta name="keywords" content="HTML, Casa Salvi, IISSI, confirmacion, reserva">

	<title>Reserva confirmada</title>
    
</head>

<body>

    <?php 

    include_once("header_reservas.php");

    ?>

    <?php 

    include_once("navegacion.php");

    ?>

    <main>

        <h2> Su reserva ha sido confirmada </h2>

        <!-- Detalles de la reserva -->

        <a href = "desconexion.php"><button type = "button">Volver</button></a>

    </main>

    <footer>

        <h4><i>Si debido a una eventualidad no puede hacer uso de su reserva, <br> contacte con el restaurante. Gracias.</i></h4>

    </footer>

</body>

</html>
