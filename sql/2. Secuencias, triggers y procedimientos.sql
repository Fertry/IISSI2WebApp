-------- RESTAURANTE CASA SALVI --------
/*

 Creación de las secuencias, triggers y procedimientos necesarios.

*/

-------- CREACIÓN DE SECUENCIAS --------
CREATE SEQUENCE sec_cartas;
CREATE OR REPLACE TRIGGER crea_oid_cartas
BEFORE INSERT ON Cartas
FOR EACH ROW
BEGIN 
SELECT sec_cartas.NEXTVAL INTO :NEW.idCarta FROM DUAL;
END;
/

CREATE SEQUENCE sec_productos;
CREATE OR REPLACE TRIGGER crea_oid_productos
BEFORE INSERT ON Productos
FOR EACH ROW
BEGIN 
SELECT sec_productos.NEXTVAL INTO :NEW.idProducto FROM DUAL;
END;
/

CREATE SEQUENCE sec_producto_carta;
CREATE OR REPLACE TRIGGER crea_oid_producto_carta
BEFORE INSERT ON ProductoCarta
FOR EACH ROW
BEGIN
SELECT sec_producto_carta.NEXTVAL INTO :NEW.idProductoCarta FROM DUAL;
END;
/

CREATE SEQUENCE sec_menus;
CREATE OR REPLACE TRIGGER crea_oid_menus
BEFORE INSERT ON Menus
FOR EACH ROW
BEGIN 
SELECT sec_menus.NEXTVAL INTO :NEW.idMenu FROM DUAL;
END;
/

CREATE SEQUENCE sec_producto_menu;
CREATE OR REPLACE TRIGGER crea_oid_producto_menu
BEFORE INSERT ON ProductoMenu
FOR EACH ROW
BEGIN
SELECT sec_producto_menu.NEXTVAL INTO :NEW.idProductoMenu FROM DUAL;
END;
/

CREATE SEQUENCE sec_alergenos;
CREATE OR REPLACE TRIGGER crea_oid_alergenos
BEFORE INSERT ON Alergenos
FOR EACH ROW
BEGIN 
SELECT sec_alergenos.NEXTVAL INTO :NEW.idAlergeno FROM DUAL;
END;
/

CREATE SEQUENCE sec_contiene;
CREATE OR REPLACE TRIGGER crea_oid_contiene
BEFORE INSERT ON Contiene
FOR EACH ROW
BEGIN 
SELECT sec_contiene.NEXTVAL INTO :NEW.OIDContiene FROM DUAL;
END;
/

CREATE SEQUENCE sec_usuarios;
CREATE OR REPLACE TRIGGER crea_oid_usuarios
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN 
SELECT sec_usuarios.NEXTVAL INTO :NEW.idUsuario FROM DUAL;
END;
/

CREATE SEQUENCE sec_comandas;
CREATE OR REPLACE TRIGGER crea_oid_comandas
BEFORE INSERT ON Comandas
FOR EACH ROW
BEGIN 
SELECT sec_comandas.NEXTVAL INTO :NEW.idComanda FROM DUAL;
END;
/

CREATE SEQUENCE sec_mesas;
CREATE OR REPLACE TRIGGER crea_oid_mesas
BEFORE INSERT ON Mesas
FOR EACH ROW
BEGIN 
SELECT sec_mesas.NEXTVAL INTO :NEW.idMesa FROM DUAL;
END;
/

CREATE SEQUENCE sec_reservas;
CREATE OR REPLACE TRIGGER crea_oid_reservas
BEFORE INSERT ON Reservas
FOR EACH ROW
BEGIN 
SELECT sec_reservas.NEXTVAL INTO :NEW.idReserva FROM DUAL;
END;
/

-------- TRIGGERS ASOCIADOS A REGLAS DE NEGOCIO --------
/* RN001. Una misma mesa no puede ser reservada por más de un cliente y no puede hacer
una reserva si el nº de personas es mayor a la capacidad de las mesa */
CREATE OR REPLACE TRIGGER TR_exclusividad_mesas BEFORE INSERT ON Reservas FOR EACH ROW
DECLARE
disponibilidad SMALLINT;
capacidad_mesa SMALLINT;
BEGIN
	SELECT disponible INTO disponibilidad FROM Mesas WHERE idMesa = :NEW.mesa;
	SELECT capacidad INTO capacidad_mesa FROM Mesas WHERE idMesa = :NEW.mesa;
    IF (disponibilidad <> 1) THEN
        RAISE_APPLICATION_ERROR(-20001, 'La mesa elegida ya se encuentra reservada');
    END IF;
	IF (capacidad_mesa < :NEW.numPersonas) THEN
        RAISE_APPLICATION_ERROR(-20002, 'La mesa elegida tiene una capacidad inferior a ' ||:NEW.numPersonas|| ' personas');
    END IF;
END;
/

/* RN002. Un cliente no puede realizar más de una reserva en una miasma hora */
CREATE OR REPLACE TRIGGER TR_derecho_reserva BEFORE INSERT ON Reservas FOR EACH ROW
DECLARE 
    contador SMALLINT;
