---SessionSport---
CREATE DATABASE SessionSportBD
GO

USE [SessionSportBD]
GO

---TABLAS

CREATE TABLE Marcas
(
CodMarca_Ma CHAR(6) NOT NULL,
Descripcion_Ma VARCHAR(30) NOT NULL,
CONSTRAINT PK_MARCAS PRIMARY KEY (CodMarca_Ma)
)
GO

CREATE TABLE Categorias
(
CodCategoria_Ca CHAR(6) NOT NULL,
Descripcion_Ca VARCHAR(30) NOT NULL,
CONSTRAINT PK_CATEGORIAS PRIMARY KEY (CodCategoria_Ca)
)
GO

CREATE TABLE Usuarios
(
DNI_Us CHAR(10) NOT NULL,
Usuario_Us VARCHAR(30) NOT NULL,
Contraseña_Us VARCHAR(30) NOT NULL,
Email_Us VARCHAR(60) NOT NULL,
Domicilio_Us VARCHAR(40) NOT NULL,
CodigoPostal_Us CHAR(4) NOT NULL,
Telefono_Us CHAR(10) NOT NULL,
Nombre_Us VARCHAR(30) NOT NULL,
Apellido_Us VARCHAR(30) NOT NULL,
FechaNac_Us DATE NOT NULL,
Estado_Us BIT NOT NULL DEFAULT 1,
Tipo_Us INT NOT NULL DEFAULT 1,
CONSTRAINT PK_USUARIOS PRIMARY KEY (DNI_Us),
CONSTRAINT UK_USUARIOS UNIQUE (Usuario_Us,Email_Us)
)
GO

CREATE TABLE Talles
(
CodTalle_Ta CHAR(6) NOT NULL,
Descripcion_Ta VARCHAR(30) NOT NULL,
CONSTRAINT PK_TALLES PRIMARY KEY (CodTalle_Ta),
CONSTRAINT UK_TALLES UNIQUE (Descripcion_Ta)
)
GO

CREATE TABLE Colores
(
CodColor_Co CHAR(6) NOT NULL,
Descripcion_Co VARCHAR(30) NOT NULL,
CONSTRAINT PK_COLORES PRIMARY KEY (CodColor_Co),
CONSTRAINT UK_COLORES UNIQUE (Descripcion_Co)
)
GO


CREATE TABLE Productos
(
CodProducto_Pr CHAR(6) NOT NULL,
CodMarca_Pr CHAR(6) NOT NULL,
CodCategoria_Pr CHAR(6) NOT NULL,
Descripcion_Pr VARCHAR(100) NOT NULL,
Nombre_Pr VARCHAR(20) NOT NULL,
UrlImagen_Pr VARCHAR(60) NOT NULL DEFAULT 'Imagenes\default.jpg',
PrecioUnitario_Pr DECIMAL(10,2) NOT NULL DEFAULT 0.00,
Estado_Pr BIT NOT NULL DEFAULT 1,
CONSTRAINT PK_PRODUCTOS PRIMARY KEY (CodProducto_Pr),
CONSTRAINT FK_PRODUCTOS_MARCAS FOREIGN KEY (CodMarca_Pr) REFERENCES Marcas (CodMarca_Ma),
CONSTRAINT FK_PRODUCTOS_CATEGORIAS FOREIGN KEY (CodCategoria_Pr) REFERENCES Categorias (CodCategoria_Ca)
)
GO

CREATE TABLE TallesXProductosXColores
(
CodProducto_TXPXC CHAR(6) NOT NULL,
CodTalle_TXPXC CHAR(6) NOT NULL,
CodColor_TXPXC CHAR(6) NOT NULL,
Stock_TXPXC INT NOT NULL DEFAULT 0,
CONSTRAINT PK_TALLESXPRODUCTOSXCOLORES PRIMARY KEY (CodProducto_TXPXC, CodTalle_TXPXC, CodColor_TXPXC),
CONSTRAINT FK_TALLESXPRODUCTOSXCOLORES_PRODUCTOS FOREIGN KEY (CodProducto_TXPXC) REFERENCES Productos (CodProducto_Pr),
CONSTRAINT FK_TALLESXPRODUCTOSXCOLORES_TALLES FOREIGN KEY (CodTalle_TXPXC) REFERENCES Talles(CodTalle_Ta),
CONSTRAINT FK_TALLESXPRODUCTOSXCOLORES_COLORES FOREIGN KEY (CodColor_TXPXC) REFERENCES Colores (CodColor_Co)
)
GO

