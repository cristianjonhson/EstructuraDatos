-- Script unico de verificacion automatica (PostgreSQL + psql)
-- Ejecuta todos los scripts y valida casos clave.
\
set ON_ERROR_STOP on \ echo '== Ejecutando scripts base ==' \ i sql / lista.sql \ i sql / pila.sql \ i sql / cola.sql \ i sql / arbol.sql \ i sql / grafo.sql \ i sql / bst.sql \ echo '== Iniciando validaciones ==' -- Validacion de pila: top debe ser el ultimo insertado (LIFO)
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
-- Validaciones de BST: orden, lado unico e in-order ascendente
DO $$
DECLARE cantidad_nodos INTEGER;
bloqueo_orden BOOLEAN := FALSE;
bloqueo_lado_duplicado BOOLEAN := FALSE;
bloqueo_ciclo BOOLEAN := FALSE;
desorden_count INTEGER;
BEGIN
SELECT COUNT(*) INTO cantidad_nodos
FROM ArbolBST;
IF cantidad_nodos <> 6 THEN RAISE EXCEPTION 'BST invalido: se esperaban 6 nodos tras el script base (incluye eliminacion de hoja), actual=%',
cantidad_nodos;
END IF;
BEGIN
INSERT INTO ArbolBST (valor_clave, id_padre, lado)
VALUES (
        11,
        (
            SELECT id
            FROM ArbolBST
            WHERE valor_clave = 10
        ),
        'L'
    );
EXCEPTION
WHEN OTHERS THEN bloqueo_orden := TRUE;
END;
IF NOT bloqueo_orden THEN RAISE EXCEPTION 'BST invalido: no se bloqueo una insercion que rompe el orden.';
END IF;
BEGIN
INSERT INTO ArbolBST (valor_clave, id_padre, lado)
VALUES (
        13,
        (
            SELECT id
            FROM ArbolBST
            WHERE valor_clave = 15
        ),
        'L'
    );
EXCEPTION
WHEN OTHERS THEN bloqueo_lado_duplicado := TRUE;
END;
IF NOT bloqueo_lado_duplicado THEN RAISE EXCEPTION 'BST invalido: no se bloqueo ocupar un lado ya existente en un padre.';
END IF;
BEGIN
UPDATE ArbolBST
SET id_padre = (
        SELECT id
        FROM ArbolBST
        WHERE valor_clave = 12
    ),
    lado = 'L'
WHERE valor_clave = 10;
EXCEPTION
WHEN OTHERS THEN bloqueo_ciclo := TRUE;
END;
IF NOT bloqueo_ciclo THEN RAISE EXCEPTION 'BST invalido: no se bloqueo la creacion de ciclo.';
END IF;
WITH ordenados AS (
    SELECT valor_clave,
        LAG(valor_clave) OVER (
            ORDER BY valor_clave
        ) AS previo
    FROM ArbolBST
)
SELECT COUNT(*) INTO desorden_count
FROM ordenados
WHERE previo IS NOT NULL
    AND valor_clave <= previo;
IF desorden_count <> 0 THEN RAISE EXCEPTION 'BST invalido: recorrido in-order no esta estrictamente ascendente.';
END IF;
END;
$$;
\ echo '== OK: todas las validaciones pasaron correctamente =='
