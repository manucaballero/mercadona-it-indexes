# Indices

Empezamos a explicar que es un índice y para que sirve con un ejemplo donde tenemos la siguiente tabla:

```
CREATE TABLE ejemplo (
    id integer,
    departamento integer,
    nombre varchar
);
```

Nuestra aplicación hace muchas peticiones como la siguiente:


` SELECT * FROM ejemplo WHERE departamento = :departamento;`

Sin índices, el gestor de la base de datos recorrería la tabla de principio a fin hasta encontrar todos los registros que cumplan la condición (aunque se de el caso de que sólo hay un registro en toda la tabla que lo cumpla). En una tabla con pocos registros no va a ser problemático, pero el asunto cambia si estamos ante un orden de millones.

Para esta tipología de casos se usan los índices, ya que este problema puede resolverse con unos pocos pasos en un árbol de búsqueda. 

Un enfoque similar se utiliza en la mayoría de libros: los capítulos y subcapítulos se recopilan en un índice. El lector  puede escanear el índice relativamente rápido y pasar a la página o páginas adecuadas, en lugar de tener que leer todo el libro para encontrar el material de interés. Así como es tarea del autor anticipar la información que los lectores buscarán, es tarea del programador seleccionar los índices qué serán útiles.

Con el siguiente comando puedes crear un índice donde ejemplo_departamento_index es el nombre único que identifica al índice:

`CREATE INDEX ejemplo_departamento_index ON ejemplo (departamento);`

Para eliminar un índice:

`DROP INDEX ejemplo_departamento_index;`

El sistema se encargará de actualizar el índice cada vez que la tabla es modificada.

El sistema se encargará de usar el índice en consultas cuando estime que usarlo será más eficiente que recorrer toda la tabla.

El sistema también tiene en cuenta el índice cuando se ejecutan sentencias con join, por lo que puede ayudar a mejorar el rendimiento de estas consultas.

## Ventajas:

1. Búsqueda Rápida
Como se ha comentado previamente, uno de los principales beneficios de utilizar índices es la capacidad de acelerar las consultas de búsqueda. Los índices almacenan una versión ordenada de los datos de una columna o conjunto de columnas en la base de datos. Esto permite a los motores de base de datos encontrar los registros deseados de manera más eficiente, evitando la necesidad de examinar todas las filas de una tabla. En lugar de realizar una búsqueda secuencial, la base de datos puede saltar directamente a los registros relevantes utilizando el índice correspondiente, lo que reduce significativamente el tiempo de respuesta de las consultas.

## Desventajas:

1. Espacio en Disco
Una de las principales desventajas de los índices es que ocupan espacio en disco adicional. Cada índice creado consume espacio de almacenamiento, lo que puede ser significativo en bases de datos con muchas tablas y columnas indexadas.

2. Mantenimiento
Los índices deben actualizarse cada vez que se modifican los datos en una tabla. Esto puede generar una sobrecarga, especialmente en bases de datos con un alto volumen de cambios. Las operaciones de inserción, actualización y eliminación pueden volverse más lentas debido a la necesidad de actualizar los índices correspondientes.

3. Crear un índice puede llevar tiempo. Además, de forma predeterminada, PostgreSQL sólo permite operaciones de lectura en la tabla mientras el índice se está creando. Esto puede llevar a problemas en sistemas en producción. Para este caso es posible crear indices en paralelo, explicado en el siguiente [enlace](https://www.postgresql.org/docs/current/sql-createindex.html#SQL-CREATEINDEX-CONCURRENTLY).
