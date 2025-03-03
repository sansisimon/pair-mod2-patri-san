USE northwind;

-- Desde la división de productos nos piden conocer el precio de los productos que tienen el precio más alto y más bajo. 
-- Dales el alias lowestPrice y highestPrice.

SELECT MIN(UnitPrice) AS lowestPrice
FROM products;

SELECT MAX(UnitPrice) AS highestPrice
FROM products;

-- nos piden que diseñemos otra consulta para conocer el número de productos y el precio medio de todos ellos 
-- (en general, no por cada producto).

SELECT *
FROM products;

SELECT COUNT(ProductName) AS num_productos, AVG(unitprice) AS precio_medio
FROM products;

-- Nuestro siguiente encargo consiste en preparar una consulta que devuelva la máxima y mínima cantidad de 
-- carga para un pedido (freight) enviado a Reino Unido (United Kingdom).

SELECT *
FROM orders;

SELECT MIN(freight) AS min_cantidad_carga, ShipCountry
FROM orders 
WHERE ShipCountry =  'UK'
GROUP BY ShipCountry;

-- Después de analizar los resultados de alguna de nuestras consultas anteriores, desde el departamento de Ventas 
-- quieren conocer qué productos en concreto se venden por encima del precio medio para todos los productos de la empresa, 
-- ya que sospechan que dicho número es demasiado elevado. También quieren que ordenemos los resultados por su precio de mayor a menor.

SELECT COUNT(ProductName) AS num_productos, AVG(unitprice) AS precio_medio
FROM products; -- RESULTADO PRECIO MEDIO = 28.86

SELECT ProductName, UnitPrice
FROM products
WHERE UnitPrice > 28.86
ORDER BY UnitPrice DESC;

-- De cara a estudiar el histórico de la empresa nos piden una consulta para conocer el número de productos que se han descontinuado.
-- El atributo Discontinued es un booleano: si es igual a 1 el producto ha sido descontinuado.

SELECT ProductName, Discontinued
FROM products
WHERE Discontinued = 1;

SELECT ProductName AS productos_discontinued
FROM products
WHERE Discontinued = 1;

-- Adicionalmente nos piden detalles de aquellos productos no descontinuados, sobre todo el ProductID y ProductName. 
-- Como puede que salgan demasiados resultados, nos piden que los limitemos a los 10 con ID más elevado, 
-- que serán los más recientes. No nos pueden decir del departamento si habrá pocos o muchos resultados, pero lo limitamos por si acaso.
SELECT ProductID, ProductName
FROM products
WHERE Discontinued = 0
ORDER BY ProductID DESC
LIMIT 10;

-- Desde logística nos piden el número de pedidos y la máxima cantidad de carga de entre los mismos (freight) 
-- que han sido enviados por cada empleado (mostrando el ID de empleado en cada caso).

SELECT * 
FROM orders;

SELECT COUNT(OrderID) AS num_pedidos, MAX(Freight) AS max_cantidad_carga
FROM orders;

SELECT EmployeeID, COUNT(OrderID) AS num_pedidos, MAX(Freight) AS max_cantidad_carga
FROM orders
GROUP BY EmployeeID;

