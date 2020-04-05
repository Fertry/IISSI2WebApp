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

    function total_consulta($conexion, $query) {

        try {

            $total_consulta = "SELECT COUNT(*) AS TOTAL FROM ($query)";
            $stmt = $conexion -> query($total_consulta);
            $result = $stmt -> fetch();
            $total = $result['TOTAL'];

            return  (int)$total;

        } catch (PDOException $e) {

            header("Location: index.php");
            // echo "Error: " . $e -> GetMessage();

        }

    } 

?>
