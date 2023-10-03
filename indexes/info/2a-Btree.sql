
-- Verificar si el índice existe
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_producto_id' AND tablename = 'ventas') THEN
        -- Si el índice existe, eliminarlo
        EXECUTE 'DROP INDEX idx_producto_id';
    END IF;
END $$;


--REVISAMOS TIEMPO SIN INDICE
   EXPLAIN ANALYZE
SELECT * FROM ventas WHERE producto_id = 56;


--CREAMOS INDICE
CREATE INDEX idx_producto_id ON ventas USING btree (producto_id);


--REVISAMOS TIEMPO CON INDICE
EXPLAIN ANALYZE
SELECT * FROM ventas WHERE producto_id = 57;