USE northwind;

-- EJERCICIO_1 Pedidos por empresa en UK: Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la 
-- que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.

SELECT * 
FROM orders;

SELECT*
FROM customers;

SELECT c.CompanyName, c.CustomerID, COUNT(o.OrderID)
FROM customers AS c 
INNER JOIN orders AS o
ON c.CustomerID = o.CustomerID
WHERE c.Country = "UK"
GROUP BY c.CustomerID, c.CompanyName;


-- EJERCICIO_2 Productos pedidos por empresa en UK por año: 
-- Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie de consultas adicionales. 
-- La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. Nos piden concretamente
-- conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.

SELECT * 
FROM orders;

SELECT*
FROM customers;

SELECT o.CustomerID, CompanyName, Country, SUM(od.Quantity), year(o.OrderDate)
FROM orderdetails AS od
INNER JOIN orders AS o
ON o.CustomerID, od.CustomerID
INNER JOIN o.CustomerID
GROUP BY o.CustomerID, year(o.OrderDate)




