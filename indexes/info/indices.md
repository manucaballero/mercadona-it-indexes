1. **Índice B-Tree**:
   - **Mejor caso de uso**: B-Tree es el tipo de índice predeterminado en PostgreSQL y es adecuado para la mayoría de las consultas de búsqueda. Es eficiente para columnas que se utilizan en operaciones de igualdad (por ejemplo, igualdad en columnas numéricas o de texto).

   Supongamos que tienes una tabla llamada `empleados` y quieres buscar empleados por su número de identificación único (por ejemplo, el número de seguridad social):

   ```sql
   CREATE INDEX idx_btree_ssn ON empleados (numero_identificacion);
   ```

   En este caso, un índice B-Tree en la columna `numero_identificacion` sería eficiente ya que se utiliza en consultas de igualdad.

   Tenemos un ejemplo sencillo en el archivo ejemplo.sql

2. **Índice Hash**:
   - **Mejor caso de uso**: Los índices de hash son adecuados para igualdades exactas y búsquedas rápidas en valores con un alto grado de unicidad, como claves primarias.

   Si tienes una tabla `usuarios` y deseas buscar usuarios por su ID de sesión único (que es una cadena hash generada aleatoriamente):

   ```sql
   CREATE INDEX idx_hash_session_id ON usuarios USING hash (id_sesion);
   ```

   Los índices de hash son útiles cuando tienes un valor único y necesitas buscar exactamente ese valor.


3. **Índice GiST (Generalized Search Tree)**:
   - **Mejor caso de uso**: Los índices GiST son útiles para consultas que involucran búsqueda por proximidad o intersección de geometrías en columnas de tipo geométrico (por ejemplo, coordenadas espaciales).

   Imagina una tabla `lugares` que almacena ubicaciones geográficas (latitud y longitud) y deseas buscar lugares cercanos a una ubicación dada:

   ```sql
   CREATE INDEX idx_gist_geo ON lugares USING gist (ubicacion_geografica);
   ```

   Los índices GiST son ideales para búsquedas espaciales, como la búsqueda de puntos cercanos o polígonos.

4. **Índice GIN (Generalized Inverted Index)**:
   - **Mejor caso de uso**: Los índices GIN son ideales para consultas de búsqueda de texto completo (búsqueda de palabras clave) en columnas de tipo texto o arrays.

    Si tienes una tabla `documentos` que almacena documentos de texto y deseas buscar documentos que contienen ciertas palabras clave:

   ```sql
   CREATE INDEX idx_gin_keywords ON documentos USING gin (contenido_texto);
   ```

5. **Índice SP-GiST (Space-Partitioned Generalized Search Tree)**:
   - **Mejor caso de uso**: Los índices SP-GiST son útiles para columnas que contienen datos no estructurados o semiestructurados y se utilizan en búsquedas de patrones.

   Supongamos que tienes una tabla `productos` que almacena información de productos en formato JSON y deseas buscar productos por su categoría:

   ```sql
   CREATE INDEX idx_spgist_category ON productos USING spgist (datos_producto->'categoria');
   ```

6. **Índice BRIN (Block Range INdex)**:
   - **Mejor caso de uso**: Los índices BRIN son eficientes para columnas con datos ordenados secuencialmente, como fechas o valores numéricos crecientes o decrecientes.

   Si tienes una tabla `registros_sensor` que almacena datos de sensores con marcas de tiempo y deseas buscar registros dentro de un rango de fechas:

   ```sql
   CREATE INDEX idx_brin_timestamp ON registros_sensor USING brin (marca_tiempo);
   ```