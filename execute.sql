CREATE TABLE Libros
(
    LibroId     int          NOT NULL,
    LibroTitulo varchar(255) NOT NULL,
    LibroPrecio decimal      NOT NULL,
    PRIMARY KEY (LibroId)
);

CREATE TABLE Ventas
(
    VentaId       int          NOT NULL PRIMARY KEY,
    ClienteNombre varchar(255) NOT NULL,
    LibroId       int          NOT NULL,
    FechaVenta    date,
    FOREIGN KEY (LibroId) REFERENCES Libros (LibroId)
);

INSERT INTO Libros (LibroId, LibroTitulo, LibroPrecio)
VALUES (101, 'Dune', 20),
       (102, '1984', 15),
       (103, 'El Hobbit', 25);

INSERT INTO Ventas (VentaId, ClienteNombre, LibroId, FechaVenta)
VALUES (1, 'Juan Perez', 101, '2022-01-01'),
       (2, 'Ana Gómez', 102, '2022-01-02'),
       (3, 'Juan Perez', 101, '2022-01-03'),
       (4, 'Sara Lina', 103, '2022-01-01');

-- This will fail, as we don't have a LibroId = 104 in our DB
INSERT INTO Ventas
VALUES (5, 'Pepito Grillo', 104, null);


INSERT INTO Ventas
VALUES (5, 'Juan Perez', 101, '2022-01-01');

-- To add decimals
ALTER TABLE Libros
    MODIFY LibroPrecio decimal(10, 2);

UPDATE Libros
SET LibroPrecio = 22.11
WHERE LibroTitulo = 'Dune';

UPDATE Libros
SET LibroPrecio = 37.00
WHERE LibroId = 103;

DROP TABLE Ventas;
DROP TABLE Libros;

-- For these examples you need to have data in your tables, so do the create and inserts

SELECT COUNT(*) AS TotalVentas
FROM Ventas;

SELECT AVG(LibroPrecio) AS PrecioPromedio
FROM Libros;


SELECT SUM(LibroPrecio) AS IngresosTotales
FROM Ventas
         INNER JOIN Libros ON Ventas.LibroId = Libros.LibroId
WHERE FechaVenta = '2022-01-01';

SELECT SUM(LibroPrecio) AS CosteTotal
FROM Libros;

SELECT MIN(Libros.LibroPrecio) AS PrecioMinimo,
       MAX(Libros.LibroPrecio) AS PrecioMaximo
FROM Libros;

SELECT LibroId, COUNT(*) AS NumeroDeVentas
FROM Ventas
GROUP BY LibroId
HAVING COUNT(*) > 1;

SELECT *
FROM Libros
WHERE LibroTitulo LIKE '%it';

SELECT LibroTitulo
FROM Libros
WHERE LibroTitulo LIKE '%e%';

SELECT LibroTitulo
FROM Libros
WHERE LibroTitulo LIKE '___e';

SELECT *
FROM Libros
WHERE LibroPrecio BETWEEN 10 AND 20;

SELECT *
FROM Libros
WHERE LibroPrecio < 22
   OR LibroTitulo = 'El Hobbit';

SELECT *
FROM Libros
ORDER BY LibroPrecio DESC;

SELECT *
FROM Libros
ORDER BY LibroPrecio ASC;

SELECT DISTINCT ClienteNombre
FROM Ventas;

-- Add a book that has not been sold (to demonstrate LEFT JOIN and FULL JOIN):
INSERT INTO Libros (LibroId, LibroTitulo, LibroPrecio)
VALUES (104, 'Catch-22', 30);

-- This insert is only for demonstration and its BAD PRACTICE, it is just to test the joins
-- So it doesn't fail we "disable" the foreignKeys (so we can add a Venta with an nonexistent LibroId)
SET foreign_key_checks = 0;
INSERT INTO Ventas (VentaId, ClienteNombre, LibroId, FechaVenta)
VALUES (6, 'Maria Luisa', 105, '2022-01-05');
SET foreign_key_checks = 1;

-- INNER
SELECT Ventas.VentaId, Ventas.ClienteNombre, Libros.LibroTitulo, Ventas.FechaVenta
FROM Ventas
         INNER JOIN Libros ON Ventas.LibroId = Libros.LibroId;

-- LEFT
SELECT Libros.LibroId, Libros.LibroTitulo, Ventas.VentaId, Ventas.FechaVenta
FROM Libros
         LEFT JOIN Ventas ON Ventas.LibroId = Libros.LibroId;

-- RIGHT
SELECT Ventas.VentaId, Ventas.ClienteNombre, Libros.LibroTitulo, Ventas.FechaVenta
FROM Ventas
         RIGHT JOIN Libros ON Ventas.LibroId = Libros.LibroId;


-- ------MORE JOIN EXAMPLES------ --
-- INNER
SELECT Libros.LibroTitulo AS Libro, Ventas.VentaId AS Venta
FROM Libros
         INNER JOIN Ventas ON Libros.LibroId = Ventas.LibroId;

-- LEFT
SELECT Libros.LibroTitulo AS Libro, Ventas.VentaId AS Venta
FROM Libros
         LEFT JOIN Ventas ON Libros.LibroId = Ventas.LibroId;


-- RIGHT
SELECT Libros.LibroTitulo AS Libro, Ventas.VentaId AS Venta
FROM Libros
         RIGHT JOIN Ventas ON Libros.LibroId = Ventas.LibroId;


-- FULL JOIN - not supported in MySQL so we have to simulate it doing left + right join

SELECT Libros.LibroTitulo AS Libro,
       Ventas.VentaId     AS Venta
FROM Libros
         LEFT JOIN Ventas ON Libros.LibroId = Ventas.LibroId
UNION ALL
SELECT Libros.LibroTitulo AS Libro,
       Ventas.VentaId     AS Venta
FROM Libros
         RIGHT JOIN Ventas ON Libros.LibroId = Ventas.LibroId
WHERE Libros.LibroId IS NULL; -- so there is no duplication

-- In other database the full join would be
-- SELECT Libros.LibroTitulo AS Libro, Ventas.VentaId AS Venta
-- FROM Libros
-- FULL JOIN Ventas ON Libros.LibroId = Ventas.LibroId;
