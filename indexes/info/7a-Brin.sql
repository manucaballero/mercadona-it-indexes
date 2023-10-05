

--GENERAMOS TABLA Y DATOS (PARA UTILZAR EL BRIN DE FORMA EFECTIVA LOS DATOS TIENEN QUE TENER UN ORDEN NATURAL)
CREATE TABLE temperature_log (log_id serial, sensor_id int,
log_timestamp timestamp without time zone, temperature int);

INSERT INTO temperature_log(sensor_id,log_timestamp,temperature)
VALUES (1,generate_series('2016-01-01'::timestamp,'2016-12-31'::timestamp,'1 second'),
        round(random()*100)::int);


--CREAMOS INDICE BTREE       
CREATE INDEX idx_temperature_log_log_timestamp_btree ON temperature_log
USING btree (log_timestamp);

EXPLAIN ANALYZE SELECT AVG(temperature) FROM temperature_log
WHERE log_timestamp>='2016-04-04' AND log_timestamp<'2016-04-05';

--COMPROBAMOS PESO DEL INDICE

SELECT
nspname AS schema_name,
relname AS index_name,
round(100 * pg_relation_size(indexrelid) / pg_relation_size(indrelid)) / 100 AS index_ratio,
pg_size_pretty(pg_relation_size(indexrelid)) AS index_size,
pg_size_pretty(pg_relation_size(indrelid)) AS table_size
FROM
pg_index I
LEFT JOIN
pg_class C
ON
(C.oid = I.indexrelid)
LEFT JOIN
pg_namespace N
ON
(N.oid = C.relnamespace)
WHERE
C.relkind = 'i' AND
pg_relation_size(indrelid) > 0 AND
relname='idx_temperature_log_log_timestamp_btree'
ORDER BY
pg_relation_size(indexrelid) DESC, index_ratio DESC;

--CREAMOS EL INDICE 
CREATE INDEX idx_temperature_log_log_timestamp_brin ON temperature_log
USING BRIN (log_timestamp) WITH (pages_per_range = 128);

EXPLAIN ANALYZE SELECT AVG(temperature) FROM temperature_log
WHERE log_timestamp>='2016-04-04' AND log_timestamp<'2016-04-06';

--PARA RANGOS PEQUEÑOS SIGUE USANDO EL BTREE PERO SI AMPLIAMOS LA BUSQUEDA UTILIZA EL BRIN

EXPLAIN ANALYZE SELECT AVG(temperature) FROM temperature_log
WHERE log_timestamp>='2016-04-04' AND log_timestamp<'2016-9-06';

--COMPROBAMOS PESO DEL INDICE BRIN
SELECT
nspname AS schema_name,
relname AS index_name,
round(100 * pg_relation_size(indexrelid) / pg_relation_size(indrelid)) / 100 AS index_ratio,
pg_size_pretty(pg_relation_size(indexrelid)) AS index_size,
pg_size_pretty(pg_relation_size(indrelid)) AS table_size
FROM
pg_index I
LEFT JOIN
pg_class C
ON
(C.oid = I.indexrelid)
LEFT JOIN
pg_namespace N
ON
(N.oid = C.relnamespace)
WHERE
C.relkind = 'i' AND
pg_relation_size(indrelid) > 0 AND
relname='idx_temperature_log_log_timestamp_brin'
ORDER BY
pg_relation_size(indexrelid) DESC, index_ratio DESC;



--Las velocidades son similares pero el peso del indice es mucho menor, siendo el del btree casi 700MB frente a los  70KB del drim