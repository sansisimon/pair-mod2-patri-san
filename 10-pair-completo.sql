/* EJERCICIO 1
Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las empleadas y 
sus supervisoras.
Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. 
Investiga el resultado, ¿sabes decir quién es el director?*/

USE northwind;

SELECT EmployeeID, FirstName, LastName, City, ReportsTo
FROM Employees;

SELECT  e1.EmployeeID, e1.FirstName, e1.LastName, e1.City, e1.ReportsTo, e2.EmployeeID, e2.FirstName, e2.LastName, e2.City
FROM Employees AS e1 
LEFT JOIN Employees AS e2
ON  e1.ReportsTo = e2.EmployeeID;

-- SIMPLIFICAMOS PARA EJERCICIO:
SELECT  e1.FirstName AS NombreEmpleada, e1.LastName AS ApellidoEmpleada, e1.City, e2.FirstName AS NombreJefa, e2.LastName AS ApellidoJefa, e2.City
FROM Employees AS e1 
LEFT JOIN Employees AS e2
ON  e1.ReportsTo = e2.EmployeeID;

-- quien es la jefa? QUIEN NO TENGA JEFA
SELECT  e1.FirstName AS NombreEmpleada, e1.LastName AS ApellidoEmpleada, e1.City, e2.FirstName AS NombreJefa, e2.LastName AS ApellidoJefa, e2.City
FROM Employees AS e1 
LEFT JOIN Employees AS e2
ON  e1.ReportsTo = e2.EmployeeID
WHERE e2.FirstName IS NULL;

/* EJERCICIO 2
El equipo de marketing necesita una lista con todas las categorías de productos, incluso si no tienen productos 
asociados. Queremos obtener el nombre de la categoría y el nombre de los productos dentro de cada categoría. 
Podriamos usar un RIGTH JOIN con 'categories'?, usemos tambien la tabla 'products'.
*/

SELECT *
FROM Categories;

SELECT * 
FROM Products;

SELECT COUNT(ProductID)
FROM Products; -- > TENEMOS 77 PCTOS EN STOCK

SELECT c.CategoryName, p.ProductName
FROM Categories AS c
RIGHT JOIN Products AS p
ON c.CategoryID = p.CategoryID;


/* EJERCICIO 3
Desde el equipo de ventas nos piden obtener una lista de todos los pedidos junto con los datos de las empresas 
clientes. Sin embargo, hay algunos pedidos que pueden no tener un cliente asignado. Necesitamos asegurarnos de incluir 
todos los pedidos, incluso si no tienen cliente registrado.*/

SELECT *
FROM Orders;

SELECT COUNT(OrderID) AS numero_total_ordenes
FROM Orders;-- HAY 830 ORDENES

SELECT o.OrderID, o.CustomerID, c.CompanyName, c.Country
FROM Orders AS o
LEFT JOIN Customers AS c
USING (CustomerID);-- < ME DEVUELVE 830 ROWS, ASÍ QUE ESTÁ BIEN.

/* EJERCICIO 4
El equipo de Recursos Humanos quiere saber qué empleadas han gestionado pedidos y cuáles no. Queremos 
obtener una lista con todas las empleadas y, si han gestionado pedidos, mostrar los detalles del pedido.*/

SELECT *
FROM Orders;

SELECT CONCAT (e.FirstName, ' ', e.LastName) AS Empleada, o.OrderID, c.CompanyName
FROM Employees AS e
LEFT JOIN Orders AS o USING (EmployeeID)
INNER JOIN Customers AS c USING (CustomerID);


/* EJERCICIO 5
Desde el área de logística nos piden una lista de todos los transportistas (shippers) y los pedidos que han enviado. 
Queremos asegurarnos de incluir todos los transportistas, incluso si no han enviado pedidos.*/

SELECT *
FROM Shippers;

SELECT *
FROM Orders;

SELECT s.ShipperID, s.CompanyName, o.OrderID, c.CompanyName
FROM Shippers AS s
LEFT JOIN Orders AS o ON s.ShipperID = o.ShipVia
INNER JOIN Customers AS c USING (CustomerID);

