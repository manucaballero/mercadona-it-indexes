CREATE EXTENSION postgis;


ALTER TABLE ventas ADD COLUMN ubicacion geometry(Point);

-- Rellenar todos los registros con ubicaciones aleatorias
UPDATE ventas
SET ubicacion = ST_SetSRID(ST_MakePoint(
    -180 + random() * 360,  -- Longitud aleatoria entre -180 y 180
    -90 + random() * 180    -- Latitud aleatoria entre -90 y 90
), 4326);

CREATE INDEX idx_gist_ubicacion ON ventas USING gist (ubicacion);


-- Consulta utilizando el índice GiST para buscar ventas dentro de un radio de 100 km de Nueva York (latitud 40.7128, longitud -74.0060)
SELECT *
FROM ventas
WHERE ST_DWithin(ubicacion, 'POINT(40.7128 -74.0060)', 100000); -- 100000 metros = 100 km
