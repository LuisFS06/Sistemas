USE practica;
GO

-- Crear tabla de territorios

CREATE TABLE Territorio(
id_territorio INT NOT NULL IDENTITY(1,1) CONSTRAINT id_territorio PRIMARY KEY,
provincia char(40),
canton char(40),
distrito char(40)
)

-- Provincia de San Jose
INSERT INTO Territorio (Provincia, Canton, Distrito)
VALUES
    ('San Jose', 'San Jose', 'Uruca'),
    ('San Jose', 'Escazú', 'San Rafael'),
 

-- Provincia de Alajuela

    ('Alajuela', 'Alajuela', 'San Antonio'),
    ('Alajuela', 'Grecia', 'San Jose'),
 

-- Provincia de Cartago

    ('Cartago', 'Cartago', 'Carmen'),
    ('Cartago', 'La Unión', 'San Juan'),


-- Provincia de Heredia

    ('Heredia', 'Heredia', 'Heredia'),
    ('Heredia', 'Barva', 'San Roque'),


-- Provincia de Guanacaste

    ('Guanacaste', 'Liberia', 'Mayorga'),
    ('Guanacaste', 'Nicoya', 'Nosara'),


-- Provincia de Puntarenas

    ('Puntarenas', 'Puntarenas', 'El Roble'),
    ('Puntarenas', 'Esparza', 'Espíritu Santo'),


-- Provincia de Limon

    ('Limon', 'Limón', 'Matama'),
    ('Limon', 'Talamanca', 'Cahuita');

-- Crear Tabla de proveedores

CREATE TABLE Proveedor(
cedula INT NOT NULL   CHECK (cedula >= 0) CONSTRAINT id_proveedor PRIMARY KEY,
tipoced CHAR(40) NOT NULL CHECK (tipoced IN ('juridica', 'fisica')),
nombre CHAR(40) NOT NULL,
correo CHAR(40) NOT NULL,
telefono INT NOT NULL,
id_territorio INT NOT NULL,
    FOREIGN KEY (id_territorio) REFERENCES Territorio(id_territorio)
)

-- Insertar registros a la tabla

INSERT INTO Proveedor (cedula, tipoced, nombre, correo, telefono, id_territorio)
VALUES
    (123456789, 'juridica', 'Proveedor 1', 'proveedor1@example.com', 12345678, 1),
    (987654320, 'fisica', 'Proveedor 2', 'proveedor2@example.com', 87654321, 2),
    (555555555, 'juridica', 'Proveedor 3', 'proveedor3@example.com', 55555555, 3),
    (999999999, 'fisica', 'Proveedor 4', 'proveedor4@example.com', 99999999, 3),
    (888888888, 'fisica', 'Proveedor 5', 'proveedor5@example.com', 88888888, 8);

-- Tabla Intermedia territorio-proveedor

CREATE TABLE TerritorioProveedor (
    id_territorio_prov INT NOT NULL IDENTITY(1,1) CONSTRAINT pk_TerritorioProveedor PRIMARY KEY,
    territorio_id INT NOT NULL,
    proveedor_cedula INT NOT NULL,
    FOREIGN KEY (territorio_id) REFERENCES Territorio(id_territorio),
    FOREIGN KEY (proveedor_cedula) REFERENCES Proveedor(cedula)
);

-- Insertar registros a la tabla

-- Insertar registros en la tabla intermedia TerritorioProveedor
INSERT INTO TerritorioProveedor (territorio_id, proveedor_cedula)
VALUES
    (1, 123456789), 
    (2, 987654320), 
    (3, 555555555),
    (3, 999999999),
    (8, 888888888); 

-- Crear tabla de categorias


CREATE TABLE Categoria(
id_categoria INT NOT NULL IDENTITY (1,1) CONSTRAINT id_categoria PRIMARY KEY,
nombre CHAR(40) NOT NULL
)

-- Insertar registros a la tabla


INSERT INTO Categoria (nombre)
VALUES
('Bebidas Alcoholicas'),
('Refrescos'),
('Alimentos');

-- Crear tabla de subcategorias

CREATE TABLE Subcategoria(
id_subcategoria INT NOT NULL IDENTITY (1,1) CONSTRAINT id_subcategoria PRIMARY KEY,
nombre CHAR(40) NOT NULL,
id_categoria INT NOT NULL,
	FOREIGN KEY(id_categoria) REFERENCES Categoria(id_categoria)
)

-- Insertar registros a la tabla


INSERT INTO Subcategoria(nombre, id_categoria)
VALUES
('Cervezas',1),
('Vinos',1),
('BAS',1),
('Tes Frios',2),
('Gaseosas',2),
('Bebidas Energeticas',2),
('Frijoles',3),
('Salsas',3);


