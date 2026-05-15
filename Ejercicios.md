# Ejercicios prácticos

A continuación, se presentan algunos ejercicios prácticos para trabajar con las estructuras de datos implementadas en SQL. Cada ejercicio incluye una descripción y los pasos a seguir.

Nota:

- Los ejercicios 1 al 7 se pueden resolver con los scripts actuales.
- Los ejercicios 8 al 10 están pensados como extensión del modelo y pueden requerir cambios de esquema o consultas más avanzadas.

## Ejercicio 1: Operaciones con Listas
1. Inserta 5 elementos en la tabla `Lista`.
2. Consulta todos los elementos de la lista.
3. Actualiza el valor del tercer elemento.
4. Elimina el último elemento de la lista.

## Ejercicio 2: Simulación de una Pila
1. Inserta 3 elementos en la tabla `Pila` (operación `push`).
2. Consulta el elemento en la cima de la pila (operación `top`).
3. Elimina el elemento en la cima (operación `pop`).
4. Verifica los elementos restantes en la pila.

## Ejercicio 3: Simulación de una Cola
1. Inserta 4 elementos en la tabla `Cola` (operación `enqueue`).
2. Consulta el primer elemento de la cola (operación `front`).
3. Elimina el primer elemento de la cola (operación `dequeue`).
4. Verifica los elementos restantes en la cola.

## Ejercicio 4: Construcción de un Árbol Binario
1. Inserta una raíz y dos hijos en la tabla `ArbolBinario`.
2. Consulta todos los nodos del árbol.
3. Agrega un hijo al nodo izquierdo.
4. Elimina el nodo derecho.

## Ejercicio 5: Creación de un Grafo
1. Inserta 4 nodos en la tabla `Nodo`.
2. Crea aristas entre los nodos para formar un ciclo.
3. Consulta todos los nodos y aristas.
4. Elimina una arista y verifica el grafo resultante.

## Ejercicio 6: Operaciones avanzadas con Listas
1. Inserta 10 elementos en la tabla `Lista`.
2. Encuentra y elimina todos los elementos cuyo valor contenga la letra "a".
3. Ordena los elementos restantes alfabéticamente y consulta el resultado.

## Ejercicio 7: Pila con múltiples operaciones
1. Inserta 5 elementos en la tabla `Pila`.
2. Realiza 3 operaciones `pop` consecutivas.
3. Inserta 2 nuevos elementos en la pila.
4. Consulta el estado final de la pila.

## Ejercicio 8: Cola circular
1. Inserta 6 elementos en la tabla `Cola`.
2. Realiza 2 operaciones `dequeue`.
3. Inserta 2 nuevos elementos en la cola.
4. Consulta el estado final de la cola para verificar la rotación lógica de elementos.
5. Opcional avanzado: implementa una cola circular real agregando capacidad fija e índices de frente y fin.

## Ejercicio 9: Árbol Binario de búsqueda
1. Inserta nodos en la tabla `ArbolBinario` para formar un árbol de búsqueda binario.
2. Consulta los nodos en orden ascendente (in-order traversal).
3. Elimina un nodo con dos hijos y verifica el árbol resultante.
4. Opcional avanzado: agrega una clave numérica para validar formalmente la propiedad de árbol binario de búsqueda.

## Ejercicio 10: Grafo dirigido con pesos
1. Modifica la tabla `Arista` para incluir un peso en cada arista.
2. Inserta aristas con pesos entre los nodos existentes.
3. Encuentra el camino más corto entre dos nodos utilizando los pesos.
4. Consulta el grafo resultante con los pesos de las aristas.
5. Opcional avanzado: intenta resolver la ruta mínima con CTE recursivo o procedimiento almacenado.

---

¡Practica estos ejercicios para reforzar tu comprensión de las estructuras de datos en SQL!
