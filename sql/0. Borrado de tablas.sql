-------- RESTAURANTE CASA SALVI --------
/*

 El borrado contiene referencias a funciones, cursores, etc. propias de
 IISSI 1 pero que no se usan en IISSI 2. 

*/

-------- BORRADO DE TABLAS -------- 
DROP TABLE Reservas;
DROP TABLE Mesas; 
DROP TABLE Comandas; 
DROP TABLE Usuarios;
DROP TABLE Contiene;
DROP TABLE Alergenos;
DROP TABLE ProductoMenu;
DROP TABLE Menus; 
DROP TABLE ProductoCarta;
DROP TABLE Productos; 
DROP TABLE Cartas; 

-------- BORRADO DE SECUENCIAS --------
DROP SEQUENCE sec_cartas; 
DROP SEQUENCE sec_productos;
DROP SEQUENCE sec_producto_carta;
DROP SEQUENCE sec_menus;
DROP SEQUENCE sec_producto_menu;
DROP SEQUENCE sec_alergenos;
DROP SEQUENCE sec_contiene;
DROP SEQUENCE sec_usuarios;
DROP SEQUENCE sec_comandas;
DROP SEQUENCE sec_mesas;
DROP SEQUENCE sec_reservas;

-------- BORRADO DE PROCEDIMIENTOS --------
/* Procedimientos de INSERT */
DROP PROCEDURE insertCartas;
DROP PROCEDURE insertProductos;
DROP PROCEDURE insertProductoCarta;
DROP PROCEDURE insertMenus;
DROP PROCEDURE insertProductoMenu;
DROP PROCEDURE insertAlergenos;
DROP PROCEDURE insertContiene;
DROP PROCEDURE insertUsuarios;
DROP PROCEDURE insertComandas;
DROP PROCEDURE insertMesas;
DROP PROCEDURE insertReservas;

/* Procedimientos de UPDATE */
DROP PROCEDURE updateCartas;
DROP PROCEDURE updateProductos;
DROP PROCEDURE updateProductoCarta;
DROP PROCEDURE updateMenus;
DROP PROCEDURE updateProductoMenu;
DROP PROCEDURE updateAlergenos;
DROP PROCEDURE updateContiene;
DROP PROCEDURE updateUsuarios;
DROP PROCEDURE updateComandas;
DROP PROCEDURE updateMesas;
DROP PROCEDURE updateReservas;

-------- BORRADO DE CURSORES --------
DROP PROCEDURE cursorRF1;
DROP PROCEDURE cursorUno;
DROP PROCEDURE cursorDos;
DROP PROCEDURE cursorTres;

-------- BORRADO DE FUNCIONES --------
DROP FUNCTION obtenerNombreConId;
DROP FUNCTION obtenerComandasPorFecha;
DROP FUNCTION obtenerCapacidadConId;
DROP FUNCTION obtenerDescripcionConNombre;

-------- BORRADO DE PAQUETES --------
DROP PACKAGE PRUEBAS_ALERGENOS;
DROP PACKAGE PRUEBAS_MESAS;
DROP PACKAGE PRUEBAS_CARTAS;
DROP PACKAGE PRUEBAS_PRODUCTOS;
DROP PACKAGE PRUEBAS_PRODUCTO_CARTA;
DROP PACKAGE PRUEBAS_MENUS;
DROP PACKAGE PRUEBAS_COMANDAS;
