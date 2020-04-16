-------- 3 ENTREGABLE IISSI 1 - RESTAURANTE SEVILLA --------

/* 
    · Master.sql contiene todo el código del proyecto.
    · Borrado.sql contiene el borrado de tablas, secuencias, procedimientos, etc.
    · Creacion_y_Poblado_de_Tablas.sql contiene la creación y poblado de todas las tablas así como la creación de las secuencias.
    · Triggers.sql contiene la creación de todos los triggers y la prueba de los mismos.
    · Consultas_Funciones_y_Cursores.sql contiene la creación y prueba de las consultas, cursores y funciones asociados a requisitos funcionales.
    · Pruebas_Automaticas.sql Contiene las pruebas automáticas de las tablas.
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
    nombre VARCHAR2(50),
    apellidos VARCHAR2(50),
    telefono VARCHAR2(15) CHECK (LENGTH (telefono) = 9),
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

/* Prueba del trigger 1 */
EXECUTE insertReservas(TO_DATE('2019-12-11-09:46', 'YYYY-MM-DD-hh24:mi'), 4, 1, 1);
EXECUTE insertReservas(TO_DATE('2019-12-11-09:46', 'YYYY-MM-DD-hh24:mi'), 5, 1, 1);

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

/* Prueba del trigger 2 */
EXECUTE insertReservas(TO_DATE('2019-12-11-09:46', 'YYYY-MM-DD-hh24:mi'), 4, 1, 1);
EXECUTE insertReservas(TO_DATE('2019-12-11-09:46', 'YYYY-MM-DD-hh24:mi'), 4, 2, 1);

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

/* Prueba del trigger 3 */
EXECUTE insertReservas(TO_DATE('2019-12-11-14:00', 'YYYY-MM-DD-hh24:mi'), 4, 7, 1);
EXECUTE insertReservas(TO_DATE('2019-12-11-22:00', 'YYYY-MM-DD-hh24:mi'), 4, 7, 1);

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

/* Prueba del trigger 4 */
EXECUTE insertProductoMenu ('Bebida', 4, 2);

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
(idProductoMenuP IN SMALLINT, tipoPlatoP IN VARCHAR2, idProductoP IN SMALLINT, idMenuP IN SMALLINT) AS
BEGIN
UPDATE ProductoMenu SET tipoPlato = tipoPlatoP, idProducto = idProductoP, idMenu = idMenuP WHERE idProductoMenu = idProductoMenuP;
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
EXECUTE insertProductos('Macarrones', 'Macarrones con tomate', 'PRIMERPLATO', 1, 9);
EXECUTE insertProductos('Pechuga de Pollo', 'Pechuga de pollo a la carbonara', 'SEGUNDOPLATO', 1, 5);
EXECUTE insertProductos('Mousse de Chocolate', 'Mousse de Chocolate', 'POSTRE', 1, 4);
EXECUTE insertProductos('Estrella Galicia', 'Cerveza', 'BEBIDA', 1, 1);
EXECUTE insertProductos('Cruzcampo', 'Cerveza', 'BEBIDA', 1, 1);
EXECUTE insertProductos('Filete secreto', 'Filete de secreto', 'PRIMERPLATO', 1, 8);
EXECUTE insertProductos('Flan', 'Flan de huevo', 'POSTRE', 1, 1);
EXECUTE insertProductos('Coca-Cola', 'Coca-Cola', 'BEBIDA', 1, 1);
EXECUTE insertProductos('Agua', 'Agua mineral', 'BEBIDA', 1, 1);
EXECUTE insertProductos('Ensalada cesar', 'Ensalada mixta', 'SEGUNDOPLATO', 1, 4);
EXECUTE insertProductos('Merluza', 'Pescado raro', 'PRIMERPLATO', 1, 6);
EXECUTE insertProductos('Brocheta verdura', 'Verdura a la plancha', 'SEGUNDOPLATO', 1, 3);
EXECUTE insertProductos('Nestea', 'Bebida azucarada', 'BEBIDA', 0, 1);
EXECUTE insertProductos('Filete ternera', 'Carne ternera', 'PRIMERPLATO', 1, 6);
EXECUTE insertProductos('Salmon', 'Pescado', 'PRIMERPLATO', 1, 4);
EXECUTE insertProductos('Sopa verduras', 'Sopa', 'SEGUNDOPLATO', 1, 4);
/* Mediante INSERTS: */
/*
INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES ('Macarrones', 'Macarrones con tomate', 'PRIMERPLATO', 1, 9);
INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES ('Pechuga de pollo', 'Pechuga de pollo a la carbonara', 'SEGUNDOPLATO', 1, 5);
INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES ('Mousse de Chocolate', 'Mousse de chocolate', POSTRE, 1, 4);
INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES ('Estrella Galicia', 'Cerveza', 'BEBIDA', 1, 1);
INSERT INTO Productos (nombre, descripcion, tipoProducto, disponibilidad, precioProducto) VALUES ('Cruzcampo', 'Cerveza', 'BEBIDA', 0, 1);
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
EXECUTE insertUsuarios('MAITRE', 'Miguel', 'Carrasco', '673334582', null, null, null);
/*
EXECUTE insertUsuarios('CLIENTE', 'David', 'Fernandez', '756345987', null);
EXECUTE insertUsuarios('CLIENTE', 'María', 'Triguero', '683450986', null);
EXECUTE insertUsuarios('CLIENTE', 'Ana', 'Gonzalez', '351789054', null);
*/
/* Mediante INSERTS: */
/*
INSERT INTO Usuarios (clase, nombre, apellidos, telefono, carta) VALUES ('GERENTE', 'Jose Manuel', 'Torres', '987567521', 1);
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
EXECUTE insertMesas(1, 10);
EXECUTE insertMesas(1, 10);
EXECUTE insertMesas(1, 4);
EXECUTE insertMesas(1, 4);
EXECUTE insertMesas(1, 4);

/* Mediante INSERTS: */
/*
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 4);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 4);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 6);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 8);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 10);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 12);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 8);
INSERT INTO Mesas (disponible, capacidad) VALUES (1, 8);
*/

