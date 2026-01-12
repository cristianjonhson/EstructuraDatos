-- Script de ejemplo para una estructura de datos tipo Pila (Stack) en SQL

CREATE TABLE Pila (
    id SERIAL PRIMARY KEY,
    valor VARCHAR(100) NOT NULL,
    fecha_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar elementos (push)
INSERT INTO Pila (valor) VALUES ('Elemento A');
INSERT INTO Pila (valor) VALUES ('Elemento B');
INSERT INTO Pila (valor) VALUES ('Elemento C');

-- Consultar el elemento en la cima (top)
SELECT * FROM Pila ORDER BY fecha_ingreso DESC LIMIT 1;

-- Eliminar el elemento en la cima (pop)
-- DELETE FROM Pila WHERE id = (SELECT id FROM Pila ORDER BY fecha_ingreso DESC LIMIT 1);
