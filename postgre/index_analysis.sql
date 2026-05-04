-- =============================================
-- Оптимизация запроса с помощью индекса
-- =============================================

-- 1. План ДО создания индекса (ожидается Seq Scan)
EXPLAIN ANALYZE 
SELECT * FROM order_items WHERE order_id = 1;

-- 2. Создаём индекс для ускорения поиска по заказам
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- 3. План ПОСЛЕ создания индекса (должен стать Index Scan)
EXPLAIN ANALYZE 
SELECT * FROM order_items WHERE order_id = 1;