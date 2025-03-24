--Posicionarse en la base de datos
USE FastFood_DB;

------------------Consultas Sql------------------------

--Pregunta: ¿Cómo puedo obtener una lista de todos los productos junto con sus categorías?

SELECT
    P.Nombre,
    C.Nombre AS Categoria
FROM Productos AS P -- Alias para la tabla productos
INNER JOIN Categorias AS C -- alias para la tabla categorias
ON P.CategoriaID = C.CategoriaID;

--Pregunta: ¿Cómo puedo saber a qué sucursal está asignado cada empleado?

SELECT
    E.Nombre,
    S.Nombre AS Sucursal
FROM Empleados AS E
INNER JOIN Sucursales AS S
ON E.SucursalID = S.SucursalID;

--Pregunta: ¿Existen productos que no tienen una categoría asignada?

SELECT  
    P.Nombre,
    C.Nombre AS Categoria
FROM Productos AS P
LEFT JOIN Categorias AS C
ON P.CategoriaID = C.CategoriaID;

/*Pregunta: ¿Cómo puedo obtener un detalle completo de las órdenes, incluyendo el Nombre del cliente, Nombre del empleado que tomó la orden,
 y Nombre del mensajero que la entregó?*/

SELECT  
        C.Nombre AS Cliente,
        E.Nombre AS Empleado,
        m.Nombre AS Mensajero,
        O.*
FROM Ordenes AS O
LEFT JOIN Clientes AS C
ON O.ClienteID = C.ClienteID
INNER JOIN Empleados AS E
ON O.EmpleadoID = E.EmpleadoID
INNER JOIN Mensajeros AS M
ON O.MensajeroID = M.MensajeroID;

--Pregunta: ¿Cuántos artículos correspondientes a cada Categoría de Productos se han vendido en cada sucursal?

select  C.Nombre as Categorias,
        S.Nombre as Sucursales,
        SUM(D.Cantidad) as Cantidad
from ordenes as O
join DetalleOrdenes as D
    on O.OrdenID = D.OrdenID
join Sucursales as S
    on O.SucursalID = s.SucursalID
join Productos as P
    on D.ProductoID = P.ProductoID
JOIN Categorias as C
    on P.CategoriaID = C.CategoriaID
GROUP by C.Nombre, S.Nombre
order by Cantidad;