-- Crear tabla de clientes

CREATE TABLE Cliente(
cedulacl INT NOT NULL CHECK (cedulacl >=0) CONSTRAINT cedulac PRIMARY KEY,
tipocedu CHAR(10) NOT NULL CHECK (tipocedu IN ('juridica', 'fisica')),
nombre CHAR(40) NOT NULL, 
direccion CHAR(40) NOT NULL,
correo CHAR(40) NOT NULL
)

-- Insertar registros a la tabla


INSERT INTO Cliente (cedulacl, tipocedu, nombre, direccion, correo)
VALUES
    (111111111, 'juridica', 'Cliente 1', 'Dirección 1', 'cliente1@example.com'),
    (222222222, 'fisica', 'Cliente 2', 'Dirección 2', 'cliente2@example.com'),
    (333333333, 'juridica', 'Cliente 3', 'Dirección 3', 'cliente3@example.com'),
    (444444444, 'fisica', 'Cliente 4', 'Dirección 4', 'cliente4@example.com'),
    (555555555, 'fisica', 'Cliente 5', 'Dirección 5', 'cliente5@example.com');

-- Crear tabla de facturas

CREATE TABLE Factura(
numero_factura INT NOT NULL IDENTITY(1,1) CONSTRAINT numero_factura PRIMARY KEY,
cedulacl INT NOT NULL CHECK (cedulacl >=0) ,  
fecha DATE NOT NULL, 
precio_pact INT NOT NULL,
cantidad INT NOT NULL,
impuesto INT NOT NULL CHECK (impuesto >=0 AND impuesto <= 100) ,
descuento INT NOT NULL CHECK (descuento >=0 AND descuento <= 100) ,
    FOREIGN KEY (cedulacl) REFERENCES Cliente(cedulacl)
)

-- Insertar registros a la tabla


INSERT INTO Factura (cedulacl, fecha, precio_pact, cantidad, impuesto, descuento)
VALUES
    (111111111, '2023-09-12', 1000, 5, 13, 5),
    (222222222, '2023-07-11', 500, 2, 10, 2),
    (333333333, '2023-09-10', 750, 3, 15, 3),
    (444444444, '2023-09-09', 2000, 10, 20, 5),
    (555555555, '2023-06-08', 1500, 5, 12, 4);

-- Crear tabla de productos

CREATE TABLE Producto(
id_universal INT NOT NULL IDENTITY(1,1) CONSTRAINT id_prod PRIMARY KEY,
nombre CHAR(40) NOT NULL ,
precio INT NOT NULL CHECK (precio >= 0),
id_subcategoria INT NOT NULL CHECK (id_subcategoria >= 0),
tamano INTEGER  CHECK (tamano >= 0),
color CHAR(40) NOT NULL, 
cedula INT CHECK (cedula >=0),
    FOREIGN KEY (cedula) REFERENCES Proveedor(cedula),
	FOREIGN KEY (id_subcategoria) REFERENCES Subcategoria(id_subcategoria)
)

-- Insertar registros a la tabla

INSERT INTO Producto (nombre, precio, id_subcategoria, tamano, color, cedula)
VALUES
    ('Producto 1', 1000, 1, 250, 'Rojo', 123456789),
    ('Producto 2', 500, 2, 500, 'Azul', 987654320),
    ('Producto 3', 750, 3, 750, 'Verde', 555555555),
    ('Producto 4', 2000, 4, 1000, 'Amarillo', 999999999),
    ('Producto 5', 1500, 5, 300, 'Blanco', 987654320);


-- Crear tabla intermedia entre producto y factura


CREATE TABLE Productofactura(
id_productfac INT NOT NULL IDENTITY(1,1) CONSTRAINT id_productfac PRIMARY KEY,
numero_factura INT NOT NULL,
id_universal INT NOT NULL,
cantidad INT NOT NULL CHECK (cantidad >0), 
    FOREIGN KEY (numero_factura) REFERENCES Factura(numero_factura),
	FOREIGN KEY (id_universal) REFERENCES Producto(id_universal)
)

-- Insertar registros a la tabla

-- Factura 1
INSERT INTO ProductoFactura (numero_factura, id_universal, cantidad)
VALUES
    (1, 1, 2), -- Producto 1, cantidad 2
    (1, 2, 3); -- Producto 2, cantidad 3

-- Factura 2
INSERT INTO ProductoFactura (numero_factura, id_universal, cantidad)
VALUES
    (2, 3, 1), -- Producto 3, cantidad 1
    (2, 4, 5), -- Producto 4, cantidad 5
    (3, 5, 2); -- Producto 5, cantidad 2

