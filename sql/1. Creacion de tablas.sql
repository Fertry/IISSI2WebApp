-------- RESTAURANTE CASA SALVI --------
/*

 Creación de las tablas necesarias. 

*/

-------- CREACIÓN DE TABLAS ----------- 
CREATE TABLE Cartas (     
    idCarta SMALLINT PRIMARY KEY,   
    temporada DATE NOT NULL
);

CREATE TABLE Productos (     
    idProducto SMALLINT PRIMARY KEY,     
    nombre VARCHAR2(100) NOT NULL, 
    descripcion VARCHAR2(200),     
    tipoProducto VARCHAR2(100), 
    disponibilidad SMALLINT,     
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
    nombre VARCHAR2(50) NOT NULL,
    precio FLOAT NOT NULL,
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
