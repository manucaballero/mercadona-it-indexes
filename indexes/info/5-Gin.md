**Índice GIN (Generalized Inverted Index)**:
   - **Mejor caso de uso**: Los índices GIN son ideales para consultas de búsqueda de texto completo (búsqueda de palabras clave) en columnas de tipo texto o arrays.

    Si tienes una tabla `documentos` que almacena documentos de texto y deseas buscar documentos que contienen ciertas palabras clave:

   ```sql
   CREATE INDEX idx_gin_keywords ON documentos USING gin (contenido_texto);
   ```