CREATE TABLE MetodosEnvio
(
CodMetEnvio_En CHAR(6) NOT NULL,
Descripcion_En VARCHAR(30) NOT NULL,
CONSTRAINT PK_METODOSENVIO PRIMARY KEY (CodMetEnvio_En)
)
GO

CREATE TABLE MetodosPago
(
CodMetPago_Pa CHAR(6) NOT NULL,
Descripcion_Pa VARCHAR(30) NOT NULL,
CONSTRAINT PK_METODOSPAGO PRIMARY KEY (CodMetPago_Pa)
)
GO

CREATE TABLE Facturas
(
NroFactura_Fa INT NOT NULL IDENTITY (1,1),
DNI_Fa CHAR(10) NOT NULL,
CodMetEnvio_Fa CHAR(6) NOT NULL,
CodMetPago_Fa CHAR(6) NOT NULL,
Fecha_Fa DATE NOT NULL,
DireccionEntrega_Fa VARCHAR(40) NOT NULL,
Tarjeta_Fa VARCHAR(16) NULL DEFAULT 'S/T',
Pago_Fa BIT NOT NULL DEFAULT 0,
Total_Fa DECIMAL(8,2) NOT NULL DEFAULT 0,
CONSTRAINT PK_FACTURAS PRIMARY KEY (NroFactura_Fa),
CONSTRAINT FK_FACTURAS_USUARIOS FOREIGN KEY (Dni_Fa) REFERENCES Usuarios (DNI_Us),
CONSTRAINT FK_FACTURAS_METODOSENVIO FOREIGN KEY (CodMetEnvio_Fa) REFERENCES MetodosEnvio (CodMetEnvio_En),
CONSTRAINT FK_FACTURAS_METODOSPAGO FOREIGN KEY (CodMetPago_Fa) REFERENCES MetodosPago (CodMetPago_Pa),
)
GO

CREATE TABLE DetalleFacturas
(
NroFactura_Df INT NOT NULL,
CodProducto_Df CHAR(6) NOT NULL,
CodTalle_Df CHAR(6) NOT NULL,
CodColor_Df CHAR(6) NOT NULL,
PrecioUnitario_Df DECIMAL(8,2) NOT NULL,
Cantidad_Df INT NOT NULL,
CONSTRAINT PK_DETALLEVENTAS PRIMARY KEY (NroFactura_Df, CodProducto_Df, CodTalle_Df, CodColor_Df),
CONSTRAINT FK_DETALLEFACTURAS_FACTURAS FOREIGN KEY (NroFactura_Df) REFERENCES Facturas (NroFactura_Fa),
CONSTRAINT FK_DETALLEVENTAS_TALLESXPRODUCTOSXCOLORES FOREIGN KEY (CodProducto_Df, CodTalle_Df, CodColor_Df) 
REFERENCES TallesXProductosXColores (CodProducto_TXPXC, CodTalle_TXPXC, CodColor_TXPXC)
)
GO

---REGISTROS

INSERT INTO Marcas (CodMarca_Ma, Descripcion_Ma)
SELECT '1','Adidas' UNION
SELECT '2','Nike' UNION
SELECT '3','Puma' UNION
SELECT '4','Lacoste' UNION
SELECT '5','Reebok' UNION
SELECT '6','Topper'
GO

--//////////////////////////////////////////////////////////////

INSERT INTO Categorias (CodCategoria_Ca, Descripcion_Ca)
SELECT '1','Remera' UNION
SELECT '2','Calzado' UNION
SELECT '3','Buzo' UNION
SELECT '4','Pantalon' UNION
SELECT '5','Gorra' UNION
SELECT '6','Medias'
GO

--//////////////////////////////////////////////////////////////