BEGIN
    SELECT COUNT(*) INTO contador FROM Reservas WHERE (usuario = :NEW.usuario AND fecha = :NEW.fecha);
    IF (contador > 0) THEN
        RAISE_APPLICATION_ERROR(-20003, 'No puede reservar más de una mesa en la misma hora');
    END IF;
END;
/

/* RN003. Un cliente puede hacer, como máximo, 2 reservas al día */
CREATE TRIGGER TR_limite_reservas BEFORE INSERT ON Reservas FOR EACH ROW
DECLARE
    contador INTEGER;
BEGIN
    SELECT COUNT(*) INTO contador FROM Reservas WHERE (usuario = :NEW.usuario AND TO_CHAR(fecha, 'YYYY/MM/DD') = TO_CHAR(:NEW.fecha, 'YYYY/MM/DD'));
    IF (contador > 1) THEN
        RAISE_APPLICATION_ERROR(-20004, 'No puede realizar más de 2 reservas al día');
    END IF;
END;
/

-------- TRIGGERS ASOCIADOS A REQUISITOS --------
/* Cambia la disponibilidad de la mesa cuando es reservada */
CREATE TRIGGER TR_cambia_disponibilidad AFTER INSERT ON Reservas FOR EACH ROW
DECLARE
    mesaReservada SMALLINT;
BEGIN 
    SELECT idMesa INTO mesaReservada FROM Mesas WHERE idMesa = :NEW.mesa;
    UPDATE Mesas SET disponible = 0 WHERE idMesa = mesaReservada;
END;
/

-------- PROCEDIMIENTOS --------
/* Procedimientos de INSERT */
CREATE OR REPLACE PROCEDURE insertCartas
(temporada IN DATE) AS 
BEGIN
INSERT INTO Cartas (temporada)
VALUES (temporada);
END insertCartas;
/

CREATE OR REPLACE PROCEDURE insertProductos 
(nombre IN VARCHAR2, descripcion IN VARCHAR2, tipoProducto IN VARCHAR2, disponibilidad IN SMALLINT, precioProducto IN FLOAT) AS 
BEGIN
INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) 
VALUES (nombre, descripcion, tipoProducto, disponibilidad, precioProducto);
END insertProductos;
/

CREATE OR REPLACE PROCEDURE insertProductoCarta
(idCarta IN SMALLINT, idProducto IN SMALLINT) AS
BEGIN
INSERT INTO ProductoCarta (idCarta, idProducto) 
VALUES (idCarta, idProducto);
END insertProductoCarta;
/

CREATE OR REPLACE PROCEDURE insertMenus
(precio IN FLOAT, carta IN SMALLINT) AS
BEGIN
INSERT INTO Menus (precio, carta) 
VALUES (precio, carta);
END insertMenus;
/

CREATE OR REPLACE PROCEDURE insertProductoMenu
(nombre IN VARCHAR2, precio IN FLOAT, tipoPlato IN VARCHAR2, idProducto IN SMALLINT, idMenu IN SMALLINT) AS
BEGIN
INSERT INTO ProductoMenu (nombre, precio, tipoPlato, idProducto, idMenu) 
VALUES (nombre, precio, tipoPlato, idProducto, idMenu);
END insertProductoMenu;
/

CREATE OR REPLACE PROCEDURE insertAlergenos
(nombre in VARCHAR2, descripcion IN VARCHAR2) AS 
BEGIN
INSERT INTO Alergenos (nombre, descripcion) 
VALUES (nombre, descripcion);
END insertAlergenos;
/

CREATE OR REPLACE PROCEDURE insertContiene 
(idProducto IN SMALLINT, idAlergeno IN SMALLINT) AS 
BEGIN
INSERT INTO Contiene (idProducto, idAlergeno) 
VALUES (idProducto, idAlergeno);
END insertContiene;
/

CREATE OR REPLACE PROCEDURE insertUsuarios
(clase IN VARCHAR2, nombre IN VARCHAR2, apellidos IN VARCHAR2, telefono IN VARCHAR2, carta IN SMALLINT, usuario IN VARCHAR2, pass IN VARCHAR2) AS 
BEGIN
INSERT INTO Usuarios (clase, nombre, apellidos, telefono, carta, usuario, pass)
VALUES (clase, nombre, apellidos, telefono, carta, usuario, pass);
END insertUsuarios;
/

CREATE OR REPLACE PROCEDURE insertComandas
(fecha IN DATE, importe IN FLOAT, usuario IN SMALLINT) AS 
BEGIN
INSERT INTO Comandas (fecha, importe, usuario) 
VALUES (fecha, importe, usuario);
END insertComandas;
/

CREATE OR REPLACE PROCEDURE insertMesas
(disponible IN SMALLINT, capacidad IN SMALLINT) AS 
BEGIN
INSERT INTO Mesas (disponible, capacidad) 
VALUES (disponible, capacidad);
END insertMesas;
/

