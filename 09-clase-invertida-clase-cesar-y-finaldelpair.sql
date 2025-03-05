USE `bbdd_empleadas_join`;

-- CROSS JOIN --------------

SELECT *
FROM `empleadas`;

SELECT *
FROM `empleadas_en_proyectos`;

SELECT `nombre`, `apellido`, `id_proyecto`
FROM `empleadas`
CROSS JOIN `empleadas_en_proyectos`; -- vemos que el resultado de esto no es demasiado útil... nos imprime todas las posibilidades.

SELECT `nombre`, `apellido`, `id_proyecto`
FROM `empleadas`
CROSS JOIN `empleadas_en_proyectos`
WHERE `empleadas`(`id_empleada`) = `empleadas_en_proyectos`(`id_empleada`); -- ojo! este WHERE es incorrecto!!! 
-- hay que referenciar las tablas de diferente forma:
-- `empleadas`(`id_empleada`) --> INCORRECTO. (esto intenta llamar una función inexistente).
-- empleadas.id_empleada  -->  CORRECTO. (esto compara correctamente las columnas).

SELECT `nombre`, `apellido`, `id_proyecto`
FROM `empleadas`
CROSS JOIN `empleadas_en_proyectos`
WHERE empleadas.id_empleada = empleadas_en_proyectos.id_empleada;

-- NATURAL JOIN -------------------------------------

SELECT `nombre`, `apellido`, `id_proyecto`
FROM `empleadas`
NATURAL JOIN `empleadas_en_proyectos`;  -- mismo resultado que el cross join con el filtro del WHERE

SELECT *
FROM `empleadas`
NATURAL JOIN `empleadas_en_proyectos`; -- vemos como la columna id_proyecto la añade a la de empleadas y 
-- sólo selecciona las empleadas que tienen proyecto asignado.

-- INNER JOIN ---------------------------------
SELECT *
FROM `empleadas`;

SELECT *
FROM `empleadas`
INNER JOIN `empleadas_en_proyectos`
ON empleadas.id_empleada = empleadas_en_proyectos.id_empleada;  -- mismo resultado que el NATURAL join y que CROSS JOIN con el filtro. 
-- DIFERENCIA:
-- Vemos que la columna de id_empleada está repetida!!! el Inner Join no cuenta duplicidades, mientras que el Natural join sí.

SELECT *
FROM `empleadas`
INNER JOIN `empleadas_en_proyectos`
USING (`id_empleada`); -- con el USING en lugar del ON, vemos como NO repite la columna id_empleada

/* ------------------------------------
EJERCICIOS
------------------------------------*/

USE `tienda`;

SELECT *
FROM `customers`;

-- Selecciona el ID, nombre, apellidos de las empleadas y el ID de cada cliente asociado a ellas, usando CROSS JOIN.
SELECT `employee_number`, `first_name`, `last_name`, `customer_number`
FROM `employees`
CROSS JOIN `customers` 
WHERE employees.employee_number = customers.sales_rep_employee_number;

-- OJO! importante ponerle un alias siempre:
SELECT e.employee_number, e.first_name, e.last_name, c.customer_number
FROM `employees` AS e -- es interesante ponerle un alias siempre para identificar las tablas
CROSS JOIN `customers` AS c
WHERE e.employee_number = c.sales_rep_employee_number;

-- Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando CROSS JOIN.
SELECT `employee_number`, `first_name`, `last_name`, COUNT(`customer_number`) AS `num_clientes`
FROM `employees`
CROSS JOIN `customers`
WHERE employees.employee_number = customers.sales_rep_employee_number -- esto es una restricción al CROSS JOIN
GROUP BY `employee_number`, `first_name`, `last_name`;

SELECT `employee_number`, `first_name`, `last_name`, COUNT(`customer_number`) AS `num_clientes`
FROM `employees`
CROSS JOIN `customers`
WHERE employees.employee_number = customers.sales_rep_employee_number
GROUP BY `employee_number`, `first_name`, `last_name`
HAVING `num_clientes` > 8;

-- Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando CROSS JOIN.

-- versión reducida sólo con la tabla de clientes:
SELECT COUNT(DISTINCT `country`) AS `num_paises_atentidos`, `sales_rep_employee_number`
FROM `customers`
GROUP BY `sales_rep_employee_number`;

SELECT `first_name`, `last_name`, COUNT(DISTINCT `country`) AS `num_paises_atentidos`
FROM `employees`
CROSS JOIN `customers`
WHERE employees.employee_number = customers.sales_rep_employee_number
GROUP BY `first_name`, `last_name`
HAVING `num_paises_atentidos` > 1
ORDER BY `num_paises_atentidos` DESC;


-- Selecciona el ID, nombre, apellidos de las empleadas y el ID de cada cliente asociado a ellas, usando INNER JOIN.
SELECT `employee_number`, `first_name`, `last_name`, `customer_number`
FROM `employees`
INNER JOIN `customers`
ON employees.employee_number = customers.sales_rep_employee_number;


-- Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando INNER JOIN.
SELECT `employee_number`, `first_name`, `last_name`, COUNT(`customer_number`) AS `num_clientes`
FROM `employees`
INNER JOIN `customers`
ON employees.employee_number = customers.sales_rep_employee_number
GROUP BY `employee_number`, `first_name`, `last_name`
HAVING `num_clientes` > 8
ORDER BY `num_clientes` DESC;

