DO $$ 
BEGIN
    -- Verificar si la tabla existe
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'productsales') THEN
        -- Eliminar la tabla si existe
        DROP TABLE productsales;
    END IF;
END $$;

CREATE TABLE productsales (
	product_id INT NOT NULL,
	order_id INT NOT NULL,
	quantity INT NOT NULL,
	lastname varchar(500),
	purchase_date date NOT NULL,
	shipping_date date
);
