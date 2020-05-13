-------- RESTAURANTE CASA SALVI --------
/*

 Carga de datos de prueba. 

*/

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
EXECUTE insertProductoMenu('Macarrones', 9, 'PRIMERPLATO', 1, null);
EXECUTE insertProductoMenu('Pechuga de Pollo', 5, 'SEGUNDOPLATO', 2, null);
EXECUTE insertProductoMenu('Mousse de Chocolate', 4, 'POSTRE', 3, null);
EXECUTE insertProductoMenu('Estrella Galicia', 1, 'BEBIDA', 4, null); 

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
