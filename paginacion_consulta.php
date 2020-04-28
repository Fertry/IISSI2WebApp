<?php

    function consulta_paginada($conexion, $query, $pag_num, $pag_size) {

        try {

            $first = ($pag_num - 1) * $pag_size + 1;
            $last  = $pag_num * $pag_size;
			$paged_query = "SELECT * FROM(SELECT ROWNUM RNUM, AUX.* FROM(SELECT nombre, precioProducto FROM Productos) AUX WHERE ROWNUM <= :last) WHERE RNUM >= :first";
            $stmt = $conexion -> prepare($paged_query);
			$stmt -> bindParam(':first', $first);
			$stmt -> bindParam(':last', $last);
            $stmt -> execute();
            
            return $stmt;

        } catch (PDOException $e) {

            header("Location: index.php");
            // echo "Error: " . $e -> GetMessage();

        }

    } 

    function consulta_reservas($conexion, $query, $pag_num, $pag_size) {

        try {

            $first = ($pag_num - 1) * $pag_size + 1;
            $last  = $pag_num * $pag_size;
			$paged_query = "SELECT * FROM(SELECT ROWNUM RNUM, AUX.* FROM(SELECT nombre, telefono, fecha, mesa FROM Reservas) AUX WHERE ROWNUM <= :last) WHERE RNUM >= :first";
            $stmt = $conexion -> prepare($paged_query);
			$stmt -> bindParam(':first', $first);
			$stmt -> bindParam(':last', $last);
            $stmt -> execute();
            
            return $stmt;

        } catch (PDOException $e) {

            header("Location: index.php");
            // echo "Error: " . $e -> GetMessage();

        }

    } 

    function total_consulta($conexion, $query) {

        try {

            $total_consulta = "SELECT COUNT(*) AS TOTAL FROM ($query)";
            $stmt = $conexion -> query($total_consulta);
            $result = $stmt -> fetch();
            $total = $result['TOTAL'];

            return $total;

        } catch (PDOException $e) {

            header("Location: index.php");
            // echo "Error: " . $e -> GetMessage();

        }

    } 

    function consulta_productos($conexion, $query, $pag_num, $pag_size) {

        try {

            $first = ($pag_num - 1) * $pag_size + 1;
            $last  = $pag_num * $pag_size;
			$paged_query = "SELECT * FROM(SELECT ROWNUM RNUM, AUX.* FROM(SELECT idProducto, nombre, tipoProducto, precioProducto FROM Productos) AUX WHERE ROWNUM <= :last) WHERE RNUM >= :first";
            $stmt = $conexion -> prepare($paged_query);
			$stmt -> bindParam(':first', $first);
			$stmt -> bindParam(':last', $last);
            $stmt -> execute();
            
            return $stmt;

        } catch (PDOException $e) {

            header("Location: index.php");
            // echo "Error: " . $e -> GetMessage();

        }

    } 

    function consulta_menu_primero($conexion) {

        try {

            $consulta = "SELECT nombre AS PRIMERO FROM ProductoMenu WHERE tipoPlato = 'PRIMERPLATO'";

            $stmt = $conexion -> query($consulta);
            $result = $stmt -> fetch();
            $total = $result['PRIMERO'];
            
            return $total;

        } catch (PDOException $e) {

            header("Location: index.php");
            // echo "Error: " . $e -> GetMessage();

        }

    }

    function consulta_menu_segundo($conexion) {

        try {

            $consulta = "SELECT nombre AS SEGUNDO FROM ProductoMenu WHERE tipoPlato = 'SEGUNDOPLATO'";

            $stmt = $conexion -> query($consulta);
            $result = $stmt -> fetch();
            $total = $result['SEGUNDO'];
            
            return $total;

        } catch (PDOException $e) {

            header("Location: index.php");
            // echo "Error: " . $e -> GetMessage();

        }

    }

    function consulta_menu_postre($conexion) {

        try {

            $consulta = "SELECT nombre AS POSTRE FROM ProductoMenu WHERE tipoPlato = 'POSTRE'";

            $stmt = $conexion -> query($consulta);
            $result = $stmt -> fetch();
            $total = $result['POSTRE'];

            return $total;

        } catch (PDOException $e) {

            header("Location: index.php");
            // echo "Error: " . $e -> GetMessage();

        }

    }

    function consulta_menu_bebida($conexion) {

        try {

            $consulta = "SELECT nombre AS BEBIDA FROM ProductoMenu WHERE tipoPlato = 'BEBIDA'";

            $stmt = $conexion -> query($consulta);
            $result = $stmt -> fetch();
            $total = $result['BEBIDA'];
            
            return $total;

        } catch (PDOException $e) {

            header("Location: index.php");
            // echo "Error: " . $e -> GetMessage();

        }

    }

    function consulta_precio($conexion) {

        try {

            $consulta = "SELECT SUM(precio) AS PRECIO FROM ProductoMenu";

            $stmt = $conexion -> query($consulta);
            $result = $stmt -> fetch();
            $total = $result['PRECIO'];

            return $total;

        } catch (PDOException $e) {

            header("Location: index.php");
            // echo "Error: " . $e -> GetMessage();

        }

    }

?>
