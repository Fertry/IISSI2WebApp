<?php

    // Iniciamos la sesión:
    session_start();

    // Comprobar que hemos llegado a esta página porque se ha iniciado la sesión:
    if (!isset($_SESSION["user"])) {

        Header("Location: desconexion.php");	
    
    }

    if (!isset($_SESSION["insertarProducto"])) {
	
        $insertarProducto['nombreProducto'] = "";
        $insertarProducto['precioProducto'] = "";

        $_SESSION["insertarProducto"] = $insertarProducto;

    } else {

        $insertarProducto = $_SESSION["insertarProducto"];

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

    <?php 

        include_once("navegacion_personal.php");

    ?>

        <main>

            <h2> Añadido de Productos </h2>

            <h4> 

                <?php

                    //echo $_SESSION["insertarProducto"]["nombreProducto"];
                    //echo $_SESSION["insertarProducto"]["precioProducto"];

                ?>

            </h4>

            <?php

                if (isset($erroresInsertado) && count($erroresInsertado) > 0) {

                    echo "<div class=\"error\">";
                    echo "<h4> Errores en el formulario: </h4>";
                    foreach ($erroresInsertado as $error)
                        echo $error;
                    echo "</div>";

                } 

            ?>

            <div class = entrada>

                <form id = "insertarProducto" method = "post" action = "gestion_productos_insertar.php"> 

                    <fieldset>
                        <legend>Insertado de productos:</legend>

                        <div> 
                            <label for = "nombreProducto"> Nombre: </label>
                            <input id = "nombreProducto" name = "nombreProducto" type="text" placeholder = "Nombre del producto" size = "40" required/>
                        </div>

                        <div>
                            <label for = "precioProducto"> Precio: </label>
                            <input id = "precioProducto" name = "precioProducto" type="number" min = 1 placeholder = "Precio" size = "20" required/>
                        </div>

                        <div>
                            <input type = "submit" value = "Insertar"/>
                        </div>

                    </fieldset>

                </form>

            </div>

        </main>

        <a href = "desconexion.php"><button type = "button">Desconexión</button></a>

    <?php 

        include_once("pie.php");

    ?>

</body>

</html>