/* Datos de Reservas */
/* Mediante procedimientos: */
/*
EXECUTE insertReservas(TO_DATE('2020/01/11-13','yyyy/mm/dd-HH24'), 4, 1, 3);
EXECUTE insertReservas(TO_DATE('2020/01/11-13','yyyy/mm/dd-HH24'), 4, 2, 4);
EXECUTE insertReservas(TO_DATE('2020/01/08-20','yyyy/mm/dd-HH24'), 4, 3, 5);
EXECUTE insertReservas(TO_DATE('2020/01/09-14','yyyy/mm/dd-HH24'), 6, 4, 3);
EXECUTE insertReservas(TO_DATE('2020/02/16-15','yyyy/mm/dd-HH24'), 6, 5, 4);
EXECUTE insertReservas(TO_DATE('2020/02/20-21','yyyy/mm/dd-HH24'), 8, 6, 5);
*/

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

/* RF1 - Listado de reservas asociado a usuarios */
/* En forma de cursor */
CREATE OR REPLACE PROCEDURE cursorRF1 IS
BEGIN
    DECLARE
        CURSOR cUno IS
        SELECT * FROM Reservas R, Usuarios U WHERE R.usuario = U.idUsuario; 
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Listado de reservas asociado a usuarios:'); 
            FOR fila IN cUno LOOP
                DBMS_OUTPUT.PUT_LINE('Id:'||fila.idReserva||' '||'Fecha:'||fila.fecha||' '||'NumPersonas:'||fila.numPersonas||' '||'Mesa:'||fila.mesa||' '||'Usuario:'||fila.nombre||','||fila.clase) ; 
            END LOOP;
    END;
END cursorRF1;
/

/* Prueba de RF1 */
EXECUTE cursorRF1;

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

/* RF6 - Listado de reservas por antigüedad */
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

/* RF7 - Listado de productos ordenados alfabéticamente */
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

/* RF8 - Listado de comandas por fecha */
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
/* RF9 - Detalles de usuario con id */
/* Pasas una id de usuario y devuelve el nombre del usuario */
CREATE OR REPLACE FUNCTION obtenerNombreConId (idu Usuarios.idUsuario%TYPE)
RETURN VARCHAR2 IS nombreU Usuarios.nombre%TYPE;
BEGIN
    SELECT DISTINCT nombre INTO nombreU FROM Usuarios WHERE idUsuario = idu;
RETURN (nombreU);
END obtenerNombreConId;
/

/* RF10 - Comandas por fecha */
/* Pasas una fecha y devuelve la suma de todas las comandas para esa fecha */
CREATE OR REPLACE FUNCTION obtenerComandasPorFecha (fechaIntroducida IN Comandas.fecha%TYPE)
RETURN FLOAT IS 
total Comandas.importe%TYPE;
BEGIN
    SELECT SUM(importe) INTO total FROM Comandas WHERE (TO_CHAR(fecha, 'yyyy/mm/dd') = TO_CHAR(fechaIntroducida, 'yyyy/mm/dd'));
