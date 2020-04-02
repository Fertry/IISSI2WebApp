<!DOCTYPE html>

<html lang="es">

<head>

    <!-- Cabecera de la página -->
	<meta charset="UTF-8">
	<meta name="author" content="Casa Salvi">
    <link rel="icon" href="images/icono.png" type="image/png">
    <link rel="stylesheet" type="text/css" href="css/restaurante.css"/>
	<meta name="classification" content="Restaurante">
	<meta name="description" content="Ubicacion del restaurante">
	<meta name="keywords" content="HTML, Casa Salvi, IISSI, ubicacion">

	<title>Ubicación</title>
    
</head>

<body>

    <?php

        include_once("header_ubicacion.php");

    ?>

    <?php 

        include_once("navegacion.php");

    ?>

    <main>

        <div class = "texto">
            
            <h3>Dirección: C/ Miguel de Cervantes 46, 41860, Gerena (Sevilla)</h3>
            <h3>Teléfono de Contacto: 955783272</h3>

        </div>

        <div class = "map">
            
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d812.0924701914437!2d-6.156097738319029!3d37.52820095596046!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd123c2905facaf7%3A0xa94e373ed5ede645!2sCasa%20Salvi%20Restaurante!5e1!3m2!1ses!2ses!4v1585842308320!5m2!1ses!2ses" width="400" height="300" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>            

        </div>

    </main>

</body>

</html>