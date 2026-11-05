DROP DATABASE IF EXISTS austral;

CREATE DATABASE austral;

USE austral;

CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    pais VARCHAR(60),
    genero ENUM('Cómic','Ensayo','Infantil','Novela','Poesía') NOT NULL
);

CREATE TABLE colecciones (
    id_coleccion INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(120) NOT NULL,
    fecha_publicacion DATE NOT NULL
);

CREATE TABLE libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    id_autor INT NOT NULL,
    id_coleccion INT NOT NULL,
    titulo VARCHAR(120) NOT NULL,
    paginas INT NOT NULL,
    ejemplares_vendidos INT NOT NULL,
    anio INT NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_coleccion) REFERENCES colecciones(id_coleccion)
);

CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_autor INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);

USE austral;

INSERT INTO autores (nombre, pais, genero)
VALUES
('Elena Pizarro', 'Chile', 'Novela'),
('Harold Finch', 'Inglaterra', 'Ensayo'),
('Rodrigo Bahamonde', 'Chile', 'Poesía'),
('Valentina Correa', 'Argentina', 'Infantil'),
('Nora Keller', 'Estados Unidos', 'Novela'),
('Kenji Arakawa', NULL, 'Cómic');

INSERT INTO colecciones (titulo, fecha_publicacion)
VALUES
('Narrativa Austral', '2023-01-01'),
('Nuevas Lecturas', '2024-01-01');

INSERT INTO libros
(id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio)
VALUES
(1, 2, 'Cielo de Enero', 210, 1500, 2024),
(1, 1, 'Marea Baja', 185, 800, 2023),
(1, 2, 'El Norte', 200, 2200, 2024),
(2, 1, 'Estrellas que Caen', 240, 3000, 2022),
(2, 2, 'Máquinas', 215, 450, 2024),
(3, 2, 'Luz Artificial', 300, 1200, 2024),
(3, 1, 'Ruido Blanco', 280, 600, 2023),
(4, 2, 'El Barrio de Lila', 190, 5000, 2024),
(4, 2, 'Antes del Amanecer', 205, 2700, 2024),
(4, 1, 'La Calle 8', 175, 900, 2023),
(5, 2, 'Flor de Hierro', 195, 4100, 2024),
(5, 1, 'Hora Dorada', 220, 1800, 2022);

INSERT INTO pagos (id_autor, fecha_pago, monto)
VALUES
(1, '2024-06-15', 150000.00),
(1, '2024-12-15', 200000.00),
(3, '2024-09-20', 125000.00);



SELECT nombre, genero
FROM autores
WHERE pais <> 'Chile' OR pais IS NULL
ORDER BY nombre ASC;




SELECT titulo, paginas
FROM libros
WHERE paginas BETWEEN 190 AND 220
ORDER BY paginas ASC;




SELECT
    COUNT(*) AS cantidad_libros,
    SUM(ejemplares_vendidos) AS total_vendidos,
    AVG(paginas) AS promedio_paginas,
    MIN(anio) AS anio_mas_antiguo,
    MAX(ejemplares_vendidos) AS maximo_vendido
FROM libros;




SELECT DISTINCT genero
FROM autores
ORDER BY genero ASC;




SELECT a.nombre, COUNT(l.id_libro) AS cantidad_libros
FROM autores a
JOIN libros l ON a.id_autor = l.id_autor
WHERE l.anio = 2024
GROUP BY a.id_autor, a.nombre
HAVING COUNT(l.id_libro) > 1
ORDER BY a.nombre ASC;




SELECT titulo, ejemplares_vendidos
FROM libros
WHERE anio = 2024 AND ejemplares_vendidos > 2000
ORDER BY ejemplares_vendidos DESC
LIMIT 3;




INSERT INTO libros
(id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio)
VALUES
(3, 2, 'Papel Mojado', 260, 50, 2024);

SELECT * FROM libros
WHERE titulo = 'Papel Mojado';

DELETE FROM libros
WHERE titulo = 'Papel Mojado';

SELECT * FROM libros
WHERE titulo = 'Papel Mojado';




SELECT titulo, ejemplares_vendidos
FROM libros
WHERE titulo = 'Cielo de Enero';

UPDATE libros
SET ejemplares_vendidos = ejemplares_vendidos + 100
WHERE titulo = 'Cielo de Enero';

SELECT titulo, ejemplares_vendidos
FROM libros
WHERE titulo = 'Cielo de Enero';




SELECT l.titulo, c.titulo AS coleccion, c.fecha_publicacion
FROM libros l
JOIN colecciones c ON l.id_coleccion = c.id_coleccion;




SELECT a.nombre, p.fecha_pago, p.monto
FROM autores a
JOIN pagos p ON a.id_autor = p.id_autor;

SELECT a.nombre, SUM(p.monto) AS total_pagado
FROM autores a
JOIN pagos p ON a.id_autor = p.id_autor
GROUP BY a.id_autor, a.nombre;