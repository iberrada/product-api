-- Insert sample products
INSERT INTO products (name, quantity, price) VALUES 
('Laptop', 10, 999.99),
('Mouse', 50, 25.50),
('Keyboard', 30, 75.00),
('Monitor', 15, 299.99),
('Headphones', 25, 149.99)
ON CONFLICT DO NOTHING;