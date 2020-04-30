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
        // $insertarProducto['tipoProducto'] = "";

        $_SESSION["insertarProducto"] = $insertarProducto;

    } else {

        $insertarProducto = $_SESSION["insertarProducto"];

    }

    // Si se encuentran errores en la validación, se recogen para mostrarlos:
    if (isset($_SESSION["erroresInsertado"])) {
        
        $erroresInsertado = $_SESSION["erroresInsertado"];
        unset($_SESSION["erroresInsertado"]);
        
    }

    if (!isset($_SESSION["actualizarProducto"])) {

        $actualizarProducto['IdProductoSeleccionado'] = "";
        $actualizarProducto['nuevoPrecioProducto'] = "";

        $_SESSION["actualizarProducto"] = $actualizarProducto;

    } else {

        $actualizarProducto = $_SESSION["actualizarProducto"];

    }

    // Si se encuentran errores en la validación, se recogen para mostrarlos:
    if (isset($_SESSION["erroresActualizado"])) {
        
        $erroresActualizado = $_SESSION["erroresActualizado"];
        unset($_SESSION["erroresActualizado"]);
    
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

            <h2> Gestión de Productos </h2>

            <h4> 

            <?php
                    
                // Debug:
                // echo $_SESSION["insertarProducto"]["nombreProducto"];
                // echo $_SESSION["insertarProducto"]["precioProducto"];
                // echo $_SESSION["insertarProducto"]["tipoProducto"];

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

                if (isset($erroresActualizado) && count($erroresActualizado) > 0) {

                    echo "<div class=\"error\">";
                    echo "<h4> Errores en el formulario: </h4>";
                    foreach ($erroresActualizado as $errorA)
                        echo $errorA;
                    echo "</div>";

                } 

            ?>

            <div class = "formulario">

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

                        <!--
                        <div>
                            <label for = "tipoProducto"> Tipo: </label>
                            <select id = "tipoProducto" name = "tipoProducto" required>
                                <option value = "PRIMERPLATO"> Primer plato </option>
                                <option value = "SEGUNDOPLATO"> Segundo plato </option>
                                <option value = "POSTRE"> Postre </option>
                                <option value = "BEBIDA"> Bebida </option>
                            </select> 
                        </div>
                        -->

                        <div>
                            <input type = "submit" value = "Insertar"/>
                        </div>

                    </fieldset>

                </form>

            </div>

            <?php
                    
                // Debug:
                // echo $_SESSION["actualizadoProducto"]["IdProductoSeleccionado"];
                // echo $_SESSION["actualizadoProducto"]["nuevoPrecioProducto"];

            ?>

            <div class = "formulario">

                <form id = "actualizarProducto" method = "post" action = "gestion_producto_actualizar.php"> 

                    <fieldset>
                        <legend>Actualizado de precios:</legend>

                        <div> 
                            <label for = "IdProductoSeleccionado"> Id: </label>
                            <input id = "IdProductoSeleccionado" name = "IdProductoSeleccionado" type="number" min = 1 placeholder = "Id del producto" size = "30" required/>
                        </div>

                        <div>
                            <label for = "nuevoPrecioProducto"> Precio: </label>
                            <input id = "nuevoPrecioProducto" name = "nuevoPrecioProducto" type="number" min = 1 placeholder = "Nuevo precio" size = "20" required/>
                        </div>

                        <div>
                            <input type = "submit" value = "Actualizar"/>
                        </div>

                    </fieldset>

                </form>

            </div>

        </main>

        <br>

        <a href = "desconexion.php"><button type = "button">Desconexión</button></a>

        <br>

        <?php 

           // include_once("pie.php");

        ?>

</body>

</html>
