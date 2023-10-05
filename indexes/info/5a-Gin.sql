
--CREAMOS INDICE BTREE
CREATE INDEX idx_id_btree ON ventas USING btree (descripcion);

--REVISAMOS TIEMPO CON INDICE
EXPLAIN ANALYZE
SELECT * FROM ventas WHERE descripcion ILIKE 'oferta%';

--CREAMOS INDICE gin 

CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE INDEX idx_id_gin ON ventas USING gin (descripcion gin_trgm_ops);

--REVISAMOS TIEMPO CON INDICE GIN
EXPLAIN ANALYZE
SELECT * FROM ventas WHERE descripcion ILIKE 'especial%';

--COMPROBAMOS QUE EL COSTE ES MENOR CON EL INDICE GIN Y ADEMAS AUTOMATICAMENTE USA ESTE INDICE (PUEDE HABER CASOS DONDE NO LO USE, DEPENDE DE LA ESTIMACION QUE HAGA
-- DE CUANTOS ELEMENTOS COINCIDEN)

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
    IF EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_id_gin' AND tablename = 'ventas') THEN
        -- Si el índice existe, eliminarlo
        EXECUTE 'DROP INDEX idx_gin';
    END IF;
END $$;
