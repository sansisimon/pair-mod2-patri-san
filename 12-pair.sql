/* -----------------------------------------------------------------
EJERCICIOS pair
-----------------------------------------------------------------*/
USE `northwind`;


/* 
EJERCICIO 1. Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que 
lo hagamos con una query correlacionada.*/

SELECT *
FROM Orders;

SELECT OrderDate
FROM Orders
WHERE EmployeeID = 5;

SELECT MAX(OrderDate)
FROM Orders
WHERE EmployeeID = 5
ORDER BY EmployeeID;

SELECT OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate
FROM Orders AS o
WHERE OrderDate >= ALL(SELECT OrderDate
						FROM Orders
						WHERE EmployeeID = o.EmployeeID);

SELECT OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate
FROM Orders AS o
WHERE OrderDate >= ALL(SELECT MAX(OrderDate)
						FROM Orders AS o2
						WHERE o2.EmployeeID = o.EmployeeID
                        GROUP BY o2.EmployeeID);

/* 
EJERCICIO 2. Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. 
En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del 
producto y su ID de categoría.*/
SELECT ProductID, ProductName, CategoryID
FROM Products;

SELECT *
FROM Categories; -- > Beverages => CATEGORY_ID = 1;

SELECT ProductID, ProductName, CategoryID
FROM Products
WHERE CategoryID = (SELECT CategoryID
					FROM Categories
					WHERE CategoryName IN ('Beverages'));

/* 
EJERCICIO 3. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para 
buscar proveedores adicionales.*/

SELECT *
FROM Suppliers;

SELECT *
FROM Customers;

SELECT Country -- > SUBQUERY
FROM Suppliers;

SELECT country		 -- > con esta query nos salen repeticiones
FROM Customers AS c
WHERE c.country NOT IN (SELECT Country
						FROM Suppliers)
ORDER BY c.country ASC;
                        
SELECT DISTINCT c.country		 -- > eliminamos repeticiones con el DISTINCT
FROM Customers AS c
WHERE c.country NOT IN (SELECT Country
						FROM Suppliers)
ORDER BY c.country ASC;

/* 
EJERCICIO 4. Extraer los clientes que compraron mas de 20 artículos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" 
(ProductID 6) en un solo pedido.*/



/* 
EJERCICIO 5. Qué producto es más popular: Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.
*/
