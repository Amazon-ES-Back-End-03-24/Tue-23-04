
# Tabla Original

| ClienteNombre | LibroID | LibroTitulo | LibroPrecio | FechaVenta |
|---------------|---------|-------------|-------------|------------|
| Juan Perez    | 101     | Dune        | 20          | 2022-01-01 |
| Ana Gómez     | 102     | 1984        | 15          | 2022-01-02 |
| Juan Perez    | 101     | Dune        | 20          | 2022-01-03 |
| Sara Lina     | 103     | El Hobbit   | 25          | 2022-01-01 |
| Ana Gómez     | 102     | 1984        | 15          | 2022-01-02 |


## 1NF Se encuentra en la primera forma normal

| ClienteNombre | LibroID | LibroTitulo | LibroPrecio | FechaVenta |
|---------------|---------|-------------|-------------|------------|
| Juan Perez    | 101     | Dune        | 20          | 2022-01-01 |
| Ana Gómez     | 102     | 1984        | 15          | 2022-01-02 |
| Juan Perez    | 101     | Dune        | 20          | 2022-01-03 |
| Sara Lina     | 103     | El Hobbit   | 25          | 2022-01-01 |


## 2NF Se encuentra en la segunda forma normal

| VentaId | ClienteNombre | LibroID | LibroTitulo | LibroPrecio | FechaVenta |
|---------|---------------|---------|-------------|-------------|------------|
| 1       | Juan Perez    | 101     | Dune        | 20          | 2022-01-01 |
| 2       | Ana Gómez     | 102     | 1984        | 15          | 2022-01-02 |
| 3       | Juan Perez    | 101     | Dune        | 20          | 2022-01-03 |
| 4       | Sara Lina     | 103     | El Hobbit   | 25          | 2022-01-01 |


## 3NF Se encuentra en la tercera forma normal

| VentaId | ClienteNombre | LibroID | FechaVenta |
|---------|---------------|---------|------------|
| 1       | Juan Perez    | 101     | 2022-01-01 |
| 2       | Ana Gómez     | 102     | 2022-01-02 |
| 3       | Juan Perez    | 101     | 2022-01-03 |
| 4       | Sara Lina     | 103     | 2022-01-01 |


| LibroID | LibroTitulo | LibroPrecio |
|---------|-------------|-------------|
| 101     | Dune        | 20          |
| 102     | 1984        | 15          |
| 103     | El Hobbit   | 25          |


 # DDL 
Data Definition Language - comandos definir base de datos


## JOINS (See examples in execute.sql - you can paste it in a console in your DB)

### INNER JOIN (Books INNER JOIN Ventas)

Devuelve filas donde hay coincidencias en ambas tablas. Solo Libro1 y Libro3 tienen ventas correspondientes, por lo que son las únicas filas devueltas.

```
| Libro       | Venta        |
|-------------|--------------|
| Libro1      | Venta1       |
| Libro3      | Venta3       |
```

### LEFT JOIN (Libros LEFT JOIN Ventas)

Incluye todos los registros de la tabla izquierda (Libros), y los registros coincidentes de la tabla derecha (Ventas). Si no hay coincidencia, el resultado es NULL en la tabla derecha.

```
| Libro       | Venta        |
|-------------|--------------|
| Libro1      | Venta1       |
| Libro2      | NULL         |  <- No sale for Libro2
| Libro3      | Venta3       |
```

### RIGHT JOIN (Libros RIGHT JOIN Ventas)

Incluye todos los registros de la tabla derecha (Ventas), y los registros coincidentes de la tabla izquierda (Libros). Si no hay coincidencia, el resultado es NULL en la tabla izquierda.

```
| Libro       | Venta        |
|-------------|--------------|
| Libro1      | Venta1       |
| NULL        | Venta2       |  <- Venta2 has no corresponding book (hypothetical)
| Libro3      | Venta3       |
```

### FULL JOIN (Libros FULL JOIN Ventas)

Incluye todos los registros cuando hay una coincidencia en alguna de las tablas, izquierda o derecha. Donde no hay entradas correspondientes, los resultados son NULL en el lado sin coincidencia.

```
| Libro       | Venta        |
|-------------|--------------|
| Libro1      | Venta1       |
| Libro2      | NULL         |  <- No sale for Libro2
| NULL        | Venta2       |  <- Venta2 has no corresponding book (hypothetical)
| Libro3      | Venta3       |
```



