-------- 3 ENTREGABLE IISSI 1 - RESTAURANTE SEVILLA --------

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

/* Procedimientos asociados a cursores */
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

-------- CREACIÓN DE TABLAS ----------- 
CREATE TABLE Cartas (     
    idCarta SMALLINT PRIMARY KEY,   
    temporada DATE NOT NULL
);

CREATE TABLE Productos (     
    idProducto SMALLINT PRIMARY KEY,     
    nombre VARCHAR2(100) NOT NULL, 
    descripcion VARCHAR2(200) NOT NULL,     
    tipoProducto VARCHAR2(100) NOT NULL, 
    disponibilidad SMALLINT NOT NULL,     
    precioProducto FLOAT NOT NULL
);

CREATE TABLE ProductoCarta (
    idProductoCarta SMALLINT PRIMARY KEY,
    idCarta SMALLINT,
    idProducto SMALLINT,
    FOREIGN KEY(idCarta) REFERENCES Cartas ON DELETE SET NULL,
    FOREIGN KEY(idProducto) REFERENCES Productos ON DELETE SET NULL
);

CREATE TABLE Menus (     
    idMenu SMALLINT PRIMARY KEY,      
    precio FLOAT NOT NULL UNIQUE,
    carta SMALLINT,
    FOREIGN KEY(carta) REFERENCES Cartas ON DELETE SET NULL
);

CREATE TABLE ProductoMenu (
    idProductoMenu SMALLINT PRIMARY KEY,
    tipoPlato VARCHAR2(50),
    idProducto SMALLINT,
    idMenu SMALLINT,
    FOREIGN KEY (idProducto) REFERENCES Productos ON DELETE SET NULL,
    FOREIGN KEY (idMenu) REFERENCES Menus ON DELETE SET NULL
);

CREATE TABLE Alergenos (     
    idAlergeno SMALLINT PRIMARY KEY,     
    nombre VARCHAR2(100) NOT NULL, 
    descripcion VARCHAR2(200) NOT NULL
);

CREATE TABLE Contiene (     
    OIDContiene SMALLINT PRIMARY KEY,     
    idProducto SMALLINT, 
    idAlergeno SMALLINT,
    FOREIGN KEY(idProducto) REFERENCES Productos ON DELETE SET NULL,
    FOREIGN KEY(idAlergeno) REFERENCES Alergenos ON DELETE SET NULL
);

CREATE TABLE Usuarios (     
    idUsuario SMALLINT PRIMARY KEY,     
    clase VARCHAR2(50) NOT NULL, 
    nombre VARCHAR2(100) NOT NULL,     
    apellidos VARCHAR2(100) NOT NULL, 
    telefono VARCHAR2(15) NOT NULL CHECK (LENGTH (telefono) = 9),
    carta SMALLINT,
    usuario VARCHAR2(50),
    pass VARCHAR2(50),
    FOREIGN KEY(carta) REFERENCES Cartas ON DELETE SET NULL
);

CREATE TABLE Comandas (     
    idComanda SMALLINT PRIMARY KEY,     
    fecha DATE NOT NULL,    
    importe FLOAT NOT NULL, 
    usuario SMALLINT,
    FOREIGN KEY(usuario) REFERENCES Usuarios ON DELETE SET NULL
);

CREATE TABLE Mesas (     
    idMesa SMALLINT PRIMARY KEY,     
    disponible SMALLINT NOT NULL, 
    capacidad SMALLINT NOT NULL CHECK (capacidad <= 10)
);

CREATE TABLE Reservas (     
    idReserva SMALLINT PRIMARY KEY,     
    fecha DATE NOT NULL,      
    numPersonas SMALLINT NOT NULL CHECK (numPersonas <= 10),
    mesa SMALLINT,     
    usuario SMALLINT,
    FOREIGN KEY(mesa) REFERENCES Mesas ON DELETE SET NULL, 
    FOREIGN KEY(usuario) REFERENCES Usuarios ON DELETE SET NULL
);

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

-------- TRIGGERS DE REGLAS DE NEGOCIO --------
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

/* RN004. Un producto nulo no puede incluirse en el menú */
CREATE TRIGGER TR_producto_disponible BEFORE UPDATE OR INSERT ON ProductoMenu FOR EACH ROW
DECLARE
    disponible SMALLINT;
BEGIN 
    SELECT disponibilidad INTO disponible FROM Productos WHERE idProducto = :NEW.idProducto;
    IF (disponible = 0) THEN
        RAISE_APPLICATION_ERROR(-20005, 'Producto no disponible');
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
(tipoPlato IN VARCHAR2, idProducto IN SMALLINT, idMenu IN SMALLINT) AS
BEGIN
INSERT INTO ProductoMenu (tipoPlato, idProducto, idMenu) 
VALUES (tipoPlato, idProducto, idMenu);
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
(fecha IN DATE, numPersonas IN SMALLINT, mesa IN SMALLINT, usuario IN SMALLINT) AS 
BEGIN
INSERT INTO Reservas (fecha, numPersonas, mesa, usuario) 
VALUES (fecha, numPersonas, mesa, usuario);
END insertReservas;
/

/* Procedimientos de UPDATE */
CREATE OR REPLACE PROCEDURE updateCartas
(idCarta IN SMALLINT, temporada IN DATE) AS 
BEGIN
UPDATE Cartas SET temporada = temporada WHERE idCarta = idCarta;
END updateCartas;
/

