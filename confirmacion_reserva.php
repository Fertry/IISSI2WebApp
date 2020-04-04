<?php

    session_start();

    // Comprobar que hemos llegado a esta página porque se ha rellenado y validado el formulario:
	if (!isset($_SESSION["formulario"])) {

        Header("Location: reservas.php");	

    } else {

        $formulario = $_SESSION["formulario"];

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
                        <?php

                            echo "<ul>";
                            echo "<li>Nombre: $formulario["nombre"]";
                            echo "<li>Apellidos: $formulario["apellidos"]";
                            echo "<li>Edad: $formulario["edad"]";
                            echo "<li>Teléfono: $formulario["telefono"]";
                            echo "</ul>";

                        ?>


                    </fieldset>

                    <fieldset>

                        <legend>Su reserva:</legend>
                        <?php

                            echo "<ul>";
                            echo "<li>Nº de personas: $formulario["numeroPersonas"]";
                            echo "<li>Fecha: $formulario["fecha"]";;
                            echo "</ul>";

                        ?>

                    </fieldset>


                </form>

            ?>

        </div>

        <a href = "desconexion.php"><button type = "button">Inicio</button></a>

    </main>

    <footer>

        <h4><i>Si debido a una eventualidad no puede hacer uso de su reserva, <br> contacte con el restaurante. Gracias.</i></h4>

        <?php 

            include_once("pie.php");

        ?>

    </footer>

</body>

</html>
