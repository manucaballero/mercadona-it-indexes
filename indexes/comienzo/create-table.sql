DO $$ 
BEGIN
    -- Verificar si la tabla existe
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'ventas') THEN
        -- Eliminar la tabla si existe
        DROP TABLE ventas;
    END IF;
END $$;

CREATE TABLE ventas (
    id serial PRIMARY KEY,
    producto_id integer,
	pedido_id integer,
    fecha_venta date,
    cantidad integer,
    descripcion text
);

INSERT INTO ventas (producto_id, pedido_id, fecha_venta, cantidad, descripcion)
SELECT
    floor(random() * 1000 + 1), -- producto_id entre 1 y 1000
    floor(random() * 10000 + 1), -- pedido_id entre 1 y 10000
    '2023-01-01'::date + floor(random() * 365)::integer, -- fechas en 2023
    floor(random() * 100 + 1), -- cantidad entre 1 y 100
    CASE 
        WHEN random() < 0.2 THEN 'Producto de alta calidad'
        WHEN random() < 0.4 THEN 'Oferta especial'
        WHEN random() < 0.6 THEN 'Nuevo lanzamiento'
        ELSE 'Producto estándar'
    END
FROM generate_series(1, 10000000); -- Generamos 10 millones de registros