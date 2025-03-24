
--creacion de base de datos
Create Database FastFood_DB;

--posicionarse en la base de datos
use FastFood_DB;

--creacion de tablas

create table Ordenes(
    OrdenID int primary key IDENTITY,
    ClienteID int,
    EmpleadoID int,
    SucursalID int,
    MensajeroID int,
    TipoPagoID int,
    OrigenID int,
    HorarioVenta VARCHAR(50),
    TotalCompra DECIMAL(10,2) not null,
    KilometrosRecorrer DECIMAL(10,2),
    FechaDespacho DATETIME,
    FechaEntrega DATETIME,
    FechaOrdenTomada DATETIME,
    FechaOrdenLista DATETIME
);

create table Clientes(
    ClienteID int PRIMARY KEY IDENTITY,
    Nombre VARCHAR(255)not null,
    Direccion VARCHAR(255)
);

create table Productos(
    ProductoID int PRIMARY key IDENTITY,
    Nombre VARCHAR(255) not null,
    CategoriaID int,
    Precio DECIMAL(10,2)
);

Create table Categorias(
    CategoriaID int PRIMARY KEY IDENTITY,
    Nombre Varchar(255) not NULL
);

Create table DetalleOrdenes(
    OrdenID INT,
    ProductoID INT,
    Cantidad int,
    Precio DECIMAL(10,2),
    PRIMARY KEY(OrdenID,ProductoID)
);

create table Sucursales(
    SucursalID int PRIMARY KEY IDENTITY,
    Nombre Varchar(255) not null,
    direccion VARCHAR(255) NOT NULL
);

CREATE TABLE TiposPago(
    TipoPagoID int PRIMARY KEY IDENTITY,
    Descripcion varchar(255) not NULL
);

CREATE TABLE Empleados(
    EmpleadoID int PRIMARY KEY IDENTITY,
    Nombre VARCHAR(255) NOT NULL,
    Posicion VARCHAR(255),
    Departamento VARCHAR(255),
    SucursalID INT,
    Rol VARCHAR(255) 
);

CREATE TABLE Mensajeros(
    MensajeroID int PRIMARY KEY IDENTITY,
    Nombre varchar(255) NOT NULL,
    EsExterno BIT NOT NULL
);

CREATE TABLE OrigenesOrden(
    OrigenID INT PRIMARY KEY IDENTITY,
    Descripcion VARCHAR(255) not null
);

--Generar relaciones entre tablas

ALTER TABLE Productos
ADD CONSTRAINT FK_Productos_Categorias 
FOREIGN KEY(CategoriaID) REFERENCES Categorias(CategoriaID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Clientes
FOREIGN KEY(ClienteID) REFERENCES Clientes(ClienteID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Empleados
FOREIGN KEY(EmpleadoID) REFERENCES Empleados(EmpleadoID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Sucursal
FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Mensajeros
FOREIGN KEY(MensajeroID) REFERENCES Mensajeros(MensajeroID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_TiposPago
FOREIGN KEY(TipoPagoID) REFERENCES TiposPago(TipoPagoID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_OrigenesOrden
FOREIGN KEY(OrigenID) REFERENCES OrigenesOrden(OrigenID);

ALTER TABLE DetalleOrdenes
ADD CONSTRAINT FK_DetalleOrdenes_Ordenes
FOREIGN KEY(OrdenID) REFERENCES Ordenes(OrdenID);

ALTER TABLE DetalleOrdenes
ADD CONSTRAINT FK_DetalleOrdenes_Productos
FOREIGN KEY(ProductoID) REFERENCES Productos(ProductoID);