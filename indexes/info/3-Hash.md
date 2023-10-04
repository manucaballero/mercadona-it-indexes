
**Índice Hash**:
   - **Mejor caso de uso**: Los índices de hash son adecuados para igualdades exactas y búsquedas rápidas en valores con un alto grado de unicidad, como claves primarias.

   Si tienes una tabla `usuarios` y deseas buscar usuarios por su ID de sesión único (que es una cadena hash generada aleatoriamente):

   ```sql
   CREATE INDEX idx_hash_session_id ON usuarios USING hash (id_sesion);
   ```

   Los índices de hash son útiles cuando tienes un valor único y necesitas buscar exactamente ese valor.