INSERT INTO Talles(CodTalle_Ta, Descripcion_Ta)
SELECT 'XS','Extra Small' UNION
SELECT 'S','Small' UNION
SELECT 'M','Medium' UNION
SELECT 'L','Large' UNION
SELECT 'XL','Extra Large' UNION
SELECT 'XXL','Extra Extra Large' UNION
SELECT '39','39' UNION
SELECT '40','40' UNION
SELECT '41','41' UNION
SELECT '42','42' UNION
SELECT '43','43' UNION
SELECT '44','44' UNION
SELECT 'ST', 'Sin Talle'
GO

--//////////////////////////////////////////////////////////////

INSERT INTO Colores (CodColor_Co, Descripcion_Co)
SELECT '1','Blanco' UNION
SELECT '2','Negro' UNION
SELECT '3','Azul' UNION
SELECT '4','Verde' UNION
SELECT '5','Rojo' UNION
SELECT '6','Violeta' UNION
SELECT '7','Amarillo' UNION
SELECT '8','Rosa' UNION
SELECT '9','Gris' UNION
SELECT '10','Naranja' 
GO

--//////////////////////////////////////////////////////////////

INSERT INTO MetodosEnvio (CodMetEnvio_En, Descripcion_En)
SELECT '1','Retiro en sucursal' UNION
SELECT '2','A domicilio'
GO

--//////////////////////////////////////////////////////////////

INSERT INTO MetodosPago (CodMetPago_Pa, Descripcion_Pa)
SELECT '1','Efectivo' UNION
SELECT '2','Tarjeta'
GO

--//////////////////////////////////////////////////////////////

INSERT INTO Usuarios (DNI_Us,Usuario_Us,Contraseña_Us,Email_Us,Domicilio_Us,
CodigoPostal_Us,Telefono_Us,Nombre_Us,Apellido_Us,FechaNac_Us,Estado_Us,Tipo_Us)
SELECT '11111111','admin','admin','admin@admin.com','adminDom','1111','1111111111','Admin','Administrador','1111-01-01','1','2' UNION
SELECT '44298829','NicoPiana','1234','nico@hotmail.com','Monteagudo 1234','1640','1122223333','Nicolás','Piana','2002-02-02','1','1' UNION
SELECT '41234569','Albion','Former','Albion12@hotmail.com','Av. Maipu 3221','1623','1147217712','Carlos','Martínez','1989-03-23','1','1' UNION
SELECT '36912234','german55','coco6634','german55@gmail.com','Rivadavia 2286','1612','1166417221','Germán','Priano','1969-03-23','1','1' UNION
SELECT '43818699','lautiLomazzo','1234','lautiLomazzo@hotmail.com','Corrientes 3214','1669','1155471123','Lautaro','Lomazzo','2002-03-20','1','1' UNION
SELECT '43259884','elAlan','alanjaja','elAlan@hotmail.com','Bilbao 10361','1744','1148213712','Alan','Lewandowski','2001-03-17','1','1' UNION
SELECT '42300555','enzoCarp','aguanteriver','enzitoCarp@outlook.com','Tigre 7328','1321','1147244712','Enzo','Conde','2000-12-09','1','1' UNION
SELECT '41234567','leoSchiller','3456','Schiller@hotmail.com','Av. Libertador 3221','1623','1166517712','Leopoldo','Schiller','1997-07-22','1','1' UNION
SELECT '20506487','cariCuervo','7777','carina@hotmail.com','Yrigoyen 2331','1640','1117217712','Carina','Sampietro','1969-01-02','1','1' UNION
SELECT '26122315','angelitoCorrea','8171','laseleccion@hotmail.com','Yapeyú 7717','1640','1184217712','Ángel Gaspar','Lewandowskik','1978-03-24','1','1'
GO

--//////////////////////////////////////////////////////////////

