--CREAMOS TABLA
CREATE TABLE ventas (
    id serial PRIMARY KEY,
    producto_id integer,
    fecha_venta date,
    cantidad integer
);


--GENERAMOS DATOS 1M  
   INSERT INTO ventas (producto_id, fecha_venta, cantidad)
SELECT
    floor(random() * 1000 + 1), -- producto_id entre 1 y 1000
    '2023-01-01'::date + floor(random() * 365)::integer, -- fechas en 2023
    floor(random() * 100 + 1) -- cantidad entre 1 y 100
FROM generate_series(1, 1000000);
   


--REVISAMOS TIEMPO SIN INDICE
   EXPLAIN ANALYZE
SELECT * FROM ventas WHERE producto_id = 56;




--CREAMOS INDICE
CREATE INDEX idx_producto_id ON ventas (producto_id);


--REVISAMOS TIEMPO CON INDICE
EXPLAIN ANALYZE
SELECT * FROM ventas WHERE producto_id = 57;