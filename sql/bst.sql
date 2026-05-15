-- Script de ejemplo para una estructura de datos tipo Arbol Binario de Busqueda (BST) en SQL
DROP TRIGGER IF EXISTS trg_validar_bst_nodo ON ArbolBST;
DROP FUNCTION IF EXISTS validar_bst_nodo();
DROP TABLE IF EXISTS ArbolBST;
CREATE TABLE ArbolBST (
    id SERIAL PRIMARY KEY,
    valor_clave INTEGER NOT NULL UNIQUE,
    id_padre INTEGER REFERENCES ArbolBST(id) ON DELETE CASCADE,
    lado CHAR(1),
    CONSTRAINT chk_bst_lado_valido CHECK (
        lado IN ('L', 'R')
        OR lado IS NULL
    ),
    CONSTRAINT chk_bst_padre_lado_consistente CHECK (
        (
            id_padre IS NULL
            AND lado IS NULL
        )
        OR (
            id_padre IS NOT NULL
            AND lado IS NOT NULL
        )
    ),
    CONSTRAINT uq_bst_hijo_por_lado UNIQUE (id_padre, lado)
);
CREATE OR REPLACE FUNCTION validar_bst_nodo() RETURNS TRIGGER AS $$
DECLARE id_actual INTEGER;
id_padre_actual INTEGER;
lado_actual CHAR(1);
valor_padre INTEGER;
limite_min INTEGER;
limite_max INTEGER;
ciclo_detectado INTEGER;
BEGIN IF NEW.id_padre IS NULL THEN RETURN NEW;
END IF;
SELECT valor_clave INTO valor_padre
FROM ArbolBST
WHERE id = NEW.id_padre;
IF NOT FOUND THEN RAISE EXCEPTION 'BST invalido: el id_padre=% no existe.',
NEW.id_padre;
END IF;
IF TG_OP = 'UPDATE'
AND NEW.id = NEW.id_padre THEN RAISE EXCEPTION 'BST invalido: un nodo no puede ser padre de si mismo.';
END IF;
IF TG_OP = 'UPDATE' THEN WITH RECURSIVE ancestros AS (
    SELECT id,
        id_padre
    FROM ArbolBST
    WHERE id = NEW.id_padre
    UNION ALL
    SELECT a.id,
        a.id_padre
    FROM ArbolBST a
        INNER JOIN ancestros x ON a.id = x.id_padre
)
SELECT 1 INTO ciclo_detectado
FROM ancestros
WHERE id = NEW.id
LIMIT 1;
IF ciclo_detectado = 1 THEN RAISE EXCEPTION 'BST invalido: no se permiten ciclos en el arbol.';
END IF;
END IF;
-- Calcula limites min/max en base a la ruta de ancestros.
limite_min := NULL;
limite_max := NULL;
id_actual := NEW.id_padre;
LOOP
SELECT id_padre,
    lado INTO id_padre_actual,
    lado_actual
FROM ArbolBST
WHERE id = id_actual;
EXIT
WHEN NOT FOUND;
EXIT
WHEN id_padre_actual IS NULL;
SELECT valor_clave INTO valor_padre
FROM ArbolBST
WHERE id = id_padre_actual;
IF lado_actual = 'L' THEN IF limite_max IS NULL
OR valor_padre - 1 < limite_max THEN limite_max := valor_padre - 1;
END IF;
ELSE IF limite_min IS NULL
OR valor_padre + 1 > limite_min THEN limite_min := valor_padre + 1;
END IF;
END IF;
id_actual := id_padre_actual;
END LOOP;
SELECT valor_clave INTO valor_padre
FROM ArbolBST
WHERE id = NEW.id_padre;
IF NEW.lado = 'L' THEN IF limite_max IS NULL
OR valor_padre - 1 < limite_max THEN limite_max := valor_padre - 1;
END IF;
ELSE IF limite_min IS NULL
OR valor_padre + 1 > limite_min THEN limite_min := valor_padre + 1;
END IF;
END IF;
IF limite_min IS NOT NULL
AND NEW.valor_clave < limite_min THEN RAISE EXCEPTION 'BST invalido: valor_clave=% debe ser mayor o igual que %.',
NEW.valor_clave,
limite_min;
END IF;
IF limite_max IS NOT NULL
AND NEW.valor_clave > limite_max THEN RAISE EXCEPTION 'BST invalido: valor_clave=% debe ser menor o igual que %.',
NEW.valor_clave,
limite_max;
END IF;
IF NEW.lado = 'L'
AND NEW.valor_clave >= valor_padre THEN RAISE EXCEPTION 'BST invalido: hijo izquierdo con valor % no puede ser >= padre %.',
NEW.valor_clave,
valor_padre;
END IF;
IF NEW.lado = 'R'
AND NEW.valor_clave <= valor_padre THEN RAISE EXCEPTION 'BST invalido: hijo derecho con valor % no puede ser <= padre %.',
NEW.valor_clave,
valor_padre;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_validar_bst_nodo BEFORE
INSERT
    OR
UPDATE ON ArbolBST FOR EACH ROW EXECUTE FUNCTION validar_bst_nodo();
-- Insertar nodos de ejemplo
INSERT INTO ArbolBST (valor_clave, id_padre, lado)
VALUES (10, NULL, NULL);
INSERT INTO ArbolBST (valor_clave, id_padre, lado)
VALUES (
        5,
        (
            SELECT id
            FROM ArbolBST
            WHERE valor_clave = 10
        ),
        'L'
    );
INSERT INTO ArbolBST (valor_clave, id_padre, lado)
VALUES (
        15,
        (
            SELECT id
            FROM ArbolBST
            WHERE valor_clave = 10
        ),
        'R'
    );
INSERT INTO ArbolBST (valor_clave, id_padre, lado)
VALUES (
        3,
        (
            SELECT id
            FROM ArbolBST
            WHERE valor_clave = 5
        ),
        'L'
    );
INSERT INTO ArbolBST (valor_clave, id_padre, lado)
VALUES (
        7,
        (
            SELECT id
            FROM ArbolBST
            WHERE valor_clave = 5
        ),
        'R'
    );
INSERT INTO ArbolBST (valor_clave, id_padre, lado)
VALUES (
        12,
        (
            SELECT id
            FROM ArbolBST
            WHERE valor_clave = 15
        ),
        'L'
    );
INSERT INTO ArbolBST (valor_clave, id_padre, lado)
VALUES (
        18,
        (
            SELECT id
            FROM ArbolBST
            WHERE valor_clave = 15
        ),
        'R'
    );
-- Consulta in-order (ascendente en un BST valido)
SELECT *
FROM ArbolBST
ORDER BY valor_clave;
-- Busqueda por clave
SELECT *
FROM ArbolBST
WHERE valor_clave = 12;
-- Eliminacion de hoja de ejemplo
DELETE FROM ArbolBST
WHERE valor_clave = 3;
SELECT *
FROM ArbolBST
ORDER BY valor_clave;
