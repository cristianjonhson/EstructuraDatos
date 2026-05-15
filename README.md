# Estructuras de Datos con SQL

Proyecto educativo para modelar estructuras de datos clásicas usando tablas y consultas SQL.

El objetivo es entender cómo representar conceptos como lista, pila, cola, árbol binario y grafo dentro de una base de datos relacional, con ejemplos simples y fáciles de ejecutar.

## Descripción del proyecto

En este repositorio encontrarás scripts SQL independientes para cada estructura de datos. Cada archivo crea tablas, inserta datos de ejemplo y muestra consultas base para simular operaciones típicas.

Este enfoque permite:

- Practicar SQL aplicado a estructuras de datos.
- Comprender relaciones entre nodos, aristas y jerarquías.
- Usar una base de datos como entorno de experimentación para ejercicios académicos.

## Tecnologías utilizadas

- SQL
- PostgreSQL (recomendado)

Nota importante:

- Los scripts usan SERIAL y CURRENT_TIMESTAMP, por lo que funcionan directamente en PostgreSQL.
- En otros motores SQL puede requerirse ajustar tipos o auto-incrementos.

## Estructura del repositorio

- [README.md](README.md): documentación general.
- [Ejercicios.md](Ejercicios.md): guía de ejercicios prácticos.
- [sql/lista.sql](sql/lista.sql): implementación básica de lista.
- [sql/pila.sql](sql/pila.sql): implementación de pila (stack).
- [sql/cola.sql](sql/cola.sql): implementación de cola (queue).
- [sql/arbol.sql](sql/arbol.sql): implementación de árbol binario.
- [sql/grafo.sql](sql/grafo.sql): implementación de grafo dirigido.

## Requisitos

- PostgreSQL 12 o superior.
- Cliente SQL:
  - psql (línea de comandos), o
  - DBeaver, pgAdmin, DataGrip u otro cliente compatible.

## Configuración

1. Crea una base de datos de práctica:

```sql
CREATE DATABASE estructuras_sql;
```

2. Conéctate a la base de datos:

```bash
psql -d estructuras_sql
```

3. Verifica que tengas permisos para crear tablas e insertar datos.

## Cómo ejecutarlo

Puedes ejecutar cada script de forma individual para estudiar una estructura a la vez.

Ejemplo con psql:

```bash
psql -d estructuras_sql -f sql/lista.sql
psql -d estructuras_sql -f sql/pila.sql
psql -d estructuras_sql -f sql/cola.sql
psql -d estructuras_sql -f sql/arbol.sql
psql -d estructuras_sql -f sql/grafo.sql
```

También puedes abrir cada archivo en tu cliente SQL y ejecutarlo manualmente.

## Qué incluye cada script

1. Lista
- Crea tabla Lista.
- Inserta elementos de ejemplo.
- Consulta todos los registros.

2. Pila
- Crea tabla Pila con fecha de ingreso.
- Simula push con INSERT.
- Simula top con ORDER BY id descendente y LIMIT 1.
- Incluye ejemplo de pop comentado.

3. Cola
- Crea tabla Cola con fecha de ingreso.
- Simula enqueue con INSERT.
- Simula front con ORDER BY id ascendente y LIMIT 1.
- Incluye ejemplo de dequeue comentado.

4. Árbol binario
- Crea tabla ArbolBinario con autorreferencia (id_padre).
- Incluye validación para limitar a máximo 2 hijos por nodo.
- Incluye validación para evitar ciclos al actualizar relaciones padre-hijo.
- Inserta raíz e hijos.
- Consulta nodos del árbol.

5. Grafo
- Crea tablas Nodo y Arista.
- Incluye restricciones para evitar aristas duplicadas y bucles simples.
- Inserta nodos y aristas de ejemplo.
- Consulta nodos y conexiones.

## Recomendaciones de uso

- Ejecuta primero en una base de datos de pruebas.
- Si repites scripts, elimina tablas previas o agrega DROP TABLE IF EXISTS antes de CREATE TABLE.
- Trabaja junto con [Ejercicios.md](Ejercicios.md) para reforzar conceptos.
- Considera los ejercicios 8, 9 y 10 como retos de extensión del modelo base.

## Posibles mejoras

- Añadir restricciones adicionales (UNIQUE, CHECK).
- Crear vistas para consultas frecuentes.
- Incorporar procedimientos almacenados para operaciones push/pop y enqueue/dequeue.
- Agregar casos con grafos ponderados y recorridos.

## Propósito

Repositorio orientado a aprendizaje y práctica académica de estructuras de datos con SQL.
