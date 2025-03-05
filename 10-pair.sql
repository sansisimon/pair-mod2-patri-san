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
*/
