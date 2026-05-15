-- Script de ejemplo para una estructura de datos tipo Grafo en SQL
DROP TABLE IF EXISTS Arista;
DROP TABLE IF EXISTS Nodo;
CREATE TABLE Nodo (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
CREATE TABLE Arista (
    id SERIAL PRIMARY KEY,
    origen INTEGER NOT NULL REFERENCES Nodo(id) ON DELETE CASCADE,
    destino INTEGER NOT NULL REFERENCES Nodo(id) ON DELETE CASCADE,
    CONSTRAINT chk_arista_sin_bucle CHECK (origen <> destino),
    CONSTRAINT uq_arista UNIQUE (origen, destino)
);
-- Insertar nodos de ejemplo
INSERT INTO Nodo (nombre)
VALUES ('A');
INSERT INTO Nodo (nombre)
VALUES ('B');
INSERT INTO Nodo (nombre)
VALUES ('C');
-- Insertar aristas de ejemplo
INSERT INTO Arista (origen, destino)
VALUES (1, 2);
INSERT INTO Arista (origen, destino)
VALUES (2, 3);
INSERT INTO Arista (origen, destino)
VALUES (3, 1);
-- Consultar nodos y aristas
SELECT *
FROM Nodo
ORDER BY id;
SELECT *
FROM Arista
ORDER BY id;
