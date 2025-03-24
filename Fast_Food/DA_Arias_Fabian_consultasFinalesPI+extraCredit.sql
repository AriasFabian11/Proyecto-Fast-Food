--Posicionarse en la base de datos
use FastFood_DB;

--Resolucion de consultas finales

--¿Cuál es el tiempo promedio desde el despacho hasta la entrega de los pedidos gestionados por todo el equipo de mensajería?--

SELECT
	  AVG(DATEDIFF(MINUTE, FechaDespacho, FechaEntrega)) AS 'Tiempo Promedio de Entregas'
FROM Ordenes;

--Qué canal de ventas genera más ingresos?

SELECT OrigenesOrden.Descripcion, SUM(Ordenes.TotalCompra) AS Ingresos
FROM OrigenesOrden
		 JOIN Ordenes
		 ON Ordenes.OrdenID = OrigenesOrden.OrigenID
GROUP BY OrigenesOrden.Descripcion
ORDER BY Ingresos DESC;

--Cuál es el nivel de ingreso generado por Empleado?

SELECT Empleados.Nombre AS Vendedor, SUM(Ordenes.TotalCompra) AS Ingresos
FROM Empleados
	 JOIN Ordenes
	 ON Empleados.EmpleadoID = Ordenes.EmpleadoID
GROUP BY Empleados.Nombre
ORDER BY Ingresos DESC;

/*¿Cómo varía la demanda de productos a lo largo del día? NOTA: Esta consulta no puede ser implementada sin una definición 
clara del horario (mañana, tarde, noche) en la base de datos existente. Asumiremos que HorarioVenta refleja esta información correctamente.*/

SELECT Ordenes.HorarioVenta, DetalleOrdenes.ProductoID,
		SUM(DetalleOrdenes.Cantidad) AS Demanda_productos
FROM Ordenes
	JOIN DetalleOrdenes
	ON Ordenes.OrdenID = DetalleOrdenes.OrdenID
GROUP BY Ordenes.HorarioVenta,  DetalleOrdenes.ProductoID;

--¿Cuál es la tendencia de los ingresos generados en cada periodo mensual?

SELECT DATENAME(MONTH,FechaOrdenTomada) AS Mes, SUM(TotalCompra) AS Ingresos
FROM Ordenes
GROUP BY DATENAME(MONTH,FechaOrdenTomada);

/*¿Qué porcentaje de clientes son recurrentes versus nuevos clientes cada mes? NOTA: La consulta se enfocaría en la frecuencia de
 órdenes por cliente para inferir la fidelidad.*/

 SELECT 
    ClienteID,
    CONCAT(MONTH(FechaOrdenTomada), '-', YEAR(FechaOrdenTomada)) AS Mes_año,
    COUNT(OrdenID) AS Compras
FROM 
    Ordenes
GROUP BY 
    ClienteID, YEAR(FechaOrdenTomada), MONTH(FechaOrdenTomada)
ORDER BY 
    Compras DESC;


----------Extra Credit------------

insert into Ordenes (ClienteID, EmpleadoID, SucursalID, MensajeroID, TipoPagoID, OrigenID, HorarioVenta,TotalCompra, KilometrosRecorrer,
                            FechaDespacho, FechaEntrega,FechaOrdenTomada, FechaOrdenLista) VALUES 
