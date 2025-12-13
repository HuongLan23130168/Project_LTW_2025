CREATE DATABASE ltw_pdl;
USE ltw_pdl;

---------------------------------------------------
-- USERS
---------------------------------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth DATE,
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARBINARY(64) NOT NULL,
    phone CHAR(12),
    role VARCHAR(20) DEFAULT 'user',
    address VARCHAR(255)
);

---------------------------------------------------
-- ADDRESSES
---------------------------------------------------
CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    address VARCHAR(200),
    is_default TINYINT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

---------------------------------------------------
-- CONTACTS
---------------------------------------------------
CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    full_name VARCHAR(150),
    email VARCHAR(255),
    message TEXT,
    status VARCHAR(50) DEFAULT 'Chưa xử lý',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

---------------------------------------------------
-- PRODUCT TYPES
---------------------------------------------------
CREATE TABLE product_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_code VARCHAR(10) UNIQUE,
    type_name VARCHAR(100) NOT NULL
);

---------------------------------------------------
-- CATEGORIES
---------------------------------------------------
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_code VARCHAR(10) UNIQUE,
    category_name VARCHAR(100) NOT NULL
);

---------------------------------------------------
-- PRODUCTS
---------------------------------------------------
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_code VARCHAR(10) UNIQUE,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    product_type_id INT,
    description TEXT,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (product_type_id) REFERENCES product_types(id)
);

---------------------------------------------------
-- PRODUCT VARIANTS
---------------------------------------------------
CREATE TABLE product_variants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    variant_code VARCHAR(10) UNIQUE,
    product_id INT NOT NULL,
    style VARCHAR(100),
    color VARCHAR(50),
    size VARCHAR(50),
    material VARCHAR(100),
    price DECIMAL(12,2),
    image_url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

---------------------------------------------------
-- INVENTORY
---------------------------------------------------
CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    variant_id INT NOT NULL,
    stock_quantity INT DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (variant_id) REFERENCES product_variants(id)
);

---------------------------------------------------
-- PRODUCT IMAGES
---------------------------------------------------
CREATE TABLE product_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

---------------------------------------------------
-- NEW PRODUCTS
---------------------------------------------------
CREATE TABLE new_products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

---------------------------------------------------
-- BEST SELLERS
---------------------------------------------------
CREATE TABLE best_sellers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    sold_quantity INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

---------------------------------------------------
-- CART
---------------------------------------------------
CREATE TABLE cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

---------------------------------------------------
-- CART DETAILS
---------------------------------------------------
CREATE TABLE cart_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    variant_id INT NOT NULL,
    quantity INT DEFAULT 1,
    unit_price DECIMAL(12,2),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES cart(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id)
);

---------------------------------------------------
-- ORDERS
---------------------------------------------------
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_code VARCHAR(10) UNIQUE,
    user_id INT NOT NULL,
    recipient_name VARCHAR(150),
    recipient_phone CHAR(12),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(12,2),
    note VARCHAR(255),
    shipping_address VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

---------------------------------------------------
-- ORDER DETAILS
---------------------------------------------------
CREATE TABLE order_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    variant_id INT NOT NULL,
    quantity INT,
    unit_price DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id)
);

---------------------------------------------------
-- SHIPPING
---------------------------------------------------
CREATE TABLE shipping (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    shipping_type VARCHAR(20),
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    shipping_status VARCHAR(50) DEFAULT 'Đang giao',
    tracking_number VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

---------------------------------------------------
-- PAYMENTS
---------------------------------------------------
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method VARCHAR(50),
    amount DECIMAL(12,2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Chưa thanh toán',
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

---------------------------------------------------
-- ORDER STATUS HISTORY
---------------------------------------------------
CREATE TABLE order_status_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

---------------------------------------------------
-- DISCOUNTS
---------------------------------------------------
CREATE TABLE discounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    discount_code VARCHAR(10) UNIQUE,
    discount_name VARCHAR(150),
    discount_percent DECIMAL(5,2),
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

---------------------------------------------------
-- DISCOUNT - CATEGORIES (N-N)
---------------------------------------------------
CREATE TABLE discount_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    discount_id INT,
    category_id INT,
    FOREIGN KEY (discount_id) REFERENCES discounts(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

---------------------------------------------------
-- DISCOUNT - PRODUCT TYPES (N-N)
---------------------------------------------------
CREATE TABLE discount_product_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    discount_id INT,
    product_type_id INT,
    FOREIGN KEY (discount_id) REFERENCES discounts(id),
    FOREIGN KEY (product_type_id) REFERENCES product_types(id)
);

---------------------------------------------------
-- NOTIFICATIONS
---------------------------------------------------
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    title VARCHAR(255),
    content TEXT,
    type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Chưa xem',
    FOREIGN KEY (user_id) REFERENCES users(id)
);

---------------------------------------------------
-- POLICIES
---------------------------------------------------
CREATE TABLE policies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

---------------------------------------------------
-- BANNERS
---------------------------------------------------
CREATE TABLE banners (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    image_url VARCHAR(255),
    link VARCHAR(255),
    display_order INT DEFAULT 1,
    sort_order INT DEFAULT 1,
    is_active TINYINT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
