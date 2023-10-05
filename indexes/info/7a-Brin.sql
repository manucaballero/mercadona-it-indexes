CREATE INDEX idx_brin_fecha_venta ON ventas USING brin (fecha_venta);

EXPLAIN ANALYZE
SELECT * FROM ventas WHERE fecha_venta BETWEEN '2023-01-01' AND '2023-01-30';
