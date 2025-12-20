CREATE DATABASE PHANDINHLONG;
GO
USE PHANDINHLONG;
GO

---------------------------------------------------
-- USERS
---------------------------------------------------
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    birth DATE,
    gender NVARCHAR(10),
    email NVARCHAR(100) UNIQUE NOT NULL,
    password VARBINARY(64) NOT NULL,
    phone CHAR(12),
    role NVARCHAR(20) DEFAULT N'user',
    address NVARCHAR(255)
);
GO

---------------------------------------------------
-- ADDRESSES
---------------------------------------------------
CREATE TABLE addresses (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    address NVARCHAR(200),
    is_default BIT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
GO

---------------------------------------------------
-- CONTACTS
---------------------------------------------------
CREATE TABLE contacts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NULL,
    full_name NVARCHAR(150),
    email NVARCHAR(255),
    message NVARCHAR(MAX),
    status NVARCHAR(50) DEFAULT N'Chưa xử lý',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
GO

---------------------------------------------------
-- PRODUCT TYPES
---------------------------------------------------
CREATE TABLE product_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type_code NVARCHAR(10) UNIQUE,
    type_name NVARCHAR(100) NOT NULL
);
GO

---------------------------------------------------
-- CATEGORIES
---------------------------------------------------
CREATE TABLE categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    category_code NVARCHAR(10) UNIQUE,
    category_name NVARCHAR(100) NOT NULL
);
GO

---------------------------------------------------
-- PRODUCTS
---------------------------------------------------
CREATE TABLE products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    product_code NVARCHAR(10) UNIQUE,
    product_name NVARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    product_type_id INT,
    description NVARCHAR(MAX),
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (product_type_id) REFERENCES product_types(id)
);
GO

---------------------------------------------------
-- PRODUCT VARIANTS
---------------------------------------------------
CREATE TABLE product_variants (
    id INT IDENTITY(1,1) PRIMARY KEY,
    variant_code NVARCHAR(10) UNIQUE,
    product_id INT NOT NULL,
    style NVARCHAR(100),
    color NVARCHAR(50),
    size NVARCHAR(50),
    material NVARCHAR(100),
    price DECIMAL(12,2),
    image_url NVARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
GO

---------------------------------------------------
-- INVENTORY
---------------------------------------------------
CREATE TABLE inventory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    variant_id INT NOT NULL,
    stock_quantity INT DEFAULT 0,
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id)
);
GO

---------------------------------------------------
-- PRODUCT IMAGES
---------------------------------------------------
CREATE TABLE product_images (
    id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    image_url NVARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
GO

---------------------------------------------------
-- NEW PRODUCTS
---------------------------------------------------
CREATE TABLE new_products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
GO

---------------------------------------------------
-- BEST SELLERS
---------------------------------------------------
CREATE TABLE best_sellers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    sold_quantity INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(id)
);
GO

---------------------------------------------------
-- CART
---------------------------------------------------
CREATE TABLE cart (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
GO

---------------------------------------------------
-- CART DETAILS
---------------------------------------------------
CREATE TABLE cart_details (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cart_id INT NOT NULL,
    variant_id INT NOT NULL,
    quantity INT DEFAULT 1,
    unit_price DECIMAL(12,2),
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (cart_id) REFERENCES cart(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id)
);
GO

---------------------------------------------------
-- ORDERS
---------------------------------------------------
CREATE TABLE orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_code NVARCHAR(10) UNIQUE,
    user_id INT NOT NULL,
    recipient_name NVARCHAR(150),
    recipient_phone CHAR(12),
    order_date DATETIME DEFAULT GETDATE(),
    total_price DECIMAL(12,2),
    note NVARCHAR(255),
    shipping_address NVARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
GO

---------------------------------------------------
-- ORDER DETAILS
---------------------------------------------------
CREATE TABLE order_details (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    variant_id INT NOT NULL,
    quantity INT,
    unit_price DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id)
);
GO

---------------------------------------------------
-- SHIPPING
---------------------------------------------------
CREATE TABLE shipping (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    shipping_type NVARCHAR(20),
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    shipping_status NVARCHAR(50) DEFAULT N'Đang giao',
    tracking_number NVARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
GO

---------------------------------------------------
-- PAYMENTS
---------------------------------------------------
CREATE TABLE payments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method NVARCHAR(50),
    amount DECIMAL(12,2),
    payment_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT N'Chưa thanh toán',
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
GO

---------------------------------------------------
-- ORDER STATUS HISTORY
---------------------------------------------------
CREATE TABLE order_status_history (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    status NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
GO

---------------------------------------------------
-- DISCOUNTS
---------------------------------------------------
CREATE TABLE discounts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    discount_code NVARCHAR(10) UNIQUE,
    discount_name NVARCHAR(150),
    discount_percent DECIMAL(5,2),
    start_date DATETIME,
    end_date DATETIME,
    description NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);
GO

---------------------------------------------------
-- DISCOUNT - CATEGORIES
---------------------------------------------------
CREATE TABLE discount_categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    discount_id INT,
    category_id INT,
    FOREIGN KEY (discount_id) REFERENCES discounts(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
GO

---------------------------------------------------
-- DISCOUNT - PRODUCT TYPES
---------------------------------------------------
CREATE TABLE discount_product_types (
    id INT IDENTITY(1,1) PRIMARY KEY,
    discount_id INT,
    product_type_id INT,
    FOREIGN KEY (discount_id) REFERENCES discounts(id),
    FOREIGN KEY (product_type_id) REFERENCES product_types(id)
);
GO

---------------------------------------------------
-- NOTIFICATIONS
---------------------------------------------------
CREATE TABLE notifications (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    title NVARCHAR(255),
    content NVARCHAR(MAX),
    type NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT N'Chưa xem',
    FOREIGN KEY (user_id) REFERENCES users(id)
);
GO

---------------------------------------------------
-- POLICIES
---------------------------------------------------
CREATE TABLE policies (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255),
    content NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);
GO

---------------------------------------------------
-- BANNERS
---------------------------------------------------
CREATE TABLE banners (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255),
    description NVARCHAR(MAX),
    image_url NVARCHAR(255),
    link NVARCHAR(255),
    display_order INT DEFAULT 1,
    sort_order INT DEFAULT 1,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);
GO
