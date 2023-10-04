**Índice BRIN (Block Range INdex)**:
   - **Mejor caso de uso**: Los índices BRIN son eficientes para columnas con datos ordenados secuencialmente, como fechas o valores numéricos crecientes o decrecientes.

   Si tienes una tabla `registros_sensor` que almacena datos de sensores con marcas de tiempo y deseas buscar registros dentro de un rango de fechas:

   ```sql
   CREATE INDEX idx_brin_timestamp ON registros_sensor USING brin (marca_tiempo);
   ```