RETURN (total);
END obtenerComandasPorFecha;
/

/* RF11 - Capacidad de las mesas por id */
/* Pasas el id de una mesa y devuelve la capacidad máxima de dicha mesa  */
CREATE OR REPLACE FUNCTION obtenerCapacidadConId (idm Mesas.idMesa%TYPE)
RETURN VARCHAR2 IS capacidadM Mesas.capacidad%TYPE;
BEGIN
    SELECT DISTINCT capacidad INTO capacidadM FROM Mesas WHERE idMesa = idm;
RETURN (capacidadM);
END obtenerCapacidadConId;
/

/* RF12 - Descripción de alergenos por nombre */
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
ALTER TRIGGER TR_producto_disponible DISABLE;
/* ATENCIÓN: DESACTIVAR TRIGGER PRODUCTO_DISPONIBLE PARA EJECUTAR LA PRUEBA */
DECLARE 
    idProducto SMALLINT;
BEGIN
    PRUEBAS_PRODUCTOS.inicializar;
    PRUEBAS_PRODUCTOS.insertar('PRUEBA 1 - Insercion','Jamon', 'Pata Negra', 'CARNE', 1, 10, TRUE);
    idProducto := sec_productos.CURRVAL;
    PRUEBAS_PRODUCTOS.actualizar('PRUEBA 2 - Actualizacion', idProducto, 'Jamon', 'Pata Blanca', 'CARNE', 1, 6, TRUE);
    PRUEBAS_PRODUCTOS.eliminar('PRUEBA 3 - Eliminacion', idProducto, TRUE);
END;

