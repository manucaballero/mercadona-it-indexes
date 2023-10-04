**Índice SP-GiST (Space-Partitioned Generalized Search Tree)**:
   - **Mejor caso de uso**: Los índices SP-GiST son útiles para columnas que contienen datos no estructurados o semiestructurados y se utilizan en búsquedas de patrones.

   Supongamos que tienes una tabla `productos` que almacena información de productos en formato JSON y deseas buscar productos por su categoría:

   ```sql
   CREATE INDEX idx_spgist_category ON productos USING spgist (datos_producto->'categoria');
   ```