INSERT INTO Productos (CodProducto_Pr,CodMarca_Pr,CodCategoria_Pr, Nombre_Pr, Descripcion_Pr, UrlImagen_Pr, PrecioUnitario_Pr, Estado_Pr)
SELECT '1', '2', '1', 'Remera Nike','Remera hombre marca Nike hecha en EE.UU tela de Nailon','Imagenes\1.jpg',3500.00,1 UNION
SELECT '2', '2', '1', 'Remera Nike Miller','Remera hombre marca Nike, tipica hecha en Dri-FIT', 'Imagenes\2.jpg',4300.00,1 UNION
SELECT '3', '1', '1', 'Remera Adidas Dep.','Remera mujer marca Adidas liviana', 'Imagenes\3.jpg',5800.00,1 UNION
SELECT '4', '6', '2', 'Zatillas Topper','Zapatillas Topper deportivas Air-max', 'Imagenes\4.jpg',12000.00,1 UNION
SELECT '5', '5', '2', 'Zapatillas Rebook','Zapatillas Rebook de cuero', 'Imagenes\5.jpg',16500.00,1 UNION
SELECT '6', '2', '2', 'Zapatillas Nike','Zapatillas Nike Airmax INTRLK Lite', 'Imagenes\6.jpg',20500.00,1 UNION
SELECT '7', '4', '3', 'Buzo Lacoste','Buzo Lacoste Medio cierre rustico', 'Imagenes\7.jpg',48000.00,1 UNION
SELECT '8', '3', '3', 'Buzo Puma','Buzo sudadera Puma Running', 'Imagenes\8.jpg',14999.99,1 UNION
SELECT '9', '1', '3', 'Buzo Adidas','Buzo Adidas Essentials', 'Imagenes\9.jpg',12999.99,1 UNION
SELECT '10', '2', '4', 'Pantalón Nike','Pantalón Nike Dry tipo Jogging', 'Imagenes\10.jpg',10624.00,1 UNION
SELECT '11', '3', '4', 'Pantalón Puma','Pantalón Puma tipo Jogging Evostripe', 'Imagenes\11.jpg',17999.99,1 UNION
SELECT '12', '1', '4', 'Pantalón Adidas','Pantalón Adidas Dry-Effect', 'Imagenes\12.jpg',12999.99,1 UNION
SELECT '13', '2', '5', 'Gorra Nike','Gorra Nike Dry-Fit', 'Imagenes\13.jpg',5500.00,1 UNION
SELECT '14', '2', '5', 'Gap Nike','Gorra Nike New Era', 'Imagenes\14.jpg',5500.00,1 UNION
SELECT '15', '4', '6', 'Medias Lacoste','Medias Lacoste tipo Soquete', 'Imagenes\15.jpg',4500.00,1
GO

--//////////////////////////////////////////////////////////////

INSERT INTO TallesXProductosXColores (CodProducto_TXPXC, CodTalle_TXPXC, CodColor_TXPXC, Stock_TXPXC)
SELECT '1', 'XS', '9', '20' UNION
SELECT '1', 'XS', '2', '20' UNION
SELECT '1', 'S', '9', '20' UNION
SELECT '1', 'S', '2', '20' UNION
SELECT '1', 'M', '9', '20' UNION
SELECT '1', 'M', '2', '20' UNION
SELECT '1', 'L', '9', '20' UNION
SELECT '2', 'S', '2', '20' UNION
SELECT '2', 'M', '2', '20' UNION
SELECT '2', 'L', '2', '20' UNION
SELECT '3', 'S', '5', '20' UNION
SELECT '3', 'M', '5', '20' UNION
SELECT '3', 'XL', '5', '20' UNION
SELECT '3', 'S', '3', '20' UNION
SELECT '3', 'M', '3', '20' UNION
SELECT '3', 'XL', '3', '20' UNION
SELECT '4', '39', '2', '20' UNION
SELECT '4', '42', '2', '20' UNION
SELECT '5', '39', '2', '20' UNION
SELECT '5', '40', '2', '20' UNION
SELECT '6', '41', '2', '20' UNION
SELECT '6', '43', '2', '20' UNION
SELECT '7', 'S', '3', '20' UNION
SELECT '7', 'M', '3', '20' UNION
SELECT '7', 'L', '3', '20' UNION
SELECT '7', 'S', '7', '20' UNION
SELECT '7', 'M', '7', '20' UNION
SELECT '7', 'L', '7', '20' UNION
SELECT '8', 'S', '2', '20' UNION
SELECT '8', 'M', '2', '20' UNION
SELECT '8', 'L', '2', '20' UNION
SELECT '9', 'S', '3', '20' UNION
SELECT '9', 'M', '3', '20' UNION
SELECT '9', 'L', '3', '20' UNION
SELECT '9', 'S', '10', '20' UNION
SELECT '9', 'M', '10', '20' UNION
SELECT '9', 'L', '10', '20' UNION
SELECT '9', 'S', '8', '20' UNION
SELECT '9', 'M', '8', '20' UNION
SELECT '9', 'L', '8', '20' UNION
SELECT '10', 'XS', '2', '20' UNION
SELECT '10', 'S', '2', '20' UNION
SELECT '10', 'M', '2', '20' UNION
SELECT '10', 'L', '2', '20' UNION
SELECT '11', 'XS', '9', '20' UNION
SELECT '11', 'S', '9', '20' UNION
SELECT '11', 'M', '9', '20' UNION
SELECT '11', 'L', '9', '20' UNION
SELECT '12', 'XS', '2', '20' UNION
SELECT '12', 'S', '2', '20' UNION
SELECT '12', 'M', '2', '20' UNION
SELECT '12', 'L', '2', '20' UNION
SELECT '13', 'ST', '3', '20' UNION   
SELECT '13', 'ST', '5', '20' UNION 
SELECT '13', 'ST', '6', '20' UNION   
SELECT '14', 'ST', '2', '20' UNION   
SELECT '15', 'ST', '2', '20' UNION   
SELECT '15', 'ST', '1', '20'
GO