CREATE OR REPLACE PROCEDURE updateProductos
(idProducto IN SMALLINT, nombre IN VARCHAR2, descripcion IN VARCHAR2, tipoProducto IN VARCHAR2, disponibilidad IN SMALLINT, precioProducto IN FLOAT) AS 
BEGIN
UPDATE Productos SET nombre = nombre, descripcion = descripcion, tipoProducto = tipoProducto, disponibilidad = disponibilidad, precioProducto = precioProducto WHERE idProducto = idProducto;
END updateProductos;
/

CREATE OR REPLACE PROCEDURE updateProductoCarta 
(idProductoCarta IN SMALLINT, idCarta IN SMALLINT, idProducto IN SMALLINT) AS
BEGIN
UPDATE ProductoCarta SET idCarta = idCarta, idProducto = idProducto WHERE idProductoCarta = idProductoCarta;
END updateProductoCarta;
/

CREATE OR REPLACE PROCEDURE updateMenus
(idMenu IN SMALLINT, precio IN FLOAT, carta in SMALLINT) AS
BEGIN
UPDATE Menus SET precio = precio, carta = carta WHERE idMenu = idMenu;
END updateMenus;
/

CREATE OR REPLACE PROCEDURE updateProductoMenu
(idProductoMenu IN SMALLINT, tipoPlato IN VARCHAR2, idProducto IN SMALLINT, idMenu IN SMALLINT) AS
BEGIN
UPDATE ProductoMenu SET tipoPlato = tipoPlato, idProducto = idProducto, idMenu = idMenu WHERE idProductoMenu = idProductoMenu;
END updateProductoMenu;
/

CREATE OR REPLACE PROCEDURE updateAlergenos
(idAlergeno IN SMALLINT, nombre in VARCHAR2, descripcion IN VARCHAR2) AS 
BEGIN
UPDATE Alergenos SET nombre = nombre, descripcion = descripcion WHERE idAlergeno = idAlergeno;
END updateAlergenos;
/

CREATE OR REPLACE PROCEDURE updateContiene
(OIDContiene IN SMALLINT, idProducto IN SMALLINT, idAlergeno IN SMALLINT) AS 
BEGIN
UPDATE Contiene SET idProducto = idProducto, idAlergeno = idAlergeno WHERE OIDContiene = OIDContiene;
END updateContiene;
/

CREATE OR REPLACE PROCEDURE updateUsuarios
(idUsuario IN SMALLINT, clase IN VARCHAR2, nombre IN VARCHAR2, apellidos IN VARCHAR2, telefono IN VARCHAR2, carta IN SMALLINT, usuario IN VARCHAR2, pass IN VARCHAR2) AS 
BEGIN
UPDATE Usuarios SET clase = clase, nombre = nombre, apellidos = apellidos, telefono = telefono, carta = carta, usuario = usuario, pass = pass WHERE idUsuario = idUsuario;
END updateUsuarios;
/

CREATE OR REPLACE PROCEDURE updateComandas
(idComanda IN SMALLINT, fecha IN DATE, importe IN FLOAT, usuario IN SMALLINT) AS 
BEGIN
UPDATE Comandas SET fecha = fecha, importe = importe, usuario = usuario WHERE idComanda = idComanda;
END updateComandas;
/

CREATE OR REPLACE PROCEDURE updateMesas
(idMesa IN SMALLINT, disponible IN SMALLINT, capacidad IN SMALLINT) AS 
BEGIN
UPDATE Mesas SET disponible = disponible, capacidad = capacidad WHERE idMesa = idMesa;
END updateMesas;
/

CREATE OR REPLACE PROCEDURE updateReservas
(idReserva IN SMALLINT, fecha IN DATE, numPersonas IN SMALLINT, mesa IN SMALLINT, usuario IN SMALLINT) AS 
BEGIN
UPDATE Reservas SET fecha = fecha, numPersonas = numPersonas, mesa = mesa, usuario = usuario WHERE idReserva = idReserva;
END updateReservas;
/

-------- CASOS DE PRUEBA --------
/* Datos de Cartas */
/* Mediante procedimientos: */
EXECUTE insertCartas(TO_DATE('2020/01/01','yyyy/mm/dd'));

/* Mediante INSERTS: */
/*
INSERT INTO Cartas (temporada) VALUES (TO_DATE('2020/01/01','yyyy/mm/dd'));
*/

/* Datos de Productos */
/* Mediante procedimientos: */
EXECUTE insertProductos('Macarrones', 'Macarrones con tomate', 'PASTA', 1, 9);
EXECUTE insertProductos('Pechuga de Pollo', 'Pechuga de pollo a la carbonara', 'CARNE', 1, 5);
EXECUTE insertProductos('Mousse de Chocolate', 'Mousse de Chocolate', 'POSTRE', 1, 4);
EXECUTE insertProductos('Estrella Galicia', 'Cerveza', 'BEBIDA', 1, 1);

