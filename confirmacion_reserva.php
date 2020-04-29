<?php

    // Iniciamos la sesión:
    session_start();

    // Llamamos a gestionBD.php
    require_once("gestionBD.php");

    // Comprobar que hemos llegado a esta página porque se ha rellenado el formulario y se ha validado:
	if (isset($_SESSION["formulario"])) {

        // Los datos que mostraremos en esta página:
        $nuevaReserva = $_SESSION["formulario"];
        
        // Vaciamos la sesión:
		$_SESSION["formulario"] = null;
        $_SESSION["errores"] = null;
        
	} else  {

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
    <br>

    <main>

        <h2> Su reserva ha sido confirmada </h2>

        <!-- Detalles de la reserva -->
        <div class = "detalles">

                <form>

                    <fieldset>

                        <legend>Sus datos:</legend>

                            <ul>

                                <li>Nombre: <?php echo $nuevaReserva["nombre"] ?></li>
                                <li>Apellidos: <?php echo $nuevaReserva["apellidos"] ?></li>
                                <li>Edad: <?php echo $nuevaReserva["edad"] ?></li>
                                <li>Teléfono: <?php echo $nuevaReserva["telefono"] ?></li>

                            </ul>

                    </fieldset>

                    <fieldset>

                        <legend>Su reserva:</legend>

                            <ul>

                                <li>Nº de personas: <?php echo $nuevaReserva["numeroPersonas"] ?></li>
                                <li>Fecha: <?php echo $nuevaReserva["fecha"] ?></li>

                            </ul>

                    </fieldset>


                </form>

                <i>Recuerde que si por una eventualidad no puede hacer uso de su reserva, contacte con el restaurante para su cancelación en <a href="tel:955783272">955783272</a></i>

        </div>

        <a href = "desconexion.php"><button type = "button">Inicio</button></a>

    </main>

    <br>

    <footer>

        <?php 

            include_once("pie.php");

        ?>

    </footer>

</body>

</html>
