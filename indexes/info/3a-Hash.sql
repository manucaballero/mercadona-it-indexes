
-- Verificar si el índice existe
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_id' AND tablename = 'ventas') THEN
        -- Si el índice existe, eliminarlo
        EXECUTE 'DROP INDEX idx_id';
    END IF;
END $$;


--CREAMOS INDICE
CREATE INDEX idx_id ON ventas USING btree (id);


--REVISAMOS TIEMPO CON INDICE
EXPLAIN ANALYZE
SELECT * FROM ventas WHERE id = 57;


--BORAMOS EL INDICE BTREE
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_id' AND tablename = 'ventas') THEN
        -- Si el índice existe, eliminarlo
        EXECUTE 'DROP INDEX idx_id';
    END IF;
END $$;



--CREAMOS INDICE HASH 
CREATE INDEX idx_id ON ventas USING hash (id);


--REVISAMOS TIEMPO CON INDICE HASH
EXPLAIN ANALYZE
SELECT * FROM ventas WHERE id = 58;


--COMPROBAMOS QUE EL COSTE ES MENOR CON EL INDICE HASH