--//////////////////////////////////////////////////////////////

SET IDENTITY_INSERT Facturas ON

INSERT INTO Facturas (NroFactura_Fa,DNI_Fa, CodMetEnvio_Fa, CodMetPago_Fa, Fecha_Fa, DireccionEntrega_Fa, Tarjeta_Fa, Pago_Fa, Total_Fa)
SELECT 1, '44298829', '1', '1', '2022-10-21', 'Retiro en Sucursal', 'S/T', 0, 9000.00 UNION
SELECT 2, '41234567', '1', '2', '2022-10-22', 'Retiro en Sucursal', '5061268341500995', 1, 26999.99 UNION
SELECT 3, '36912234', '2', '1', '2022-10-23', 'Rivadavia 2286', 'S/T', 0, 32548.00 UNION
SELECT 4, '41234567', '2', '1', '2022-10-23', 'Av. Maipu 3221', 'S/T', 0, 12999.99 UNION
SELECT 5, '43818699', '1', '2', '2022-10-23', 'Retiro en Sucursal', '4461334412127876', 1, 17999.99 UNION
SELECT 6, '43259884', '1', '1', '2022-10-23', 'Retiro en Sucursal', 'S/T', 0, 48000.00 UNION
SELECT 7, '42300555', '2', '2', '2022-10-23', 'Tigre 7328', '4422646512235156', 1, 7800.00 UNION
SELECT 8, '41234567', '2', '1', '2022-10-23', 'Av. Libertador 3221', 'S/T', 0, 12000.00 UNION
SELECT 9, '44298829', '1', '2', '2022-10-23', 'Retiro en Sucursal', '465544331122354', 1, 14800.00
GO

SET IDENTITY_INSERT Facturas OFF

INSERT INTO DetalleFacturas(NroFactura_Df,CodProducto_Df,CodTalle_Df,CodColor_Df,PrecioUnitario_Df,Cantidad_Df)
SELECT 1,'1', 'M', '9', 3500.00, 1 UNION
SELECT 1,'14', 'ST', '2',5500.00, 1 UNION
SELECT 2,'4', '42', '2', 12000.00, 1 UNION
SELECT 2,'8', 'M', '2', 14999.99, 1 UNION
SELECT 3, '10', 'S', '2', 10624.00, 2 UNION
SELECT 3, '3', 'M', '5', 5800.00, 1 UNION
SELECT 3, '13', 'ST', '6', 5500.00, 1 UNION
SELECT 4, '9', 'L', '8', 12999.99, 1 UNION
SELECT 5, '11', 'L', '9', 17999.99, 1 UNION
SELECT 6, '7', 'L', '7', 48000.00, 1 UNION
SELECT 7, '2', 'M', '2', 4300.00, 1 UNION
SELECT 7, '1', 'M', '9', 3500.00, 1 UNION
SELECT 8, '4', '39', '2', 12000.00, 1 UNION
SELECT 9, '3', 'S', '3', 5800.00, 1 UNION
SELECT 9, '15', 'ST', '1', 4500.00, 2 
GO
--//////////////////////////////////////////////////////////////