/* Paquete de la tabla Comandas */
/* Cabecera */
CREATE OR REPLACE 
PACKAGE PRUEBAS_COMANDAS AS

    PROCEDURE inicializar;
    PROCEDURE insertar
    (nombre_prueba VARCHAR2, fechaP DATE, importeP FLOAT, usuarioP SMALLINT, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
    (nombre_prueba VARCHAR2, idComandaP SMALLINT, fechaP DATE, importeP FLOAT, usuarioP SMALLINT, salidaEsperada BOOLEAN);
    PROCEDURE eliminar
    (nombre_prueba VARCHAR2, idComandaP SMALLINT, salidaEsperada BOOLEAN);
    
END PRUEBAS_COMANDAS;
/

/* Body */
CREATE OR REPLACE 
PACKAGE BODY PRUEBAS_COMANDAS AS

    /* Inicializacion */
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM Comandas;
    END inicializar;
    
    /* Insercion */
    PROCEDURE insertar (nombre_prueba VARCHAR2, fechaP DATE, importeP FLOAT, usuarioP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        comanda Comandas%ROWTYPE;
        idComandaP SMALLINT;
    BEGIN
        /* Insertar comanda */
        INSERT INTO Comandas (fecha, importe, usuario)
        VALUES (fechaP, importeP, usuarioP);
        
        /* Seleccionar comanda y comprobar que los datos se insertaron correctamente */
        idComandaP := sec_comandas.CURRVAL;
        SELECT * INTO comanda FROM Comandas WHERE idComanda = idComandaP;
        IF (comanda.fecha <> fechaP AND comanda.importe <> importeP AND comanda.usuario <> usuarioP) THEN
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
    PROCEDURE actualizar (nombre_prueba VARCHAR2,idComandaP SMALLINT, fechaP DATE, importeP FLOAT, usuarioP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        comanda Comandas%ROWTYPE;
    BEGIN
        /* Actualizar comanda */
        UPDATE Comandas SET fecha = fechaP, importe = importeP, usuario = usuarioP WHERE idComanda = idComandaP;
        
        /* Seleccionar comanda y comprobar que los datos se actualizaron correctamente */
        SELECT * INTO comanda FROM Comandas WHERE idComanda = idComandaP;
        IF (comanda.fecha <> fechaP AND comanda.importe <> importeP AND comanda.usuario <> usuarioP) THEN
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
    PROCEDURE eliminar (nombre_prueba VARCHAR2, idComandaP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        numeroComanda INTEGER;
    BEGIN 
        /* Eliminar comanda */
        DELETE FROM Comandas WHERE idComanda = idComandaP;
        
        /* Verificar que comanda no se encuentra en la base de datos */
        SELECT COUNT(*) INTO numeroComanda FROM Comandas WHERE idComanda = idComandaP;
        IF (numeroComanda <> 0) THEN
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
    
END PRUEBAS_COMANDAS;

/* Prueba del paquete Comandas */
/* SET SERVEROUTPUT DEBE ESTAR EN ON */
DECLARE 
    idComanda SMALLINT;
BEGIN
    PRUEBAS_COMANDAS.inicializar;
    PRUEBAS_COMANDAS.insertar('PRUEBA 1 - Insercion', TO_DATE('2020/05/13', 'yyyy/mm/dd'), 15, 2, TRUE);
    idComanda := sec_comandas.CURRVAL;
    PRUEBAS_COMANDAS.actualizar('PRUEBA 2 - Actualizacion', idComanda, TO_DATE('2020/05/13', 'yyyy/mm/dd'), 20, 2, TRUE);
    PRUEBAS_COMANDAS.eliminar('PRUEBA 3 - Eliminacion', idComanda, TRUE);
END;

/* Paquete de la tabla Menús */
/* Cabecera */
CREATE OR REPLACE 
PACKAGE PRUEBAS_MENUS AS

    PROCEDURE inicializar;
    PROCEDURE insertar
    (nombre_prueba VARCHAR2, precioP FLOAT, cartaP SMALLINT, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
    (nombre_prueba VARCHAR2, idMenuP SMALLINT, precioP FLOAT, cartaP SMALLINT,salidaEsperada BOOLEAN);
    PROCEDURE eliminar
    (nombre_prueba VARCHAR2, idMenuP SMALLINT, salidaEsperada BOOLEAN);
    
END PRUEBAS_MENUS;
/

/* Body */
CREATE OR REPLACE 
PACKAGE BODY PRUEBAS_MENUS AS

    /* Inicializacion */
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM Menus;
    END inicializar;
    
    /* Insercion */
    PROCEDURE insertar (nombre_prueba VARCHAR2, precioP FLOAT, cartaP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        menu Menus%ROWTYPE;
        idMenuP SMALLINT;
    BEGIN
        /* Insertar menu */
        INSERT INTO Menus (precio, carta) VALUES (precioP, cartaP);
        
        /* Seleccionar menu y comprobar que los datos se insertaron correctamente */
        idMenuP := sec_menus.CURRVAL;
        SELECT * INTO menu FROM Menus WHERE idMenu = idMenuP;
        IF (menu.precio <> precioP AND menu.carta <> cartaP) THEN
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
    PROCEDURE actualizar (nombre_prueba VARCHAR2, idMenuP SMALLINT, precioP FLOAT, cartaP SMALLINT,salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        menu Menus%ROWTYPE;
    BEGIN
        /* Actualizar menu */
        UPDATE Menus SET precio = precioP, carta = cartaP WHERE idMenu = idMenuP;
        
        /* Seleccionar menu y comprobar que los datos se actualizaron correctamente */
        SELECT * INTO menu FROM Menus WHERE idMenu = idMenuP;
        IF (menu.precio <> precioP AND menu.carta <> cartaP) THEN
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
    PROCEDURE eliminar (nombre_prueba VARCHAR2, idMenuP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        numeroMenu INTEGER;
    BEGIN 
        /* Eliminar menu */
        DELETE FROM Menus WHERE idMenu = idMenuP;
        
        /* Verificar que menu no se encuentra en la base de datos */
        SELECT COUNT(*) INTO numeroMenu FROM Menus WHERE idMenu = idMenuP;
        IF (numeroMenu <> 0) THEN
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
    
END PRUEBAS_MENUS;

/* Prueba del paquete Menus */
/* SET SERVEROUTPUT DEBE ESTAR EN ON */
DECLARE 
    idMenu SMALLINT;
BEGIN
    PRUEBAS_MENUS.inicializar;
    PRUEBAS_MENUS.insertar('PRUEBA 1 - Insercion', 20, null, TRUE);
    idMenu := sec_menus.CURRVAL;
    PRUEBAS_MENUS.actualizar('PRUEBA 2 - Actualizacion', idMenu, 15, null, TRUE);
    PRUEBAS_MENUS.eliminar('PRUEBA 3 - Eliminacion', idMenu, TRUE);
END;

/* Paquete de la tabla ProductoCarta */
/* Cabecera */
CREATE OR REPLACE 
PACKAGE PRUEBAS_PRODUCTO_CARTA AS

    PROCEDURE inicializar;
    PROCEDURE insertar
    (nombre_prueba VARCHAR2, idCartaP SMALLINT, idProductoP SMALLINT, salidaEsperada BOOLEAN);
    PROCEDURE actualizar
    (nombre_prueba VARCHAR2, idProductoCartaP SMALLINT, idCartaP SMALLINT, idProductoP SMALLINT,salidaEsperada BOOLEAN);
    PROCEDURE eliminar
    (nombre_prueba VARCHAR2, idProductoCartaP SMALLINT, salidaEsperada BOOLEAN);
    
END PRUEBAS_PRODUCTO_CARTA;
/

/* Body */
CREATE OR REPLACE 
PACKAGE BODY PRUEBAS_PRODUCTO_CARTA AS

    /* Inicializacion */
    PROCEDURE inicializar AS
    BEGIN
        DELETE FROM ProductoCarta;
    END inicializar;
    
    /* Insercion */
    PROCEDURE insertar (nombre_prueba VARCHAR2, idCartaP SMALLINT, idProductoP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        producto_carta ProductoCarta%ROWTYPE;
        idProductoCartaP SMALLINT;
    BEGIN
        /* Insertar productoCarta */
        INSERT INTO ProductoCarta (idCarta, idProducto) VALUES (idCartaP, idProductoP);
        
        /* Seleccionar productoCarta y comprobar que los datos se insertaron correctamente */
        idProductoCartaP := sec_producto_carta.CURRVAL;
        SELECT * INTO producto_carta FROM ProductoCarta WHERE idProductoCarta = idProductoCartaP;
        IF (producto_carta.idCarta <> idCartaP AND producto_carta.idProducto <> idProductoP) THEN
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
    PROCEDURE actualizar (nombre_prueba VARCHAR2, idProductoCartaP SMALLINT, idCartaP SMALLINT, idProductoP SMALLINT,salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        producto_carta ProductoCarta%ROWTYPE;
    BEGIN
        /* Actualizar productoCarta */
        UPDATE ProductoCarta SET idCarta = idCartaP, idProducto = idProductoP WHERE idProductoCarta = idProductoCartaP;
        
        /* Seleccionar productoCarta y comprobar que los datos se actualizaron correctamente */
        SELECT * INTO producto_carta FROM ProductoCarta WHERE idProductoCarta = idProductoCartaP;
        IF (producto_carta.idCarta <> idCartaP AND producto_carta.idProducto <> idProductoP) THEN
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
    PROCEDURE eliminar (nombre_prueba VARCHAR2, idProductoCartaP SMALLINT, salidaEsperada BOOLEAN) AS
        salida BOOLEAN := TRUE;
        numeroProductoCarta INTEGER;
    BEGIN 
        /* Eliminar productoCarta */
        DELETE FROM ProductoCarta WHERE idProductoCarta = idProductoCartaP;
        
        /* Verificar que productoCarta no se encuentra en la base de datos */
        SELECT COUNT(*) INTO numeroProductoCarta FROM ProductoCarta WHERE idProductoCarta = idProductoCartaP;
        IF (numeroProductoCarta <> 0) THEN
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
    
END PRUEBAS_PRODUCTO_CARTA;

/* Prueba del paquete ProductoCarta */
/* SET SERVEROUTPUT DEBE ESTAR EN ON */
DECLARE 
    idProductoCarta SMALLINT;
BEGIN
    PRUEBAS_PRODUCTO_CARTA.inicializar;
    PRUEBAS_PRODUCTO_CARTA.insertar('PRUEBA 1 - Insercion', null, null, TRUE);
    idProductoCarta := sec_producto_carta.CURRVAL;
    PRUEBAS_PRODUCTO_CARTA.actualizar('PRUEBA 2 - Actualizacion', idProductoCarta, null, null, TRUE);
    PRUEBAS_PRODUCTO_CARTA.eliminar('PRUEBA 3 - Eliminacion', idProductoCarta, TRUE);
END;



/* Pruebas de IISSI 2*/
SELECT idMesa FROM Mesas WHERE (disponible = 1 AND capacidad >= 5) AND ROWNUM = 1 ORDER BY capacidad;

SELECT * FROM Usuarios WHERE (clase = 'GERENTE');
SELECT usuario FROM Usuarios WHERE (clase = 'GERENTE');
SELECT nombre, telefono, fecha FROM Reservas;
DELETE Productos WHERE idProducto = 1;

