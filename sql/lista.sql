-- Script de ejemplo para una estructura de datos tipo Lista en SQL

CREATE TABLE Lista (
    id SERIAL PRIMARY KEY,
    valor VARCHAR(100) NOT NULL
);

-- Insertar elementos de ejemplo
INSERT INTO Lista (valor) VALUES ('Elemento 1');
INSERT INTO Lista (valor) VALUES ('Elemento 2');
INSERT INTO Lista (valor) VALUES ('Elemento 3');

-- Consultar todos los elementos
SELECT * FROM Lista;
