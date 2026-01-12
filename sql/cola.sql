-- Script de ejemplo para una estructura de datos tipo Cola (Queue) en SQL

CREATE TABLE Cola (
    id SERIAL PRIMARY KEY,
    valor VARCHAR(100) NOT NULL,
    fecha_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar elementos (enqueue)
INSERT INTO Cola (valor) VALUES ('Elemento X');
INSERT INTO Cola (valor) VALUES ('Elemento Y');
INSERT INTO Cola (valor) VALUES ('Elemento Z');

-- Consultar el primer elemento (front)
SELECT * FROM Cola ORDER BY fecha_ingreso ASC LIMIT 1;

-- Eliminar el primer elemento (dequeue)
-- DELETE FROM Cola WHERE id = (SELECT id FROM Cola ORDER BY fecha_ingreso ASC LIMIT 1);
