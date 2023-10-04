
--CREAMOS INDICE BTREE
CREATE INDEX idx_id_btree ON ventas USING btree (id);

--REVISAMOS TIEMPO CON INDICE
EXPLAIN ANALYZE
SELECT * FROM ventas WHERE id = 57;

--CREAMOS INDICE HASH 
CREATE INDEX idx_id_hash ON ventas USING hash (id);

--REVISAMOS TIEMPO CON INDICE HASH
EXPLAIN ANALYZE
SELECT * FROM ventas WHERE id = 58;

--COMPROBAMOS QUE EL COSTE ES MENOR CON EL INDICE HASH Y ADEMAS AUTOMATICAMENTE USA ESTE INDICE

--BORRAMOS LOS INDICES UTIIZADOS
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_id_btree' AND tablename = 'ventas') THEN
        -- Si el índice existe, eliminarlo
        EXECUTE 'DROP INDEX idx_btree';
    END IF;
END $$;

DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_id_hash' AND tablename = 'ventas') THEN
        -- Si el índice existe, eliminarlo
        EXECUTE 'DROP INDEX idx_hash';
    END IF;
END $$;
