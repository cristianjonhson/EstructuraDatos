-- Script de ejemplo para una estructura de datos tipo Arbol Binario en SQL
DROP TABLE IF EXISTS ArbolBinario;
CREATE TABLE ArbolBinario (
    id SERIAL PRIMARY KEY,
    valor VARCHAR(100) NOT NULL,
    id_padre INTEGER REFERENCES ArbolBinario(id) ON DELETE CASCADE,
    CONSTRAINT chk_arbol_id_padre_distinto CHECK (
        id_padre IS NULL
        OR id_padre <> id
    )
);
CREATE OR REPLACE FUNCTION validar_max_dos_hijos() RETURNS TRIGGER AS $$
DECLARE cantidad_hijos INTEGER;
ciclo_detectado INTEGER;
BEGIN IF NEW.id_padre IS NULL THEN RETURN NEW;
END IF;
IF TG_OP = 'UPDATE' THEN WITH RECURSIVE ancestros AS (
    SELECT id,
        id_padre
    FROM ArbolBinario
    WHERE id = NEW.id_padre
    UNION ALL
    SELECT a.id,
        a.id_padre
    FROM ArbolBinario a
        INNER JOIN ancestros x ON a.id = x.id_padre
)
SELECT 1 INTO ciclo_detectado
FROM ancestros
WHERE id = NEW.id
LIMIT 1;
IF ciclo_detectado = 1 THEN RAISE EXCEPTION 'Operacion invalida: no se permiten ciclos en ArbolBinario.';
END IF;
END IF;
SELECT COUNT(*) INTO cantidad_hijos
FROM ArbolBinario
WHERE id_padre = NEW.id_padre
    AND (
        TG_OP = 'INSERT'
        OR id <> NEW.id
    );
IF cantidad_hijos >= 2 THEN RAISE EXCEPTION 'Un nodo en ArbolBinario no puede tener mas de 2 hijos (id_padre=%).',
NEW.id_padre;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_validar_max_dos_hijos BEFORE
INSERT
    OR
UPDATE ON ArbolBinario FOR EACH ROW EXECUTE FUNCTION validar_max_dos_hijos();
-- Insertar nodos de ejemplo
INSERT INTO ArbolBinario (valor, id_padre)
VALUES ('Raiz', NULL);
INSERT INTO ArbolBinario (valor, id_padre)
VALUES ('Hijo Izquierdo', 1);
INSERT INTO ArbolBinario (valor, id_padre)
VALUES ('Hijo Derecho', 1);
-- Consultar todos los nodos
SELECT *
FROM ArbolBinario
ORDER BY id;