(2, 3, 4, 5, 6, 7, 'Mañana', 1053.51, 4.5, '2023-01-15 09:30:00', '2023-01-10 10:00:00', '2023-01-15 08:00:00', '2023-01-10 08:15:00'),
(9, 8, 7, 6, 5, 4, 'Mañana', 2034.34, 3.5, '2023-01-01 10:30:00', '2023-01-10 11:00:00', '2023-01-01 08:00:00', '2023-01-10 08:15:00'),
(1, 3, 5, 7, 9, 2, 'Mañana', 1450.23, 2.5, '2023-01-22 09:30:00', '2023-01-10 12:00:00', '2023-01-22 08:00:00', '2023-01-10 08:15:00'),
(2, 4, 8, 3, 5, 7, 'Mañana', 1200.00, 1.5, '2023-01-03 11:30:00', '2023-01-10 12:30:00', '2023-01-03 08:00:00', '2023-01-10 08:15:00'),
(4, 5, 6, 7, 8, 9, 'Noche', 920.00, 2.0, '2023-03-20 19:30:00', '2023-03-20 20:00:00', '2023-03-20 19:00:00', '2023-03-20 19:15:00'),
(10, 9, 5, 8, 10, 10, 'Mañana', 930.00, 0.5, '2023-04-25 09:30:00', '2023-04-25 10:00:00', '2023-04-25 09:00:00', '2023-04-25 09:15:00'),
(3, 5, 6, 9, 1, 5, 'Tarde', 955.00, 8.0, '2023-05-30 15:30:00', '2023-05-30 16:00:00', '2023-05-30 15:00:00', '2023-05-30 15:15:00'),
(9, 8, 3, 5, 6, 1, 'Noche', 945.00, 12.5, '2023-06-05 20:30:00', '2023-06-05 21:00:00', '2023-06-05 20:00:00', '2023-06-05 20:15:00'),
(2, 7, 4, 2, 10, 2, 'Mañana', 1065.00, 7.5, '2023-07-10 08:30:00', '2023-07-10 09:00:00', '2023-07-10 08:00:00', '2023-07-10 08:15:00'),
(8, 7, 6, 5, 4, 3, 'Tarde', 1085.00, 9.5, '2023-08-15 14:30:00', '2023-08-15 15:00:00', '2023-08-15 14:00:00', '2023-08-15 14:15:00'),
(4, 5, 7, 2, 9, 4, 'Noche', 1095.00, 3.0, '2023-09-20 19:30:00', '2023-09-20 20:00:00', '2023-09-20 19:00:00', '2023-09-20 19:15:00'),
(8, 2, 6, 4, 7, 5, 'Mañana', 900.00, 15.0, '2023-10-25 09:30:00', '2023-10-25 10:00:00', '2023-10-25 09:00:00', '2023-10-25 09:15:00');

----consultas Extras---

--¿Que tipo de pago es el mas comun y cual genera mas ingresos?

SELECT 
    t.Descripcion AS TipoDePago,
    COUNT(ord.OrdenID) AS CantidadDeOrdenes,
    SUM(ord.TotalCompra) AS IngresoTotal
FROM 
    Ordenes ord
JOIN 
    TiposPago AS t ON ord.TipoPagoID = t.TipoPagoID
GROUP BY 
    t.Descripcion
ORDER BY 
    'IngresoTotal' DESC;

--¿Cuales son los productos mas vendidos en cada sucursal?

	SELECT 
    s.Nombre AS Sucursal,
    p.Nombre AS Producto,
    SUM(d.Cantidad) AS CantidadVendida,
    SUM(d.Cantidad * p.Precio) AS IngresoTotal
FROM 
    DetalleOrdenes AS d
JOIN 
    Ordenes AS o ON d.OrdenID = o.OrdenID
JOIN 
    Productos AS p ON d.ProductoID = p.ProductoID
JOIN 
    Sucursales AS s ON o.SucursalID = s.SucursalID
GROUP BY 
    s.Nombre, p.Nombre
ORDER BY 
    IngresoTotal DESC;

--¿Como ha cambiado el total de ventas a lo largo del tiempo, por ejemplo, por trimestre?

SELECT 
    YEAR(FechaOrdenTomada) AS Año,
    DATEPART(QUARTER, FechaOrdenTomada) AS Trimestre,
    SUM(TotalCompra) AS IngresoTotal
FROM 
    Ordenes
GROUP BY 
    YEAR(FechaOrdenTomada), DATEPART(QUARTER, FechaOrdenTomada)
ORDER BY 
    IngresoTotal DESC;

--¿Cual es el canal de venta que genera mas ingresos segun su origen?

SELECT 
    o.Descripcion AS CanalDeVenta,
    SUM(ord.TotalCompra) AS IngresoTotal
FROM 
    Ordenes ord
JOIN 
    OrigenesOrden o ON ord.OrigenID = o.OrigenID
GROUP BY 
    o.Descripcion
ORDER BY 
    IngresoTotal DESC;