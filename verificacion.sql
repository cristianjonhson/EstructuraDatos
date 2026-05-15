-- Script unico de verificacion automatica (PostgreSQL + psql)
-- Ejecuta todos los scripts y valida casos clave de pila, cola, arbol y grafo.
\
set ON_ERROR_STOP on \ echo '== Ejecutando scripts base ==' \ i sql / lista.sql \ i sql / pila.sql \ i sql / cola.sql \ i sql / arbol.sql \ i sql / grafo.sql \ echo '== Iniciando validaciones ==' -- Validacion de pila: top debe ser el ultimo insertado (LIFO)
    DO $$
DECLARE top_valor TEXT;
BEGIN
SELECT valor INTO top_valor
FROM Pila
ORDER BY id DESC
LIMIT 1;
IF top_valor IS DISTINCT
FROM 'Elemento C' THEN RAISE EXCEPTION 'Pila invalida: se esperaba top=Elemento C, actual=%',
    top_valor;
END IF;
END;
$$;
-- Validacion de cola: front debe ser el primero insertado (FIFO)
DO $$
DECLARE front_valor TEXT;
BEGIN
SELECT valor INTO front_valor
FROM Cola
ORDER BY id ASC
LIMIT 1;
IF front_valor IS DISTINCT
FROM 'Elemento X' THEN RAISE EXCEPTION 'Cola invalida: se esperaba front=Elemento X, actual=%',
    front_valor;
END IF;
END;
$$;
-- Validaciones de arbol: maximo 2 hijos por nodo y sin ciclos
DO $$
DECLARE hijos_raiz INTEGER;
bloqueo_tercer_hijo BOOLEAN := FALSE;
bloqueo_ciclo BOOLEAN := FALSE;
BEGIN
SELECT COUNT(*) INTO hijos_raiz
FROM ArbolBinario
WHERE id_padre = 1;
IF hijos_raiz <> 2 THEN RAISE EXCEPTION 'Arbol invalido: la raiz debe tener 2 hijos, actual=%',
hijos_raiz;
END IF;
BEGIN
INSERT INTO ArbolBinario (valor, id_padre)
VALUES ('Hijo Extra', 1);
EXCEPTION
WHEN OTHERS THEN bloqueo_tercer_hijo := TRUE;
END;
IF NOT bloqueo_tercer_hijo THEN RAISE EXCEPTION 'Arbol invalido: no se bloqueo la insercion de un tercer hijo.';
END IF;
BEGIN
UPDATE ArbolBinario
SET id_padre = 2
WHERE id = 1;
EXCEPTION
WHEN OTHERS THEN bloqueo_ciclo := TRUE;
END;
IF NOT bloqueo_ciclo THEN RAISE EXCEPTION 'Arbol invalido: no se bloqueo la creacion de ciclo.';
END IF;
END;
$$;
-- Validaciones de grafo: sin bucles ni aristas duplicadas
DO $$
DECLARE cantidad_aristas INTEGER;
bloqueo_duplicada BOOLEAN := FALSE;
bloqueo_bucle BOOLEAN := FALSE;
BEGIN
SELECT COUNT(*) INTO cantidad_aristas
FROM Arista;
IF cantidad_aristas <> 3 THEN RAISE EXCEPTION 'Grafo invalido: se esperaban 3 aristas iniciales, actual=%',
cantidad_aristas;
END IF;
BEGIN
INSERT INTO Arista (origen, destino)
VALUES (1, 2);
EXCEPTION
WHEN OTHERS THEN bloqueo_duplicada := TRUE;
END;
IF NOT bloqueo_duplicada THEN RAISE EXCEPTION 'Grafo invalido: no se bloqueo una arista duplicada.';
END IF;
BEGIN
INSERT INTO Arista (origen, destino)
VALUES (1, 1);
EXCEPTION
WHEN OTHERS THEN bloqueo_bucle := TRUE;
END;
IF NOT bloqueo_bucle THEN RAISE EXCEPTION 'Grafo invalido: no se bloqueo un bucle (origen=destino).';
END IF;
END;
$$;
\ echo '== OK: todas las validaciones pasaron correctamente =='