--CONSULTAS

--Trae el nombre, descripcion, codigo de talle, codigo de marca y stock de un producto determinado
SELECT Nombre_Pr,Descripcion_Pr,CodTalle_TXPXC,CodMarca_Pr,Stock_TXPXC
FROM TallesXProductosXColores INNER JOIN Productos ON CodProducto_Pr=CodProducto_TXPXC
WHERE CodProducto_TXPXC='1'
GO

--Trae la cantidad de productos vendidos
SELECT SUM(Cantidad_Df) AS [Total Productos Vendidos] 
FROM DetalleFacturas INNER JOIN Facturas ON NroFactura_Df = NroFactura_Fa 
GO

--Trae los usuarios que hayan hecho compras de mas de $15000
SELECT DISTINCT DNI_Us,Nombre_Us, Apellido_Us, Usuario_Us
FROM Usuarios INNER JOIN Facturas ON DNI_Us=DNI_Fa
WHERE Total_Fa>15000
GO



--PROCEDIMIENTOS ALMACENADOS

CREATE PROCEDURE SPEliminarUsuario
(
@DNI CHAR(10)
)
AS
UPDATE Usuarios SET Estado_Us=0
WHERE DNI_Us=@DNI
GO

CREATE PROCEDURE SPEliminarProducto
(
@CodProducto CHAR(6)
)
AS
UPDATE Productos SET Estado_Pr=0
WHERE CodProducto_Pr=@CodProducto
GO

--//////////////////////////////////////////////////////////////

CREATE PROCEDURE SPInsertarUsuario
(
@DNI CHAR(10),
@Usuario VARCHAR(30),
@Contraseña VARCHAR(30),
@Email VARCHAR(60),
@Domicilio VARCHAR(40),
@CodigoPostal CHAR(4),
@Telefono CHAR(10),
@Nombre VARCHAR(30),
@Apellido VARCHAR(30),
@FechaNac DATE
)
AS
INSERT INTO Usuarios (DNI_Us,Usuario_Us,Contraseña_Us,Email_Us,Domicilio_Us,CodigoPostal_Us,Telefono_Us,Nombre_Us,Apellido_Us,FechaNac_Us)
VALUES (@DNI,@Usuario,@Contraseña,@Email,@Domicilio,@CodigoPostal,@Telefono,@Nombre,@Apellido,@FechaNac)
GO

--//////////////////////////////////////////////////////////////

CREATE PROCEDURE SPInsertarProducto
(
@CodProducto CHAR(6),
@CodMarca CHAR(6),
@CodCategoria CHAR(6),
@Descripcion VARCHAR(100),
@Nombre VARCHAR(20),
@UrlImagen VARCHAR(60),
@PrecioUnitario DECIMAL(10,2)
)
AS
INSERT INTO Productos (CodProducto_Pr,CodMarca_Pr,CodCategoria_Pr,Descripcion_Pr,Nombre_Pr,UrlImagen_Pr,PrecioUnitario_Pr)
VALUES (@CodProducto,@CodMarca,@CodCategoria,@Descripcion,@Nombre,@UrlImagen,@PrecioUnitario)
GO

--//////////////////////////////////////////////////////////////

CREATE PROCEDURE SPInsertarStock
(
@CodProducto CHAR(6),
@CodTalle CHAR(6),
@CodColor CHAR(6),
@Stock INT
)
AS
INSERT INTO TallesXProductosXColores(CodProducto_TXPXC,CodTalle_TXPXC,CodColor_TXPXC,Stock_TXPXC)
VALUES (@CodProducto,@CodTalle,@CodColor,@Stock)
GO

--//////////////////////////////////////////////////////////////


CREATE PROCEDURE SPActualizarUsuario
(
@DNI CHAR(10),
@Usuario VARCHAR(30),
@Email VARCHAR(60),
@Domicilio VARCHAR(40),
@CodigoPostal CHAR(4),
@Telefono CHAR(10),
@Nombre VARCHAR(30),
@Apellido VARCHAR(30),
@FechaNac DATE,
@Contraseña VARCHAR(30),
@Tipo  INT,
@Estado BIT
)
AS
UPDATE Usuarios SET
DNI_Us=@DNI,
Usuario_Us=@Usuario,
Email_Us=@Email,
Domicilio_Us=@Domicilio,
CodigoPostal_Us=@CodigoPostal,
Telefono_Us=@Telefono,
Nombre_Us=@Nombre,
Apellido_Us=@Apellido,
FechaNac_Us=@FechaNac,
Contraseña_Us=@Contraseña,
Tipo_Us=@Tipo,
Estado_Us=@Estado
WHERE DNI_Us=@DNI
GO



