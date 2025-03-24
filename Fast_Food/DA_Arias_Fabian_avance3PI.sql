--Posicionarse en la base de datos
use FastFood_DB;

------------Consultas Sql--------------

--Pregunta: ¿Cuál es el total de ventas (TotalCompra) a nivel global?

SELECT SUM(TotalCompra) AS TotalVentas 
FROM Ordenes;

--Pregunta: ¿Cuál es el precio promedio de los productos dentro de cada categoría?

SELECT CategoriaID, CAST(AVG(Precio) AS DECIMAL(10,2)) AS PromedioPrecio
FROM Productos
GROUP BY CategoriaID;

--Pregunta: ¿Cuál es el valor de la orden mínima y máxima por cada sucursal?

SELECT SucursalID, 
    min(TotalCompra) AS CompraMinima,
    max(TotalCompra) AS CompraMaxima
FROM ORDENES
GROUP BY SucursalID;

--Pregunta: ¿Cuál es el mayor número de kilómetros recorridos para una entrega?

SELECT MAX(KilometrosRecorrer) AS KmMax
FROM Ordenes;

--Pregunta: ¿Cuál es la cantidad promedio de productos por orden?

select OrdenID,
    AVG(Cantidad) AS CantidadPromedio
FROM DetalleOrdenes
GROUP BY OrdenID;

--Pregunta: ¿Cómo se distribuye la Facturación Total del Negocio de acuerdo a los métodos de pago?

select TipoPagoID, SUM(TotalCompra) AS TotalTipoPago
FROM Ordenes
GROUP BY TipoPagoID;

--Pregunta: ¿Cuál Sucursal tiene el ingreso promedio más alto?

SELECT top 1 SucursalID,
    cast(AVG(TotalCompra) as decimal(10,2)) AS PromedioVenta 
FROM Ordenes
GROUP BY SucursalID
Order by PromedioVenta DESC;

--Pregunta: ¿Cuáles son las sucursales que han generado ventas totales por encima de $ 1000?

SELECT SucursalID,
    SUM(TotalCompra) AS VentasSucursal
FROM Ordenes
GROUP BY SucursalID
HAVING SUM(TotalCompra) > 1000.00;

--Pregunta: ¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?

select DISTINCT
(SELECT AVG(TotalCompra)
FROM Ordenes
where FechaOrdenTomada < '2023-07-01') AS AntesJulio, -- 1 consulta promedio de ingresos antes del 1 de julio
(SELECT AVG(TotalCompra)
FROM Ordenes
where FechaOrdenTomada > '2023-07-01') AS DespuesJulio; -- 2 consulta promedio de ingresos despues del 1 de julio

/*Pregunta: ¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor cantidad de ventas, cuál es el ingreso 
promedio de estas ventas, y cuál ha sido el importe máximo alcanzado por una orden en dicha jornada?*/

SELECT HorarioVenta,
    COUNT(OrdenID) AS NroVentas, 
    MAX(TotalCompra) AS MaxIngresos, 
    CAST(AVG(TotalCompra) AS decimal(10,2)) AS PromedioIngresos
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY MaxIngresos DESC;