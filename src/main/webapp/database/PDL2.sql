CREATE DATABASE LTW_PDL
GO

USE LTW_PDL
GO

---------------------------------------------------
-- USERS
---------------------------------------------------
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    birth DATE,
    gender NVARCHAR(10),
    email NVARCHAR(100) UNIQUE NOT NULL,
    password VARBINARY(64) NOT NULL,
    phone CHAR(12),
    role NVARCHAR(20) DEFAULT 'user',
    address NVARCHAR(255)
);
GO

---------------------------------------------------
-- ADDRESSES
---------------------------------------------------
CREATE TABLE Addresses (
    id INT IDENTITY(1,1) PRIMARY KEY,
    users_id INT NOT NULL,
    address NVARCHAR(200),
    is_default BIT DEFAULT 0,
    FOREIGN KEY (users_id) REFERENCES Users(id)
);
GO

---------------------------------------------------
-- CONTACT
---------------------------------------------------
CREATE TABLE Contact (
    id INT IDENTITY(1,1) PRIMARY KEY,
    users_id INT NULL,
    full_name NVARCHAR(150),
    email NVARCHAR(255),
    message NVARCHAR(MAX),
    status NVARCHAR(50) DEFAULT N'Chưa xử lý',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (users_id) REFERENCES Users(id)
);
GO

---------------------------------------------------
-- PRODUCT TYPES
---------------------------------------------------
CREATE TABLE ProductTypes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    type_code NVARCHAR(10) UNIQUE,
    type_name NVARCHAR(100) NOT NULL
);
GO

---------------------------------------------------
-- CATEGORIES
---------------------------------------------------
CREATE TABLE Categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    category_code NVARCHAR(10) UNIQUE,
    category_name NVARCHAR(100) NOT NULL
);
GO

---------------------------------------------------
-- PRODUCTS
---------------------------------------------------
CREATE TABLE Products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    product_code NVARCHAR(10) UNIQUE,
    product_name NVARCHAR(150) NOT NULL,
    categories_id INT NOT NULL,
    producttypes_id INT,
    description NVARCHAR(MAX),
    FOREIGN KEY (categories_id) REFERENCES Categories(id),
    FOREIGN KEY (producttypes_id) REFERENCES ProductTypes(id)
);
GO

---------------------------------------------------
-- PRODUCT VARIANTS
---------------------------------------------------
CREATE TABLE ProductVariants (
    id INT IDENTITY(1,1) PRIMARY KEY,
    variant_code NVARCHAR(10) UNIQUE,
    products_id INT NOT NULL,
    style NVARCHAR(100),
    color NVARCHAR(50),
    size NVARCHAR(50),
    material NVARCHAR(100),
    price DECIMAL(12,2),
    image_url NVARCHAR(255),
    FOREIGN KEY (products_id) REFERENCES Products(id)
);
GO

---------------------------------------------------
-- INVENTORY
---------------------------------------------------
CREATE TABLE Inventory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    productvariants_id INT NOT NULL,
    stock_quantity INT DEFAULT 0,
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (productvariants_id) REFERENCES ProductVariants(id)
);
GO

---------------------------------------------------
-- PRODUCT IMAGES
---------------------------------------------------
CREATE TABLE ProductImages (
    id INT IDENTITY(1,1) PRIMARY KEY,
    products_id INT NOT NULL,
    image_url NVARCHAR(255),
    FOREIGN KEY (products_id) REFERENCES Products(id)
);
GO

---------------------------------------------------
-- NEW PRODUCTS
---------------------------------------------------
CREATE TABLE NewProducts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    products_id INT NOT NULL,
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (products_id) REFERENCES Products(id)
);
GO

---------------------------------------------------
-- BEST SELLERS
---------------------------------------------------
CREATE TABLE BestSellers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    products_id INT NOT NULL,
    sold_quantity INT DEFAULT 0,
    FOREIGN KEY (products_id) REFERENCES Products(id)
);
GO

---------------------------------------------------
-- CART
---------------------------------------------------
CREATE TABLE Cart (
    id INT IDENTITY(1,1) PRIMARY KEY,
    users_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (users_id) REFERENCES Users(id)
);
GO

