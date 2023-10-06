
ALTER TABLE ventas ADD COLUMN ubicacion geometry(Point);

UPDATE ventas
SET ubicacion = ST_SetSRID(ST_MakePoint(
    -180 + random() * 360,  -- Longitud aleatoria entre -180 y 180
    -90 + random() * 180    -- Latitud aleatoria entre -90 y 90
), 4326);

CREATE INDEX idx_gist_ubicacion ON ventas USING gist (ubicacion);

EXPLAIN ANALYZE
SELECT *,
ST_MakeEnvelope(-18.1619, 27.6377, 4.3275, 43.7917, 4326)
FROM ventas
WHERE ST_Within(ubicacion, ST_MakeEnvelope(-18.1619, 27.6377, 4.3275, 43.7917, 4326));