CREATE OR REPLACE PROCEDURE insertReservas
(fecha IN DATE, numPersonas IN SMALLINT, mesa IN SMALLINT, usuario IN SMALLINT, nombre IN VARCHAR2, apellidos IN VARCHAR2, telefono IN VARCHAR2) AS 
BEGIN
INSERT INTO Reservas (fecha, numPersonas, mesa, usuario, nombre, apellidos, telefono) 
VALUES (fecha, numPersonas, mesa, usuario, nombre, apellidos, telefono);
END insertReservas;
/

/* Procedimientos de UPDATE */
CREATE OR REPLACE PROCEDURE updateCartas
(idCartaP IN SMALLINT, temporadaP IN DATE) AS 
BEGIN
UPDATE Cartas SET temporada = temporadaP WHERE idCarta = idCartaP;
END updateCartas;
/

CREATE OR REPLACE PROCEDURE updateProductos
(idProductoP IN SMALLINT, nombreP IN VARCHAR2, descripcionP IN VARCHAR2, tipoProductoP IN VARCHAR2, disponibilidadP IN SMALLINT, precioProductoP IN FLOAT) AS 
BEGIN
UPDATE Productos SET nombre = nombreP, descripcion = descripcionP, tipoProducto = tipoProductoP, disponibilidad = disponibilidadP, precioProducto = precioProductoP WHERE idProducto = idProductoP;
END updateProductos;
/

CREATE OR REPLACE PROCEDURE updateProductoCarta 
(idProductoCartaP IN SMALLINT, idCartaP IN SMALLINT, idProductoP IN SMALLINT) AS
BEGIN
UPDATE ProductoCarta SET idCarta = idCartaP, idProducto = idProductoP WHERE idProductoCarta = idProductoCartaP;
END updateProductoCarta;
/

CREATE OR REPLACE PROCEDURE updateMenus
(idMenuP IN SMALLINT, precioP IN FLOAT, cartaP in SMALLINT) AS
BEGIN
UPDATE Menus SET precio = precioP, carta = cartaP WHERE idMenu = idMenuP;
END updateMenus;
/

CREATE OR REPLACE PROCEDURE updateProductoMenu
(idProductoMenuP IN SMALLINT, nombreP IN VARCHAR2, precioP IN FLOAT, tipoPlatoP IN VARCHAR2, idProductoP IN SMALLINT, idMenuP IN SMALLINT) AS
BEGIN
UPDATE ProductoMenu SET nombre = nombreP, precio = precioP, tipoPlato = tipoPlatoP, idProducto = idProductoP, idMenu = idMenuP WHERE idProductoMenu = idProductoMenuP;
END updateProductoMenu;
/

CREATE OR REPLACE PROCEDURE updateAlergenos
(idAlergenoP IN SMALLINT, nombreP IN VARCHAR2, descripcionP IN VARCHAR2) AS 
BEGIN
UPDATE Alergenos SET nombre = nombreP, descripcion = descripcionP WHERE idAlergeno = idAlergenoP;
END updateAlergenos;
/

CREATE OR REPLACE PROCEDURE updateContiene
(OIDContieneP IN SMALLINT, idProductoP IN SMALLINT, idAlergenoP IN SMALLINT) AS 
BEGIN
UPDATE Contiene SET idProducto = idProductoP, idAlergeno = idAlergenoP WHERE OIDContiene = OIDContieneP;
END updateContiene;
/

CREATE OR REPLACE PROCEDURE updateUsuarios
(idUsuarioP IN SMALLINT, claseP IN VARCHAR2, nombreP IN VARCHAR2, apellidosP IN VARCHAR2, telefonoP IN VARCHAR2, cartaP IN SMALLINT, usuarioP IN VARCHAR2, passP in VARCHAR2) AS 
BEGIN
UPDATE Usuarios SET clase = claseP, nombre = nombreP, apellidos = apellidosP, telefono = telefonoP, carta = cartaP, usuario = usuarioP, pass = passP WHERE idUsuario = idUsuarioP;
END updateUsuarios;
/

CREATE OR REPLACE PROCEDURE updateComandas
(idComandaP IN SMALLINT, fechaP IN DATE, importeP IN FLOAT, usuarioP IN SMALLINT) AS 
BEGIN
UPDATE Comandas SET fecha = fechaP, importe = importeP, usuario = usuarioP WHERE idComanda = idComandaP;
END updateComandas;
/

CREATE OR REPLACE PROCEDURE updateMesas
(idMesaP IN SMALLINT, disponibleP IN SMALLINT, capacidadP IN SMALLINT) AS 
BEGIN
UPDATE Mesas SET disponible = disponibleP, capacidad = capacidadP WHERE idMesa = idMesaP;
END updateMesas;
/

CREATE OR REPLACE PROCEDURE updateReservas
(idReservaP IN SMALLINT, fechaP IN DATE, numPersonasP IN SMALLINT, mesaP IN SMALLINT, usuarioP IN SMALLINT, nombreP IN VARCHAR2, apellidosP IN VARCHAR2, telefonoP IN VARCHAR2) AS 
BEGIN
UPDATE Reservas SET fecha = fechaP, numPersonas = numPersonasP, mesa = mesaP, usuario = usuarioP, nombre = nombreP, apellidos = apellidosP, telefono = telefonoP WHERE idReserva = idReservaP;
END updateReservas;
/
