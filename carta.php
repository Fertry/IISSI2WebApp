<?php
    
    // Iniciamos la sesión:
    session_start();

    // Llamamos a gestionBD.php y a paginacion_consulta.php
    require_once("gestionBD.php");
    require_once("paginacion_consulta.php");

    if (isset($_SESSION["paginacion"])) {

        $paginacion = $_SESSION["paginacion"];

    }

    // La página por defecto será la primera a menos que se cambie y el tamaño por defecto será de 5:
    $pagina_seleccionada = isset($_GET["PAG_NUM"]) ? (int)$_GET["PAG_NUM"] : (isset($paginacion) ? (int)$paginacion["PAG_NUM"] : 1);
    $pag_tam = isset($_GET["PAG_TAM"]) ? (int)$_GET["PAG_TAM"] : (isset($paginacion) ? (int)$paginacion["PAG_TAM"] : 5);

    if ($pagina_seleccionada < 1) {

        $pagina_seleccionada = 1;

    }

    if ($pag_tam < 1) {

        $pag_tam = 5;

    }	

    unset($_SESSION["paginacion"]);

    // Abrimos la conexion con la BD:
    $conexion = abrirConexionBD();

    // Consulta: nombre y precio de todos los platos disponibles:
    $query = "SELECT nombre, precioProducto FROM Productos WHERE disponibilidad = 1";

    // Se comprueba que el tamaño de página, página seleccionada y total de registros son conformes.
    $total_registros = total_consulta($conexion, $query);
    $total_paginas = (int)($total_registros / $pag_tam);

    if ($total_registros % $pag_tam > 0) {

        $total_paginas++;

    }		

    if ($pagina_seleccionada > $total_paginas) {

        $pagina_seleccionada = $total_paginas;

    }		

    // Guardamos los valores generados:
    $paginacion["PAG_NUM"] = $pagina_seleccionada;
    $paginacion["PAG_TAM"] = $pag_tam;
    $_SESSION["paginacion"] = $paginacion;

    // Datos que se van a mostrar: 
    $filas = consulta_paginada($conexion, $query, $pagina_seleccionada, $pag_tam);

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

    <main>

        <nav>

            <div id="enlaces">

                <?php

                for($pagina = 1; $pagina <= $total_paginas; $pagina++)

                    if ($pagina == $pagina_seleccionada) { 	

                ?>

                        <span class="current"><?php echo $pagina; ?></span>

                <?php

                    } else {

                ?>

                        <a href="carta.php?PAG_NUM=<?php echo $pagina; ?>&PAG_TAM=<?php echo $pag_tam; ?>"><?php echo $pagina; ?></a>

                <?php
                
                    }

                ?>
                        
            </div>

            <form method = "get" action = "carta.php">

                <div>

                    <input id="PAG_NUM" name = "PAG_NUM" type = "hidden" value = "<?php echo $pagina_seleccionada?>"/>

                </div>

                <div>

                    Mostrando 
                    <input id = "PAG_TAM" name = "PAG_TAM" type="number" min = "1" max = "<?php echo $total_registros; ?>" value = "<?php echo $pag_tam?>" autofocus/>
                    entradas de <?php echo $total_registros?>

                    <input type = "submit" value = "Cambiar">

                </div>

            </form>

        </nav>
                
    <?php

        foreach($filas as $fila) {

    ?>

            <!-- Mostrar los datos solicitados -->
            <article>

                <ul>

                    <li><h4><?php echo $fila[1] ?> - <?php echo $fila[2] ?> €.</h4></li>
                    <?php //print_r($fila) ?>

                </ul>

            </article>

    <?php

        }

    ?>

    </main>

    <?php 

        include_once("pie.php");

    ?>

</body>

</html>