/* Mediante INSERTS: */
/*
INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES ('Macarrones', 'Macarrones con tomate', 'PRIMERPLATO', 1, 9);
INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES ('Pechuga de pollo', 'Pechuga de pollo a la carbonara', 'SEGUNDOPLATO', 1, 5);
INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES ('Mousse de Chocolate', 'Mousse de chocolate', POSTRE, 1, 4);
INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES ('Estrella Galicia', 'Cerveza', 'BEBIDA', 1, 1);
*/

/* Datos de ProductoCarta */
/* Mediante procedimientos: */
EXECUTE insertProductoCarta(1, 1);
EXECUTE insertProductoCarta(1, 2);
EXECUTE insertProductoCarta(1, 3);
EXECUTE insertProductoCarta(1, 4);

/* Mediante INSERTS: */
/*
INSERT INTO ProductoCarta (idCarta, idProducto) VALUES (1, 1);
INSERT INTO ProductoCarta (idCarta, idProducto) VALUES (1, 2);
INSERT INTO ProductoCarta (idCarta, idProducto) VALUES (1, 3);
INSERT INTO ProductoCarta (idCarta, idProducto) VALUES (1, 4);
*/

/* Datos de Menus */
/* Mediante procedimientos: */
EXECUTE insertMenus(18, 1);

/* Mediante INSERTS: */
/*
INSERT INTO Menus (precio, carta) VALUES (18, 1);
*/

/* Datos de ProductoMenu */
/* Mediante procedimientos: */
EXECUTE insertProductoMenu('PRIMERPLATO', 1, 1);
EXECUTE insertProductoMenu('SEGUNDOPLATO', 2, 1);
EXECUTE insertProductoMenu('POSTRE', 3, 1);
EXECUTE insertProductoMenu('BEBIDA', 4, 1); 
/* Mediante INSERTS: */
/*
INSERT INTO ProductoMenu (tipoPlato, idProducto, idMenu) VALUES ('PRIMERPLATO', 1, 1);
INSERT INTO ProductoMenu (tipoPlato, idProducto, idMenu) VALUES ('SEGUNDOPLATO', 2, 1);
INSERT INTO ProductoMenu (tipoPlato, idProducto, idMenu) VALUES ('POSTRE', 3, 1);
INSERT INTO ProductoMenu (tipoPlato, idProducto, idMenu) VALUES ('BEBIDA', 4, 1);
*/

/* Datos de Alergenos */
/* Mediante procedimientos: */
EXECUTE insertAlergenos('Lactosa', 'Lactosa');
EXECUTE insertAlergenos('Caseína', 'Caseína');
EXECUTE insertAlergenos('Gluten de trigo', 'Gluten de trigo');
EXECUTE insertAlergenos('Proteína de soja', 'Proteína de soja');
/* Mediante INSERTS: */
/*
INSERT INTO Alergenos (nombre, descripcion) VALUES ('Lactosa', 'Lactosa');
INSERT INTO Alergenos (nombre, descripcion) VALUES ('Caseína', 'Caseína');
INSERT INTO Alergenos (nombre, descripcion) VALUES ('Gluten de trigo', 'Gluten de trigo');
INSERT INTO Alergenos (nombre, descripcion) VALUES ('Proteína de soja', 'Proteína de soja');
*/

/* Datos de Contiene */
/* Mediante procedimientos: */
EXECUTE insertContiene(1, 1);
EXECUTE insertContiene(2, 2);
EXECUTE insertContiene(3, 3);
EXECUTE insertContiene(4, 4);
/* Mediante INSERTS: */
/*
INSERT INTO Contiene (idProducto, idAlergeno) VALUES (1, 1);
INSERT INTO Contiene (idProducto, idAlergeno) VALUES (2, 2);
INSERT INTO Contiene (idProducto, idAlergeno) VALUES (3, 3);
INSERT INTO Contiene (idProducto, idAlergeno) VALUES (4, 4);
*/

/* Datos de Usuarios */
/* Mediante procedimientos: */
EXECUTE insertUsuarios('GERENTE', 'Jose Manuel', 'Torres', '987567521', 1, 'admin', 'admin');
EXECUTE insertUsuarios('MAITRE', 'Miguel', 'Carrasco', '673334582', null);
EXECUTE insertUsuarios('CLIENTE', 'David', 'Fernandez', '756345987', null);
EXECUTE insertUsuarios('CLIENTE', 'María', 'Triguero', '683450986', null);
EXECUTE insertUsuarios('CLIENTE', 'Ana', 'Gonzalez', '351789054', null);
/* Mediante INSERTS: */
/*
INSERT INTO Usuarios (clase, nombre, apellidos, telefono, carta) VALUES ('GERENTE', 'Jose Manuel', 'Torres', '987567521', 1, 'admin', 'admin');
INSERT INTO Usuarios (clase, nombre, apellidos, telefono, carta) VALUES ('MAITRE', 'Miguel', 'Carrasco', '673334582', null);
INSERT INTO Usuarios (clase, nombre, apellidos, telefono, carta) VALUES ('CLIENTE', 'David', 'Fernandez', '756345987', null);
INSERT INTO Usuarios (clase, nombre, apellidos, telefono, carta) VALUES ('CLIENTE', 'María', 'Triguero', '683450986', null);
INSERT INTO Usuarios (clase, nombre, apellidos, telefono, carta) VALUES ('CLIENTE', 'Ana', 'Gonzalez', '351789054', null);
*/

