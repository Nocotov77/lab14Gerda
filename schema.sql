-- =============================================
-- Создание схемы интернет-магазина
-- =============================================

-- Таблица пользователей
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    full_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица товаров
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock_quantity INTEGER DEFAULT 0
);

-- Таблица заказов
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'pending'
);

-- Таблица позиций заказа
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL
);

-- =============================================
-- Заполнение тестовыми данными
-- =============================================

-- Пользователи
INSERT INTO users (email, full_name) VALUES
    ('alice@example.com', 'Alice Smith'),
    ('bob@example.com', 'Bob Johnson');

-- Товары
INSERT INTO products (name, category, price, stock_quantity) VALUES
    ('Ноутбук', 'Электроника', 75000.00, 10),
    ('Мышь', 'Электроника', 1500.00, 50),
    ('Книга SQL', 'Книги', 2500.00, 30);

-- Заказы (один для Alice, один для Bob)
INSERT INTO orders (user_id, status) VALUES
    (1, 'completed'),   -- order_id = 1
    (2, 'completed');   -- order_id = 2

-- Позиции заказов (3 записи, чтобы агрегация работала)
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
    (1, 1, 1, 75000.00),  -- Alice: 1 ноутбук
    (2, 2, 2, 1500.00),  -- Bob: 2 мыши
    (2, 3, 1, 2500.00);  -- Bob: 1 книга