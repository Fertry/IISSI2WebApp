<?php

    // Iniciamos la sesión:
    session_start();

    // Llamamos a gestionBD.php y a paginacion_consulta.php:
    require_once("gestionBD.php");
    require_once("paginacion_consulta.php");

    // Comprobar que hemos llegado a esta página porque se ha iniciado la sesión:
	if (!isset($_SESSION["user"])) {

        Header("Location: desconexion.php");	

    }

    if (!isset($_SESSION["modificarMenu"])) {
	
        $modificarMenu['nombrePrimero'] = "";
        $modificarMenu['precioPrimero'] = "";
        $modificarMenu['nombreSegundo'] = "";
        $modificarMenu['precioSegundo'] = "";
        $modificarMenu['nombrePostre'] = "";
        $modificarMenu['precioPostre'] = "";
        $modificarMenu['nombreBebida'] = "";
        $modificarMenu['precioBebida'] = "";

        $_SESSION["modificarMenu"] = $modificarMenu;

    } else {

        $modificarMenu = $_SESSION["modificarMenu"];

    }

    // Si se encuentran errores en la validación, se recogen para mostrarlos:
    if (isset($_SESSION["erroresMenu"])) {
        
        $erroresMenu = $_SESSION["erroresMenu"];
        unset($_SESSION["erroresMenu"]);
        
    }

    // Abrimos la conexion con la BD:
    $conexion = abrirConexionBD();

    // Productos del menú:
    $primerPlato = consulta_menu_primero($conexion);
    $segundoPlato = consulta_menu_segundo($conexion);
    $postre = consulta_menu_postre($conexion);
    $bebida = consulta_menu_bebida($conexion);
    
    // Precio del menú:
    $precio = consulta_precio($conexion);
    
    // Cerramos la conexión:
    cerrarConexionBD($conexion);

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

        <h2> Gestión de Menú </h2>

        <h4> 

        <?php
                    
            // Debug:

        ?>

        </h4>

        <?php

            if (isset($erroresMenu) && count($erroresMenu) > 0) {

                echo "<div class=\"error\">";
                echo "<h4> Errores en el formulario: </h4>";
                foreach ($erroresMenu as $errorMenu)
                    echo $errorMenu;
                echo "</div>";

            } 
        
        ?>

            <!-- Mostrar el menú del día -->

    <div class = "entrada">

            <table id = "tabla_menu">

                <tr>
                    <th>1º plato:</th>
                    <td><?php echo $primerPlato; ?></td>
                </tr>

                <tr>
                    <th>2º plato:</th>
                    <td><?php echo $segundoPlato; ?></td>
                </tr>

                <tr>
                    <th>Postre:</th>
                    <td><?php echo $postre; ?></td>
                </tr>

                <tr>
                    <th>Bebida:</th>
                    <td><?php echo $bebida; ?></td>
                </tr>

                <tr>
                    <th>Precio:</th>
                    <td><?php echo $precio; ?> €</td>
                </tr>

            <table>

    </div>
    
    <br>

        <!-- Formulario de actualización del menú -->

    <div class = "entrada"> 

        <form id = "modificarMenu" method = "post" action = "modificacion_menu.php">

            <fieldset>

                <legend>Cambio de menú</legend>

                <div> 
                    <label for = "nombrePrimero"> Nombre  del 1º plato: </label>
                    <input id = "nombrePrimero" name = "nombrePrimero" type="text" placeholder = "Nombre primer plato" size = "30" required/>
                    <label for = "precioPrimero"> Precio 1º plato: </label>
                    <input id = "precioPrimero"  name = "precioPrimero" type = "number" min = 1 size = "10" requied>
                </div>

                <div> 
                    <label for = "nombreSegundo"> Nombre del 2º plato: </label>
                    <input id = "nombreSegundo" name = "nombreSegundo" type="text" placeholder = "Nombre segundo plato" size = "30" required/>
                    <label for = "precioSegundo"> Precio 2º plato: </label>
                    <input id = "precioSegundo"  name = "precioSegundo" type = "number" min = 1 size = "10" requied>
                </div>

                <div> 
                    <label for = "nombrePostre"> Nombre del postre: </label>
                    <input id = "nombrePostre" name = "nombrePostre" type="text" placeholder = "Nombre del postre" size = "30" required/>
                    <label for = "precioPostre"> Precio del postre: </label>
                    <input id = "precioPostre"  name = "precioPostre" type = "number" min = 1 size = "10" requied>
                </div>

                <div> 
                    <label for = "nombreBebida"> Nombre de la bebida: </label>
                    <input id = "nombreBebida" name = "nombreBebida" type="text" placeholder = "Nombre de la bebida" size = "30" required/>
                    <label for = "precioBebida"> Precio de la bebida: </label>
                    <input id = "precioBebida"  name = "precioBebida" type = "number" min = 1 size = "10" requied>
                </div>

                <div>
                    <input type = "submit" value = "Modificar"/>
                </div>

            </fieldset>

        </form>

    </div>

    </main>

    <br>

    <a href = "desconexion.php"><button type = "button">Desconexión</button></a>

    <?php 

        include_once("pie.php");

    ?>

</body>

</html>
    