<?php

    if (session_status() == PHP_SESSION_NONE) {

        session_start();

    }

function abrirConexionBD() {

    $host = "oci:dbname=localhost/XE;charset=UTF8";
    $usuario = "IISSI";
    $password = "8080";

    try{

		/* Las sucesivas conexiones se pueden volver a usar */	
        $conexion = new PDO($host,$usuario,$password,array(PDO::ATTR_PERSISTENT => true));
        
	    /* Se disparan excepciones cuando ocurrae un error */
        $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
        return $conexion;
        
	} catch(PDOException $error) {

        // $_SESSION["erroresBD"] = $error -> GetMessage();
        header("Location: index.php");

	}

}

function cerrarConexionBD($conexion) {

    $conexion = null;

}

?>