---------------------------------------------------
-- CART DETAILS
---------------------------------------------------
CREATE TABLE CartDetails (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cart_id INT NOT NULL,
    productvariants_id INT NOT NULL,
    quantity INT DEFAULT 1,
    unit_price DECIMAL(12,2),
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (cart_id) REFERENCES Cart(id),
    FOREIGN KEY (productvariants_id) REFERENCES ProductVariants(id)
);
GO

---------------------------------------------------
-- ORDERS
---------------------------------------------------
CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_code NVARCHAR(10) UNIQUE,
    users_id INT NOT NULL,
    recipient_name NVARCHAR(150),
    recipient_phone CHAR(12),
    order_date DATETIME DEFAULT GETDATE(),
    total_price DECIMAL(12,2),
    note NVARCHAR(255),
    shipping_address NVARCHAR(255),
    FOREIGN KEY (users_id) REFERENCES Users(id)
);
GO

---------------------------------------------------
-- ORDER DETAILS
---------------------------------------------------
CREATE TABLE OrderDetails (
    id INT IDENTITY(1,1) PRIMARY KEY,
    orders_id INT NOT NULL,
    productvariants_id INT NOT NULL,
    quantity INT,
    unit_price DECIMAL(12,2),
    FOREIGN KEY (orders_id) REFERENCES Orders(id),
    FOREIGN KEY (productvariants_id) REFERENCES ProductVariants(id)
);
GO

---------------------------------------------------
-- SHIPPING
---------------------------------------------------
CREATE TABLE Shipping (
    id INT IDENTITY(1,1) PRIMARY KEY,
    orders_id INT NOT NULL UNIQUE,
    shipping_type NVARCHAR(20),
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    shipping_status NVARCHAR(50) DEFAULT N'Đang giao',
    tracking_number NVARCHAR(50),
    FOREIGN KEY (orders_id) REFERENCES Orders(id)
);
GO

---------------------------------------------------
-- PAYMENTS
---------------------------------------------------
CREATE TABLE Payments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    orders_id INT NOT NULL,
    payment_method NVARCHAR(50),
    amount DECIMAL(12,2),
    payment_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT N'Chưa thanh toán',
    FOREIGN KEY (orders_id) REFERENCES Orders(id)
);
GO

---------------------------------------------------
-- ORDER STATUS HISTORY
---------------------------------------------------
CREATE TABLE OrderStatusHistory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    orders_id INT NOT NULL,
    status NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (orders_id) REFERENCES Orders(id)
);
GO

---------------------------------------------------
-- DISCOUNTS
---------------------------------------------------
CREATE TABLE Discounts (
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
-- DISCOUNT – CATEGORY (N-N)
---------------------------------------------------
CREATE TABLE Discount_Categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    discounts_id INT,
    categories_id INT,
    FOREIGN KEY (discounts_id) REFERENCES Discounts(id),
    FOREIGN KEY (categories_id) REFERENCES Categories(id)
);
GO

---------------------------------------------------
-- DISCOUNT – PRODUCT TYPES (N-N)
---------------------------------------------------
CREATE TABLE Discount_ProductTypes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    discounts_id INT,
    producttypes_id INT,
    FOREIGN KEY (discounts_id) REFERENCES Discounts(id),
    FOREIGN KEY (producttypes_id) REFERENCES ProductTypes(id)
);
GO

---------------------------------------------------
-- NOTIFICATIONS
---------------------------------------------------
CREATE TABLE Notifications (
    id INT IDENTITY(1,1) PRIMARY KEY,
    users_id INT,
    title NVARCHAR(255),
    content NVARCHAR(MAX),
    type NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT N'Chưa xem',
    FOREIGN KEY (users_id) REFERENCES Users(id)
);
GO

---------------------------------------------------
-- POLICIES
---------------------------------------------------
CREATE TABLE Policies (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255),
    content NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);
GO

---------------------------------------------------
-- BANNERS
---------------------------------------------------
CREATE TABLE Banners (
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
