-- Script de ejemplo para una estructura de datos tipo Árbol Binario en SQL

CREATE TABLE ArbolBinario (
    id SERIAL PRIMARY KEY,
    valor VARCHAR(100) NOT NULL,
    id_padre INTEGER REFERENCES ArbolBinario(id)
);

-- Insertar nodos de ejemplo
INSERT INTO ArbolBinario (valor, id_padre) VALUES ('Raíz', NULL);
INSERT INTO ArbolBinario (valor, id_padre) VALUES ('Hijo Izquierdo', 1);
INSERT INTO ArbolBinario (valor, id_padre) VALUES ('Hijo Derecho', 1);

-- Consultar todos los nodos
SELECT * FROM ArbolBinario;
