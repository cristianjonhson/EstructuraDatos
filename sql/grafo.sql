-- Script de ejemplo para una estructura de datos tipo Grafo en SQL

CREATE TABLE Nodo (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Arista (
    id SERIAL PRIMARY KEY,
    origen INTEGER REFERENCES Nodo(id),
    destino INTEGER REFERENCES Nodo(id)
);

-- Insertar nodos de ejemplo
INSERT INTO Nodo (nombre) VALUES ('A');
INSERT INTO Nodo (nombre) VALUES ('B');
INSERT INTO Nodo (nombre) VALUES ('C');

-- Insertar aristas de ejemplo
INSERT INTO Arista (origen, destino) VALUES (1, 2);
INSERT INTO Arista (origen, destino) VALUES (2, 3);
INSERT INTO Arista (origen, destino) VALUES (3, 1);

-- Consultar nodos y aristas
SELECT * FROM Nodo;
SELECT * FROM Arista;
