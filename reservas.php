<?php

    // Iniciamos la sesión:
    session_start();

    // Comprobamos que no existen datos en la sesión: por tanto se crea una entrada con valores por defecto (vacíos):
    if (!isset($_SESSION["formulario"])) {

        $formulario["nombre"] = "";
        $formulario["apellidos"] = "";
        $formulario["edad"] = "";
        $formulario["telefono"] = "";
        $formulario["numeroPersonas"] = "";
        $formulario["fecha"] = "";

        $_SESSION["formulario"] = $formulario;

    } else {

        // Si ya existen valores en la sesión se usan para inicializar el formulario:
        $formulario = $_SESSION["formulario"];

    }

    // Si se encuentran errores en la validación, se recogen para mostrarlos:
    if (isset($_SESSION["errores"])) {
        
        $errores = $_SESSION["errores"];
        // unset($_SESSION["errores"]);

    }

?>
    
<!DOCTYPE html>

<html lang="es">

<head>

    <!-- Cabecera del formulario -->
	<meta charset="UTF-8">
	<meta name="author" content="Casa Salvi">
    <link rel="icon" href="images/icono.png" type="image/png">
    <link rel="stylesheet" type="text/css" href="css/restaurante.css"/>
	<meta name="classification" content="Restaurante">
	<meta name="description" content="Formulario de reserva para restaurante">
	<meta name="keywords" content="HTML, Casa Salvi, IISSI, forms, reserva">

    <!-- Scripts JS para la validación en cliente -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js" type="text/javascript"></script>
    <script src="js/validacion_reserva.js" type="text/javascript"></script>
	<title>Formulario de Reserva</title>
    
</head>

<body>

    <script>
    // Validación de datos en cliente mediante JS:

    </script>

    <?php 

        include_once("header_reservas.php");

    ?>

    <?php 

       include_once("navegacion.php");

    ?>
    <br>

    <?php

        if (isset($errores) && count($errores) > 0) {

            echo "<div class=\"error\">";
			echo "<h4> Errores en el formulario: </h4>";
			foreach ($errores as $error)
				echo $error;
			echo "</div>";

        } 

    ?>

    <div class = "formulario">

        <main>

            <form id = "formulario", method="post" action="validacion_formulario_reserva.php">
                
                <p><i>Todos los campos son obligatorios</i></p>

                <fieldset>
                    <legend>
                        Detalles de Contacto
                    </legend>
                    
                    <div>
                        <label for = "nombre">Nombre: </label>
                        <input id = "nombre" name = "nombre" type = "text" placeholder = "" size = "30" required autofocus/>
                    </div>

                    <div>
                        <label for = "apellidos">Apellidos: </label>
                        <input id = "apellidos" name = "apellidos" type = "text" placeholder = "" size = "50" required/>
                    </div>

                    <div>
                        <label for = "edad">Edad: </label>
                        <input id = "edad" name = "edad" type = "number" placeholder = "" size = "10" required/>
                    </div>

                    <div>
                        <label for = "telefono">Teléfono: </label>
                        <input id = "telefono" name = "telefono" type = "tel" placeholder = "123456789"  size = "20" required/>
                    </div>

                </fieldset>
                <br>

                <fieldset>
                    <legend>
                        Detalles de la Reserva
                    </legend>

                    <div>
                        <label for = "numeroPersonas">Nº de Personas: </label>
                        <input id = "numeroPersonas" name = "numeroPersonas" type = "number" placeholder = "10 máximo" size = "15" required/>
                    </div>

                    <div>
                        <label for = "fecha">Fecha de reserva: </label>
                        <input id = "fecha" name = "fecha" type = "date" required/>
                    </div>

                </fieldset>

                <div> 
                    <input type = "submit" value = "Reservar"/>
                </div>
            
            </form>

        </main>

    </div>

</body>

</html>