--//////////////////////////////////////////////////////////////

CREATE PROCEDURE SPActualizarProducto
(
@CodProducto CHAR(6),
@CodMarca CHAR(6),
@CodCategoria CHAR(6),
@Descripcion VARCHAR(100),
@Nombre VARCHAR(20),
@UrlImagen VARCHAR(60),
@PrecioUnitario DECIMAL(10,2),
@Estado BIT
)
AS
UPDATE Productos SET
CodProducto_Pr=@CodProducto,
CodMarca_Pr=@CodMarca,
CodCategoria_Pr=@CodCategoria,
Descripcion_Pr=@Descripcion,
Nombre_Pr=@Nombre,
UrlImagen_Pr=@UrlImagen,
PrecioUnitario_Pr=@PrecioUnitario,
Estado_Pr=@Estado
WHERE CodProducto_Pr=@CodProducto
GO

--//////////////////////////////////////////////////////////////

CREATE PROCEDURE SPInsertarFactura
(
@DNI CHAR(10),
@CodMetEnvio CHAR(6),
@CodMetPago CHAR(6),
@Fecha DATE,
@DireccionEntrega VARCHAR(40),
@Tarjeta VARCHAR(16),
@Pago BIT
)
AS
INSERT INTO Facturas (DNI_Fa,CodMetEnvio_Fa,CodMetPago_Fa,Fecha_Fa,DireccionEntrega_Fa,Tarjeta_Fa,Pago_Fa)
VALUES(@DNI,@CodMetEnvio,@CodMetPago,@Fecha,@DireccionEntrega,@Tarjeta,@Pago)
GO

--//////////////////////////////////////////////////////////////

CREATE PROCEDURE SPInsertarDetalleFactura
(
@NroFactura INT,
@CodProducto CHAR(6),
@CodTalle CHAR(6),
@CodColor CHAR(6),
@PrecioUnitario DECIMAL(8,2),
@Cantidad INT
)
AS
INSERT INTO DetalleFacturas (NroFactura_Df,CodProducto_Df,CodTalle_Df,CodColor_Df,PrecioUnitario_Df,Cantidad_Df)
VALUES(@NroFactura,@CodProducto,@CodTalle,@CodColor,@PrecioUnitario,@Cantidad)
GO

--TRIGGERS
CREATE TRIGGER TRBajaStock
ON DetalleFacturas
AFTER INSERT
AS

BEGIN
	DECLARE @CodProducto CHAR(6), @CodTalle CHAR(6), @CodColor CHAR(6), @Stock int
	SET @CodProducto = (SELECT CodProducto_Df FROM INSERTED)
	SET @CodTalle = (SELECT CodTalle_Df FROM INSERTED)
	SET @CodColor = (SELECT CodColor_Df FROM INSERTED)
	SET @Stock = (SELECT Cantidad_Df FROM INSERTED)

	UPDATE TallesXProductosXColores
	SET Stock_TXPXC = Stock_TXPXC - @Stock
	WHERE CodProducto_TXPXC = @CodProducto AND
	CodTalle_TXPXC = @CodTalle AND
	CodColor_TXPXC = @CodColor
END
GO

--//////////////////////////////////////////////////////////////

CREATE TRIGGER AumentarTotalVenta
ON DetalleFacturas
AFTER INSERT
AS

BEGIN
	DECLARE @Precio decimal, @Cantidad int, @NroFactura int
	SET @Precio = (SELECT PrecioUnitario_Df FROM INSERTED)
	SET @Cantidad = (SELECT Cantidad_Df FROM INSERTED)
	SET @NroFactura = (SELECT NroFactura_Df FROM INSERTED)

	UPDATE Facturas
	SET Total_Fa += @Precio * @Cantidad
	WHERE NroFactura_Fa = @NroFactura
END
GO