/* Datos de Comandas */
/* Mediante procedimientos: */
EXECUTE insertComandas(TO_DATE('2020/01/11','yyyy/mm/dd'), 21, 2);
EXECUTE insertComandas(TO_DATE('2020/01/11','yyyy/mm/dd'), 23, 2);
EXECUTE insertComandas(TO_DATE('2020/01/08','yyyy/mm/dd'), 24, 2);
EXECUTE insertComandas(TO_DATE('2020/01/09','yyyy/mm/dd'), 25, 2);
EXECUTE insertComandas(TO_DATE('2019/12/20','yyyy/mm/dd'), 26, 2);
EXECUTE insertComandas(TO_DATE('2019/12/21','yyyy/mm/dd'), 27, 2);
/* Mediante INSERTS: */
/*
INSERT INTO Comandas (fecha, importe, usuario) VALUES (TO_DATE('2020/01/11','yyyy/mm/dd'), 21, 2);
INSERT INTO Comandas (fecha, importe, usuario) VALUES (TO_DATE('2020/01/11','yyyy/mm/dd'), 23, 2);
INSERT INTO Comandas (fecha, importe, usuario) VALUES (TO_DATE('2020/01/08','yyyy/mm/dd'), 24, 2);
INSERT INTO Comandas (fecha, importe, usuario) VALUES (TO_DATE('2020/01/09','yyyy/mm/dd'), 25, 2);
INSERT INTO Comandas (fecha, importe, usuario) VALUES (TO_DATE('2019/12/20','yyyy/mm/dd'), 26, 2);
INSERT INTO Comandas (fecha, importe, usuario) VALUES (TO_DATE('2019/12/21','yyyy/mm/dd'), 27, 2);
*/

/* Datos de Mesas */
/* Mediante procedimientos: */
EXECUTE insertMesas(1, 4);
EXECUTE insertMesas(1, 4);
EXECUTE insertMesas(1, 6);
EXECUTE insertMesas(1, 8);
EXECUTE insertMesas(1, 10);
EXECUTE insertMesas(1, 10);
/* Mediante INSERTS: */
/*
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 4);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 4);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 6);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 8);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 10);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 12);
*/

/* Datos de Reservas */
/* Mediante procedimientos: */
EXECUTE insertReservas(TO_DATE('2020/01/11-13','yyyy/mm/dd-HH24'), 4, 1, 3);
EXECUTE insertReservas(TO_DATE('2020/01/11-13','yyyy/mm/dd-HH24'), 4, 2, 4);
EXECUTE insertReservas(TO_DATE('2020/01/08-20','yyyy/mm/dd-HH24'), 4, 3, 5);
EXECUTE insertReservas(TO_DATE('2020/01/09-14','yyyy/mm/dd-HH24'), 6, 4, 3);
EXECUTE insertReservas(TO_DATE('2020/02/16-15','yyyy/mm/dd-HH24'), 6, 5, 4);
EXECUTE insertReservas(TO_DATE('2020/02/20-21','yyyy/mm/dd-HH24'), 8, 6, 5);
/* Mediante INSERTS: */
/*
INSERT INTO Reservas (fecha, numPersonas, mesa, usuario) VALUES (TO_DATE('2020/01/11-13','yyyy/mm/dd-HH24'), 4, 1, 3);
INSERT INTO Reservas (fecha, numPersonas, mesa, usuario) VALUES (TO_DATE('2020/01/11-13','yyyy/mm/dd-HH24'), 4, 2, 4);
INSERT INTO Reservas (fecha, numPersonas, mesa, usuario) VALUES (TO_DATE('2020/01/08-20','yyyy/mm/dd-HH24'), 4, 3, 5);
INSERT INTO Reservas (fecha, numPersonas, mesa, usuario) VALUES (TO_DATE('2020/01/09-14','yyyy/mm/dd-HH24'), 6, 4, 3);
INSERT INTO Reservas (fecha, numPersonas, mesa, usuario) VALUES (TO_DATE('2020/02/16-15','yyyy/mm/dd-HH24'), 6, 5, 4);
INSERT INTO Reservas (fecha, numPersonas, mesa, usuario) VALUES (TO_DATE('2020/02/20-21','yyyy/mm/dd-HH24'), 8, 6, 5);
*/

-------- CONSULTAS --------
/* Cuenta todos los objetos que hay en cada tabla */
SELECT count(idCarta) FROM Cartas;
SELECT count(idProducto) FROM Productos;
SELECT count(idProductoCarta) FROM ProductoCarta;
SELECT count(idMenu) FROM Menus;
SELECT count(idProductoMenu) FROM ProductoMenu;
SELECT count(idAlergeno) FROM Alergenos;
SELECT count(OIDContiene) FROM Contiene;
SELECT count(idUsuario) FROM Usuarios;
SELECT count(idComanda) FROM Comandas;
SELECT count(idMesa) FROM Mesas;
SELECT count(idReserva) FROM Reservas;

/* Consultas asociadas a requisitos funcionales */
/* RF1 - Listado de reservas dado un idUsuario */
SELECT * FROM Reservas R, Usuarios U WHERE R.usuario = U.idUsuario;

/* RF2 - Listado de comandas emitidas por cada maître */
SELECT * FROM Comandas C, Usuarios U WHERE C.usuario = U.idUsuario ORDER BY importe DESC;

