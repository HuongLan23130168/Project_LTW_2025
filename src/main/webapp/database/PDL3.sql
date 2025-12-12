CREATE DATABASE DOAN_DECOR
GO

USE DOAN_DECOR
GO

/* ================================
   USERS
================================ */
CREATE TABLE Users (
    id INT IDENTITY PRIMARY KEY,
    full_name NVARCHAR(100),
    email NVARCHAR(150) UNIQUE,
    password NVARCHAR(255),
    phone NVARCHAR(20),
    role NVARCHAR(20) DEFAULT 'user',
    address NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);

/* ================================
   ADDRESSES
================================ */
CREATE TABLE Addresses (
    id INT IDENTITY PRIMARY KEY,
    user_id INT NOT NULL,
    address NVARCHAR(255),
    is_default BIT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

/* ================================
   CATEGORIES
================================ */
CREATE TABLE Categories (
    id INT IDENTITY PRIMARY KEY,
    category_name NVARCHAR(100)
);

/* ================================
   PRODUCT TYPES
================================ */
CREATE TABLE ProductTypes (
    id INT IDENTITY PRIMARY KEY,
    type_name NVARCHAR(100)
);

/* ================================
   PRODUCTS (id + code SP001…)
================================ */
CREATE TABLE Products (
    id INT IDENTITY PRIMARY KEY,
    code NVARCHAR(20) UNIQUE,       -- VD: SP001
    product_name NVARCHAR(150),
    category_id INT,
    type_id INT,
    description NVARCHAR(MAX),

    FOREIGN KEY (category_id) REFERENCES Categories(id),
    FOREIGN KEY (type_id) REFERENCES ProductTypes(id)
);

/* ================================
   PRODUCT VARIANTS
================================ */
CREATE TABLE ProductVariants (
    id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    style NVARCHAR(100),
    color NVARCHAR(50),
    size NVARCHAR(50),
    material NVARCHAR(100),
    price DECIMAL(18,2),
    image_url NVARCHAR(500),

    FOREIGN KEY (product_id) REFERENCES Products(id)
);

/* ================================
   INVENTORY
================================ */
CREATE TABLE Inventory (
    id INT IDENTITY PRIMARY KEY,
    variant_id INT NOT NULL,
    stock_quantity INT DEFAULT 0,
    last_updated DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (variant_id) REFERENCES ProductVariants(id)
);

/* ================================
   CARTS
================================ */
CREATE TABLE Carts (
    id INT IDENTITY PRIMARY KEY,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

/* ================================
   CART DETAILS
================================ */
CREATE TABLE CartDetails (
    id INT IDENTITY PRIMARY KEY,
    cart_id INT NOT NULL,
    variant_id INT NOT NULL,
    quantity INT DEFAULT 1,
    FOREIGN KEY (cart_id) REFERENCES Carts(id),
    FOREIGN KEY (variant_id) REFERENCES ProductVariants(id)
);

/* ================================
   ORDERS
================================ */
CREATE TABLE Orders (
    id INT IDENTITY PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    total DECIMAL(18,2),
    shipping_address NVARCHAR(255),
    payment_method NVARCHAR(50),
    status NVARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (user_id) REFERENCES Users(id)
);

/* ================================
   ORDER DETAILS
================================ */
CREATE TABLE OrderDetails (
    id INT IDENTITY PRIMARY KEY,
    order_id INT NOT NULL,
    variant_id INT NOT NULL,
    quantity INT,
    price DECIMAL(18,2),

    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (variant_id) REFERENCES ProductVariants(id)
);

/* ================================
   DISCOUNTS
================================ */
CREATE TABLE Discounts (
    id INT IDENTITY PRIMARY KEY,
    discount_name NVARCHAR(100),
    percent_value INT,
    start_date DATE,
    end_date DATE
);

/* ================================
   DISCOUNT → CATEGORY
================================ */
CREATE TABLE DiscountCategories (
    id INT IDENTITY PRIMARY KEY,
    discount_id INT NOT NULL,
    category_id INT NOT NULL,

    FOREIGN KEY (discount_id) REFERENCES Discounts(id),
    FOREIGN KEY (category_id) REFERENCES Categories(id)
);

/* ================================
   DISCOUNT → PRODUCT TYPE
================================ */
CREATE TABLE DiscountProductTypes (
    id INT IDENTITY PRIMARY KEY,
    discount_id INT NOT NULL,
    type_id INT NOT NULL,

    FOREIGN KEY (discount_id) REFERENCES Discounts(id),
    FOREIGN KEY (type_id) REFERENCES ProductTypes(id)
);

/* ================================
   PRODUCT IMAGES
================================ */
CREATE TABLE ProductImages (
    id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    image_url NVARCHAR(500),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

/* ================================
   BEST SELLERS
================================ */
CREATE TABLE BestSellers (
    id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    sold_count INT,
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

/* ================================
   NEW PRODUCTS
================================ */
CREATE TABLE NewProducts (
    id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    created_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

/* ================================
   BANNERS
================================ */
CREATE TABLE Banners (
    id INT IDENTITY PRIMARY KEY,
    title NVARCHAR(100),
    image_url NVARCHAR(500),
    link NVARCHAR(255)
);

/* ================================
   NOTIFICATIONS
================================ */
CREATE TABLE Notifications (
    id INT IDENTITY PRIMARY KEY,
    user_id INT NOT NULL,
    message NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    is_read BIT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

/* ================================
   CONTACTS
================================ */
CREATE TABLE Contacts (
    id INT IDENTITY PRIMARY KEY,
    full_name NVARCHAR(100),
    email NVARCHAR(100),
    phone NVARCHAR(20),
    message NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);
