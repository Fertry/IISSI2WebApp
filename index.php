<!DOCTYPE html>

<html lang="es">

<head>

    <!-- Cabecera -->
	<meta charset="UTF-8">
	<meta name="author" content="Casa Salvi">
    <link rel="icon" href="images/icono.png" type="image/png">
    <link rel="stylesheet" type="text/css" href="css/restaurante.css"/>
	<meta name="classification" content="Restaurante">
	<meta name="description" content="Página principal del restaurante">
	<meta name="keywords" content="HTML, Casa Salvi, IISSI, inicio, index">

	<title>Restaurante Casa Salvi</title>
    
</head>

<body>

    <?php 

        include_once("header_index.php");

    ?>

    <?php 

       include_once("navegacion.php");

    ?>

    <main>

    <div class = "texto">

        <p>Situado a las faldas de la Sierra Norte, en Gerena (Sevilla), Restaurante Casa Salvi 
        cuenta con amplios espacios y el mejor personal para todo tipo de celebraciones, desde enlaces
        matrimoniales a cenas de empresas. Más de 20 años de experiencia nos avalan.</p>

    </div>

    <div class = "informacion">

        <script type="text/javascript"> 

            var f=new Date(); var ano = f.getFullYear(); var mes = f.getMonth(); var dia = f.getDate(); var estiloDia; var meses = new Array ("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"); var diasSemana = new Array("Domingo","Lunes","Martes","Miércoles","Jueves","Viernes","Sábado"); var diasMes = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); var diaMaximo = diasMes[mes]; if (mes == 1 && (((ano % 4 == 0) && (ano % 100 != 0)) || (ano % 400 == 0))) diaMaximo = 29; 
            document.write('<div class="mifecha2">'); document.write('<div class="mesano">' + meses[mes] + ' de  ' + ano + '</div>'); for (i=1; i<=diaMaximo; i++){if(i == dia) estiloDia = "diaactual"; else estiloDia = "dia"; document.write('<div class="' + estiloDia + '">' + i + '</div>');} document.write('</div>'); 

        </script>

        <h4> Teléfono del restaurante: 955783272 </h4>

    </div>

    <?php 

        include_once("pie.php");

    ?>

</body>

</html>