/* RF3 - Listado de alergenos asociados a productos */
SELECT idProducto, nombre FROM Contiene C, Alergenos A WHERE C.idAlergeno = A.idAlergeno;

/* RF4 - Listado de todos los productos */
SELECT * FROM Productos WHERE disponibilidad > 0 ORDER BY precioProducto DESC; 

/* RF5 - Sumatorio del importe de todas las comandas del mes */
SELECT SUM(importe) FROM Comandas WHERE TO_CHAR(fecha, 'yyyy/mm') = TO_CHAR(SYSDATE, 'yyyy/mm');

-------- CURSORES --------
SET SERVEROUTPUT ON

-- Las tres reservas más antiguas
CREATE OR REPLACE PROCEDURE cursorUno IS
BEGIN
    DECLARE
        CURSOR cUno IS
        SELECT fecha, numPersonas FROM Reservas ORDER BY fecha; 
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Las tres reservas mas antiguas'); 
            FOR fila IN cUno LOOP
                EXIT WHEN cUno%ROWCOUNT >3;
                DBMS_OUTPUT.PUT_LINE(fila.fecha||' '||fila.numPersonas) ; 
            END LOOP;
    END;
END cursorUno;
/

-- Los tres primeros productos por orden alfabético
CREATE OR REPLACE PROCEDURE cursorDos IS
BEGIN
    DECLARE
        CURSOR cDos IS
        SELECT idProducto, nombre FROM Productos ORDER BY nombre; 
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Los tres primeros productos por orden alfabético'); 
            FOR fila IN cDos LOOP
                EXIT WHEN cDos%ROWCOUNT >3;
                DBMS_OUTPUT.PUT_LINE(fila.idProducto||' '||fila.nombre) ; 
            END LOOP;
    END;
END cursorDos;
/

-- Las tres comandas mas recientes
CREATE OR REPLACE PROCEDURE cursorTres IS
BEGIN
    DECLARE
        CURSOR cTres IS
        SELECT importe, fecha FROM Comandas ORDER BY fecha DESC; 
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Las tres comandas mas recientes'); 
            FOR fila IN cTres LOOP
                EXIT WHEN cTres%ROWCOUNT >3;
                DBMS_OUTPUT.PUT_LINE(fila.fecha||' '||fila.importe) ; 
            END LOOP;
    END;
END cursorTres;
/

--SET SERVEROUTPUT OFF

/* PRUEBA DE CURSORES */
EXECUTE cursorUno;
EXECUTE cursorDos;
EXECUTE cursorTres;

-------- FUNCIONES --------
/* Pasas una id de usuario y devuelve el nombre del usuario */
CREATE OR REPLACE FUNCTION obtenerNombreConId (idu Usuarios.idUsuario%TYPE)
RETURN VARCHAR2 IS nombreU Usuarios.nombre%TYPE;
BEGIN
    SELECT DISTINCT nombre INTO nombreU FROM Usuarios WHERE idUsuario = idu;
RETURN (nombreU);
END obtenerNombreConId;
/

/* Pasas una fecha y devuelve la suma de todas las comandas para esa fecha */
CREATE OR REPLACE FUNCTION obtenerComandasPorFecha (fechaIntroducida IN Comandas.fecha%TYPE)
RETURN FLOAT IS 
total Comandas.importe%TYPE;
BEGIN
    SELECT SUM(importe) INTO total FROM Comandas WHERE (TO_CHAR(fecha, 'yyyy/mm/dd') = TO_CHAR(fechaIntroducida, 'yyyy/mm/dd'));
RETURN (total);
END obtenerComandasPorFecha;
/

/* Pasas el id de una mesa y devuelve la capacidad máxima de dicha mesa  */
CREATE OR REPLACE FUNCTION obtenerCapacidadConId (idm Mesas.idMesa%TYPE)
RETURN VARCHAR2 IS capacidadM Mesas.capacidad%TYPE;
BEGIN
    SELECT DISTINCT capacidad INTO capacidadM FROM Mesas WHERE idMesa = idm;
RETURN (capacidadM);
END obtenerCapacidadConId;
/

/* Pasas un nombre de un alérgeno y devuelve su descripción asociada */
CREATE OR REPLACE FUNCTION obtenerDescripcionConNombre (nombreA Alergenos.nombre%TYPE)
RETURN VARCHAR2 IS descripcionA Alergenos.descripcion%TYPE;
BEGIN
    SELECT DISTINCT descripcion INTO descripcionA FROM Alergenos WHERE nombre = nombreA;
RETURN (descripcionA);
END obtenerDescripcionConNombre;
/

/* PRUEBA DE FUNCIONES */
SELECT obtenerNombreConId(1) FROM DUAL;
SELECT obtenerComandasPorFecha(TO_DATE('2020/01/11', 'yyyy/mm/dd')) FROM DUAL;
SELECT obtenerCapacidadConId(4) FROM DUAL;
SELECT obtenerDescripcionConNombre('Lactosa') FROM DUAL;

-------- PAQUETES PARA PRUEBAS AUTOMATICAS --------
/* Funcion que comprueba los resultados de las pruebas */	
/* Necesario para todas las pruebas automaticas */				
CREATE OR REPLACE
FUNCTION ASSERT_EQUALS (salida BOOLEAN,salidaEsperada BOOLEAN) RETURN VARCHAR2 AS
BEGIN
    IF (salida = salidaEsperada) THEN
        RETURN 'EXITO';
    ELSE
        RETURN 'FALLO';
    END IF;