-- OJO! sólo nos están pidiendo aquellas columnas que pide el ejercicio: ID, nombre y apellidos:
SELECT e.employee_number, e.first_name, e.last_name
	FROM employees AS e
    INNER JOIN customers AS c
    ON e.employee_number = c.sales_rep_employee_number
    GROUP BY e.employee_number, e.first_name, e.last_name
    HAVING COUNT(c.customer_name) > 8;


-- Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando INNER JOIN.
SELECT `first_name`, `last_name`, COUNT(DISTINCT `country`) AS `num_dif_paises_clientes`
FROM `employees`
INNER JOIN `customers`
ON employees.employee_number = customers.sales_rep_employee_number
GROUP BY `first_name`, `last_name`
HAVING `num_dif_paises_clientes` > 1
ORDER BY `num_dif_paises_clientes` DESC;

-- Ahora pruebo a hacer lo mismo pero poniendo todo referenciando las columnas a cada tabla correspondiente.
SELECT employees.first_name, employees.last_name, COUNT(DISTINCT customers.country) AS `num_dif_paises_clientes`
FROM employees
INNER JOIN customers
ON employees.employee_number = customers.sales_rep_employee_number
GROUP BY employees.first_name, employees.last_name
HAVING `num_dif_paises_clientes` > 1
ORDER BY `num_dif_paises_clientes` DESC;

/*--------------------------------------------------------------
 Pair JOIN I
 -------------------------------------------------------------- */
 USE `northwind`;
 
/*EJERCICIO 1
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que 
podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. Nos piden el ID del cliente y el nombre 
de la empresa y el número de pedidos.
*/
SELECT *
FROM customers;

SELECT *
FROM Orders;

SELECT  c.CompanyName AS NombreEmpresa, c.CustomerID AS Identificador, COUNT(o.OrderID) AS NumeroPedidos
FROM Orders AS o
INNER JOIN Customers AS c
USING (CustomerID)
WHERE c.Country = 'UK'
GROUP BY c.CustomerID, c.CompanyName
ORDER BY NumeroPedidos DESC;

/*EJERCICIO 2
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos 
una serie de consultas adicionales. La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos 
ha pedido cada empresa cliente de UK durante cada año. Nos piden concretamente conocer el nombre de la empresa, el año, y 
la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
*/

SELECT *
FROM orderdetails;

SELECT *
FROM Orders;

SELECT c.CompanyName, YEAR(o.OrderDate) AS `Año`, SUM(od.Quantity) AS NumObjetos
FROM orderdetails AS od
INNER JOIN Orders AS o USING (OrderID)
INNER JOIN Customers AS c USING (CustomerID)
WHERE c.Country = 'UK'
GROUP BY c.CompanyName, YEAR(o.OrderDate);

/*EJERCICIO 3
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, desde la central nos 
han pedido una consulta que indique el nombre de cada compañía cliente junto con cada pedido que han realizado y su fecha.
*/
SELECT o.OrderID, c.CompanyName, o.OrderDate
FROM Orders AS o
INNER JOIN Customers AS c 
USING (CustomerID);


/*EJERCICIO 4
Ahora nos piden una lista con cada tipo de producto que se ha vendido, sus categorías, nombre de la categoría y 
el nombre del producto, y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta 
los descuentos).*/

SELECT *
FROM orderdetails;

SELECT *
FROM products;

SELECT *
FROM Categories;

SELECT cat.CategoryID, cat.CategoryName, p.ProductName, SUM((o.Quantity * o.UnitPrice) * ( 1 - o. Discount)) AS ProductSales
FROM Products AS p
INNER JOIN Categories AS cat USING (CategoryID)
INNER JOIN orderdetails AS o USING (ProductID)
GROUP BY cat.CategoryID, cat.CategoryName, p.ProductName
ORDER BY cat.CategoryID AND p.ProductName ;


/*EJERCICIO 5
Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, 
los ID de sus pedidos y las fechas.
*/
SELECT *
FROM Customers;

SELECT o.OrderID, c. CompanyName, o.OrderDate
FROM Customers AS c
INNER JOIN Orders AS o
USING(CustomerID);

/*EJERCICIO 6
Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado cada 
cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. Específicamente nos 
piden el nombre de cada compañía cliente junto con el número de pedidos.
*/
SELECT c. CompanyName, COUNT(o.OrderID) AS NumeroPedidos
FROM Customers AS c
INNER JOIN Orders AS o
USING(CustomerID)
WHERE c.Country = 'UK'
GROUP BY c. CompanyName;


/*EJERCICIO 7
Desde la dirección de ventas nos solicitan generar todas las combinaciones posibles entre empleadas y territorios 
de ventas. Queremos ver qué pasaría si cualquier empleada pudiera trabajar en cualquier territorio. 
Nota Tal vez un CROSS JOIN sea la solucion....*/

SELECT *
FROM Territories;

SELECT *
FROM Employees;

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS Empleada, TerritoryDescription
FROM Employees AS e
CROSS JOIN Territories;