END ASSERT_EQUALS;
/

/* Paquete de la tabla Alergeno */
/* Cabecera */
CREATE OR REPLACE 
PACKAGE PRUEBAS_ALERGENOS AS

    PROCEDURE inicializar;
    PROCEDURE insertar
    (nombre_prueba VARCHAR2, nombreP VARCHAR2, descripcionP VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
    (nombre_prueba VARCHAR2, idAlergenoP SMALLINT, nombreP VARCHAR2, descripcionP VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
    (nombre_prueba VARCHAR2, idAlergenoP SMALLINT, salidaEsperada BOOLEAN);
    
END PRUEBAS_ALERGENOS;
/

/* Cuerpo */
CREATE OR REPLACE 
PACKAGE BODY PRUEBAS_ALERGENOS AS

    /* Inicializacion, vacia la tabla */
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM Alergenos;
    END inicializar;
    
    /* Insercion */
    PROCEDURE insertar (nombre_prueba VARCHAR2, nombreP VARCHAR2, descripcionP VARCHAR2, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        alergeno Alergenos%ROWTYPE;
        idAlergenoP SMALLINT;
    BEGIN
        /* Insertar alergeno */
        INSERT INTO Alergenos(nombre, descripcion) VALUES (nombreP, descripcionP);
        
        /* Seleccionar alergeno y comprobar que los datos se insertaron correctamente */
        idAlergenoP := sec_alergenos.CURRVAL;
        SELECT * INTO alergeno FROM Alergenos WHERE idAlergeno = idAlergenoP;
        IF (alergeno.nombre <> nombreP AND alergeno.descripcion <> descripcionP) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;

    END insertar;
        
    /* Actualizacion */
    PROCEDURE actualizar (nombre_prueba VARCHAR2, idAlergenoP SMALLINT, nombreP VARCHAR2, descripcionP VARCHAR2, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        alergeno Alergenos%ROWTYPE;
    BEGIN
    
        /* Actualizar alergeno */
        UPDATE Alergenos SET nombre = nombreP, descripcion = descripcionP WHERE idAlergeno = idAlergenoP;
        
        /* Seleccionar alergeno y comprobar que los datos se actualizaron correctamente */
        SELECT * INTO alergeno FROM Alergenos WHERE idAlergeno = idAlergenoP;
        IF (alergeno.nombre <> nombreP AND alergeno.descripcion <> descripcionP) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;
            
    END actualizar;

    /* Eliminacion */
    PROCEDURE eliminar (nombre_prueba VARCHAR2, idAlergenoP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        numeroAlergeno INTEGER;
    BEGIN 
        
        /* Eliminar alergeno */
        DELETE FROM Alergenos WHERE idAlergeno = idAlergenoP;
        
        /* Verificar que alergeno no se encuentra en la base de datos */
        SELECT COUNT(*) INTO numeroAlergeno FROM Alergenos WHERE idAlergeno = idAlergenoP;
        IF (numeroAlergeno <> 0) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;
            
    END eliminar;
    
END PRUEBAS_ALERGENOS;
/

/* Prueba del paquete Alergenos */
/* SET SERVEROUTPUT DEBE ESTAR EN ON */
DECLARE 
    idAlergeno SMALLINT;
BEGIN
    PRUEBAS_ALERGENOS.inicializar;
    PRUEBAS_ALERGENOS.insertar('PRUEBA 1 - Insercion', 'Prueba', 'Lactosa', TRUE);
    idAlergeno := sec_alergenos.CURRVAL;
    PRUEBAS_ALERGENOS.actualizar('PRUEBA 2 - Actualizacion', idAlergeno, 'Lactosa', 'Azucar en la leche', TRUE);
    PRUEBAS_ALERGENOS.eliminar('PRUEBA 3 - Eliminacion', idAlergeno, TRUE);
END;
/

/* Paquete de la tabla Mesas */
/* Cabecera */
CREATE OR REPLACE 
PACKAGE PRUEBAS_MESAS AS

    PROCEDURE inicializar;
    PROCEDURE insertar
    (nombre_prueba VARCHAR2, disponibleP VARCHAR2, capacidadP VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
    (nombre_prueba VARCHAR2, idMesaP SMALLINT, disponibleP VARCHAR2, capacidadP VARCHAR2, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
    (nombre_prueba VARCHAR2, idMesaP SMALLINT, salidaEsperada BOOLEAN);
    
END PRUEBAS_MESAS;
/

/* Body */
CREATE OR REPLACE 
PACKAGE BODY PRUEBAS_MESAS AS

    /* Inicializacion, vacia la tabla */
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM Mesas;
    END inicializar;
    
    /* Insercion */
    PROCEDURE insertar (nombre_prueba VARCHAR2, disponibleP VARCHAR2, capacidadP VARCHAR2, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        mesa Mesas%ROWTYPE;
        idMesaP SMALLINT;
    BEGIN
        /* Insertar mesa */
        INSERT INTO Mesas(disponible, capacidad) VALUES (disponibleP, capacidadP);
        
        /* Seleccionar mesa y comprobar que los datos se insertaron correctamente */
        idMesaP := sec_mesas.CURRVAL;
        SELECT * INTO mesa FROM Mesas WHERE idMesa = idMesaP;
        IF (mesa.disponible <> disponibleP AND mesa.capacidad <> capacidadP) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;

    END insertar;
        
    /* Actualizacion */
    PROCEDURE actualizar (nombre_prueba VARCHAR2, idMesaP SMALLINT, disponibleP VARCHAR2, capacidadP VARCHAR2, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        mesa Mesas%ROWTYPE;
    BEGIN
    
        /* Actualizar mesa */
        UPDATE Mesas SET disponible = disponibleP, capacidad = capacidadP WHERE idMesa = idMesaP;
        
        /* Seleccionar mesa y comprobar que los datos se actualizaron correctamente */
        SELECT * INTO mesa FROM Mesas WHERE idMesa = idMesaP;
        IF (mesa.disponible <> disponibleP AND mesa.capacidad <> capacidadP) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;
            
    END actualizar;

    /* Eliminacion */
    PROCEDURE eliminar (nombre_prueba VARCHAR2, idMesaP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        numeroMesa INTEGER;
    BEGIN 
        
        /* Eliminar mesa */
        DELETE FROM Mesas WHERE idMesa = idMesaP;
        
        /* Verificar que mesa no se encuentra en la base de datos */
        SELECT COUNT(*) INTO numeroMesa FROM Mesas WHERE idMesa = idMesaP;
        IF (numeroMesa <> 0) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;
            
    END eliminar;
    
END PRUEBAS_MESAS;
/

/* Prueba del paquete Mesas */
/* SET SERVEROUTPUT DEBE ESTAR EN ON */
DECLARE 
    idMesa SMALLINT;
BEGIN
    PRUEBAS_MESAS.inicializar;
    PRUEBAS_MESAS.insertar('PRUEBA 1 - Insercion', 1, 8, TRUE);
    idMesa := sec_mesas.CURRVAL;
    PRUEBAS_MESAS.actualizar('PRUEBA 2 - Actualizacion', idMesa, 0, 8, TRUE);
    PRUEBAS_MESAS.eliminar('PRUEBA 3 - Eliminacion', idMesa, TRUE);
END;
/

/* Paquete de la tabla Cartas */
/* Cabecera */
CREATE OR REPLACE 
PACKAGE PRUEBAS_CARTAS AS

    PROCEDURE inicializar;
    PROCEDURE insertar
    (nombre_prueba VARCHAR2, temporadaP DATE, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
    (nombre_prueba VARCHAR2, idCartaP SMALLINT, temporadaP DATE, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
    (nombre_prueba VARCHAR2, idCartaP SMALLINT, salidaEsperada BOOLEAN);
    
END PRUEBAS_CARTAS;
/

/* Body */
CREATE OR REPLACE 
PACKAGE BODY PRUEBAS_CARTAS AS

    /* Inicializacion */
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM Cartas;
    END inicializar;

    /* Insercion */
    PROCEDURE insertar (nombre_prueba VARCHAR2, temporadaP DATE, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        carta Cartas%ROWTYPE;
        idCartaP SMALLINT;
    BEGIN
        /* Insertar carta */
        INSERT INTO Cartas (temporada) VALUES (temporadaP);
        /* Seleccionar carta y comprobar que los datos se insertaron correctamente */
        idCartaP := sec_cartas.CURRVAL;
        SELECT * INTO carta FROM Cartas WHERE idCarta = idCartaP;
        IF (carta.temporada <> temporadaP) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;

    END insertar;

    /* Actualizacion */
    PROCEDURE actualizar (nombre_prueba VARCHAR2, idCartaP SMALLINT, temporadaP DATE, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        carta Cartas%ROWTYPE;
    BEGIN
        /* Actualizar carta */
        UPDATE Cartas SET temporada = temporadaP WHERE idCarta = idCartaP;
        
        /* Seleccionar carta y comprobar que los datos se actualizaron correctamente */
        SELECT * INTO carta FROM Cartas WHERE idCarta = idCartaP;
        IF (carta.temporada <> temporadaP) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;
            
    END actualizar;

    /* Eliminacion */
    PROCEDURE eliminar (nombre_prueba VARCHAR2, idCartaP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        numeroCarta INTEGER;
    BEGIN 
        /* Eliminar carta */
        DELETE FROM Cartas WHERE idCarta = idCartaP;
        /* Verificar que carta no se encuentra en la base de datos */
        SELECT COUNT(*) INTO numeroCarta FROM Cartas WHERE idCarta = idCartaP;
        IF (numeroCarta <> 0) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;
            
    END eliminar;

END PRUEBAS_CARTAS;
/

/* Prueba del paquete Cartas */
/* SET SERVEROUTPUT DEBE ESTAR EN ON */
DECLARE 
    idCarta SMALLINT;
BEGIN
    PRUEBAS_CARTAS.inicializar;
    PRUEBAS_CARTAS.insertar('PRUEBA 1 - Insercion',TO_DATE('2021/01/06', 'yyyy/mm/dd'), TRUE);
    idCarta := sec_cartas.CURRVAL;
    PRUEBAS_CARTAS.actualizar('PRUEBA 2 - Actualizacion', idCarta,TO_DATE('2022/03/06', 'yyyy/mm/dd') , TRUE);
    PRUEBAS_CARTAS.eliminar('PRUEBA 3 - Eliminacion', idCarta, TRUE);
END;
/

/* Paquete de la tabla Productos */
/* Cabecera */
CREATE OR REPLACE 
PACKAGE PRUEBAS_PRODUCTOS AS

    PROCEDURE inicializar;
    PROCEDURE insertar
    (nombre_prueba VARCHAR2, nombreP VARCHAR2, descripcionP VARCHAR2, tipoProductoP VARCHAR2, disponibilidadP SMALLINT, 
    precioProductoP FLOAT, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
    (nombre_prueba VARCHAR2, idProductoP SMALLINT, nombreP VARCHAR2, descripcionP VARCHAR2, tipoProductoP VARCHAR2,
    disponibilidadP SMALLINT, precioProductoP FLOAT, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
    (nombre_prueba VARCHAR2, idProductoP SMALLINT, salidaEsperada BOOLEAN);
    
END PRUEBAS_PRODUCTOS;
/

/* Body */
CREATE OR REPLACE 
PACKAGE BODY PRUEBAS_PRODUCTOS AS

    /* Inicializacion */
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM Productos;
    END inicializar;
    
    /* Insercion */
    PROCEDURE insertar (nombre_prueba VARCHAR2, nombreP VARCHAR2, descripcionP VARCHAR2, tipoProductoP VARCHAR2,
    disponibilidadP SMALLINT, precioProductoP FLOAT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        producto Productos%ROWTYPE;
        idProductoP SMALLINT;
    BEGIN
        /* Insertar producto */
        INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto)
        VALUES (nombreP, descripcionP, tipoProductoP, disponibilidadP, precioProductoP);
        
        /* Seleccionar producto y comprobar que los datos se insertaron correctamente */
        idProductoP := sec_productos.CURRVAL;
        SELECT * INTO producto FROM Productos WHERE idProducto = idProductoP;
        IF (producto.nombre <> nombreP AND producto.descripcion <> descripcionP AND producto.tipoProducto <> tipoProductoP 
        AND producto.disponibilidad <> disponibilidadP AND producto.precioProducto <> precioProductoP) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;

    END insertar;
        
    /* Actualizacion */
    PROCEDURE actualizar (nombre_prueba VARCHAR2,idProductoP SMALLINT, nombreP VARCHAR2, descripcionP VARCHAR2, tipoProductoP VARCHAR2, 
    disponibilidadP SMALLINT, precioProductoP FLOAT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        producto Productos%ROWTYPE;
    BEGIN
        /* Actualizar producto */
        UPDATE Productos SET nombre = nombreP, descripcion = descripcionP, tipoProducto = tipoProductoP, 
        disponibilidad = disponibilidadP, precioProducto = precioProductoP WHERE idProducto = idProductoP;
        
        /* Seleccionar producto y comprobar que los datos se actualizaron correctamente */
        SELECT * INTO producto FROM Productos WHERE idProducto = idProductoP;
        IF (producto.nombre <> nombreP AND producto.descripcion <> descripcionP AND producto.tipoProducto <> tipoProductoP 
        AND producto.disponibilidad <> disponibilidadP AND producto.precioProducto <> precioProductoP) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;
            
    END actualizar;

    /* Eliminación */
    PROCEDURE eliminar (nombre_prueba VARCHAR2, idProductoP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        numeroProducto INTEGER;
    BEGIN 
        /* Eliminar producto */
        DELETE FROM Productos WHERE idProducto = idProductoP;
        
        /* Verificar que producto no se encuentra en la base de datos */
        SELECT COUNT(*) INTO numeroProducto FROM Productos WHERE idProducto = idProductoP;
        IF (numeroProducto <> 0) THEN
            salida := FALSE;
        END IF;
        COMMIT WORK;
        
        /* Mostrar resultados de la prueba */
        DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(salida, salidaEsperada));
        EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(nombre_prueba || ':' || ASSERT_EQUALS(FALSE, salidaEsperada));
            ROLLBACK;
            
    END eliminar;
    
END PRUEBAS_PRODUCTOS;

/* Prueba del paquete Productos */
/* SET SERVEROUTPUT DEBE ESTAR EN ON */
DECLARE 
    idProducto SMALLINT;
BEGIN
    PRUEBAS_PRODUCTOS.inicializar;
    PRUEBAS_PRODUCTOS.insertar('PRUEBA 1 - Insercion','Jamon', 'Pata Negra', 'CARNE', 1, 10, TRUE);
    idProducto := sec_productos.CURRVAL;
    PRUEBAS_PRODUCTOS.actualizar('PRUEBA 2 - Actualizacion', idProducto, 'Jamon', 'Pata Blanca', 'CARNE', 1, 6, TRUE);
    PRUEBAS_PRODUCTOS.eliminar('PRUEBA 3 - Eliminacion', idProducto, TRUE);
END;

BEGIN
    PRUEBAS_PRODUCTOS.inicializar;
END;

/* Consultas asociadas al proyecto de IISSI2 */
SELECT idMesa FROM Mesas WHERE (disponible = 1 AND capacidad >= 5) ORDER BY capacidad;
