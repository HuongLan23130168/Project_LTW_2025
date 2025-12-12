CREATE DATABASE DOAN_LTW_24_BANG_DEMO;
GO

USE DOAN_LTW_24_BANG_DEMO;
GO


/* Chọn cơ sở dữ liệu DOAN_LTW_24BANG để thực hiện các lệnh tiếp theo */

/* 1. Bảng Users: lưu thông tin người dùng, mật khẩu đã được hash SHA-256 */
CREATE TABLE Users (
    user_id NVARCHAR(10) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    birth DATE,
    gender NVARCHAR(10),
    email NVARCHAR(100) UNIQUE NOT NULL,
    password VARBINARY(64) NOT NULL,
    phone CHAR(12),
    role NVARCHAR(20) DEFAULT 'user',
    address NVARCHAR(255) NULL
);
GO

/* 2. Bảng Addresses: lưu nhiều địa chỉ cho mỗi người dùng */
CREATE TABLE Addresses (
    address_id INT PRIMARY KEY,
    user_id NVARCHAR(10) NOT NULL,
    address NVARCHAR(200),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

/* 3. ProductTypes: loại sản phẩm */
CREATE TABLE ProductTypes (
    type_id NVARCHAR(10) PRIMARY KEY,
    type_name NVARCHAR(100) NOT NULL
);
GO

/* 4. Categories: danh mục sản phẩm */
CREATE TABLE Categories (
    category_id NVARCHAR(10) PRIMARY KEY,
    category_name NVARCHAR(100) NOT NULL,
    type NVARCHAR(100) NULL
);
GO

/* 5. Products: thông tin sản phẩm */
CREATE TABLE Products (
    product_id NVARCHAR(10) PRIMARY KEY,
    product_name NVARCHAR(150) NOT NULL,
    category_id NVARCHAR(10) NOT NULL,
    type_id NVARCHAR(10) NULL,
    description NVARCHAR(MAX),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (type_id) REFERENCES ProductTypes(type_id)
);
GO

/* 6. ProductVariants: các phiên bản/biến thể sản phẩm */
CREATE TABLE ProductVariants (
    variant_id NVARCHAR(10) PRIMARY KEY,
    product_id NVARCHAR(10) NOT NULL,
    style NVARCHAR(100),
    color NVARCHAR(50),
    size NVARCHAR(50),
    material NVARCHAR(100),
    price DECIMAL(12,2),
    stock INT DEFAULT 0,
    image_url NVARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

/* 7. ProductImages: lưu nhiều hình ảnh cho sản phẩm */
CREATE TABLE ProductImages (
    image_id NVARCHAR(10) PRIMARY KEY,
    product_id NVARCHAR(10) NOT NULL,
    image_url NVARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

/* 8. Cart: giỏ hàng của người dùng */
CREATE TABLE Cart (
    cart_id NVARCHAR(10) PRIMARY KEY,
    user_id NVARCHAR(10) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

/* 9. CartDetails: chi tiết sản phẩm trong giỏ */
CREATE TABLE CartDetails (
    cart_detail_id NVARCHAR(10) PRIMARY KEY,
    cart_id NVARCHAR(10) NOT NULL,
    product_id NVARCHAR(10) NOT NULL,
    variant_id NVARCHAR(10) NULL,
    quantity INT DEFAULT 1,
    unit_price DECIMAL(12,2) NOT NULL,
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
);
GO

/* 10. Orders: đơn hàng, lưu thông tin người nhận, địa chỉ, phương thức thanh toán */
CREATE TABLE Orders (
    order_id NVARCHAR(10) PRIMARY KEY,
    user_id NVARCHAR(10) NOT NULL,
    recipient_name NVARCHAR(150) NOT NULL,
    recipient_phone CHAR(12) NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    total_price DECIMAL(12,2) NOT NULL,
    note NVARCHAR(255),
    payment_method NVARCHAR(100) NULL,
    shipping_address NVARCHAR(255) NULL,
    shipping_method NVARCHAR(50) NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

/* 11. OrderDetails: chi tiết từng sản phẩm trong đơn hàng */
CREATE TABLE OrderDetails (
    order_detail_id NVARCHAR(10) PRIMARY KEY,
    order_id NVARCHAR(10) NOT NULL,
    product_id NVARCHAR(10) NOT NULL,
    variant_id NVARCHAR(10) NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
);
GO

/* 12. Shipping: thông tin giao hàng */
CREATE TABLE Shipping (
    shipping_id NVARCHAR(10) PRIMARY KEY,
    order_id NVARCHAR(10) NOT NULL,
    shipping_type NVARCHAR(20) CHECK (shipping_type IN (N'Tiêu chuẩn', N'Hỏa tốc')),
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    shipping_status NVARCHAR(50) DEFAULT N'Đang giao',
    tracking_number NVARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

/* 13. Contact: liên hệ từ người dùng hoặc khách vãng lai */
CREATE TABLE Contact (
    contact_id NVARCHAR(10) PRIMARY KEY,
    user_id NVARCHAR(10) NULL,
    full_name NVARCHAR(150),
    email NVARCHAR(255),
    message NVARCHAR(MAX),
    status NVARCHAR(50) DEFAULT N'Chưa xử lý',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

/* 14. Discounts: thông tin khuyến mãi */
CREATE TABLE Discounts (
    discount_id NVARCHAR(10) PRIMARY KEY,
    discount_name NVARCHAR(150) NOT NULL,
    discount_percent DECIMAL(5,2) NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    description NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);
GO

/* 15. Discount_Categories: áp dụng khuyến mãi cho danh mục */
CREATE TABLE Discount_Categories (
    discount_id NVARCHAR(10) NOT NULL,
    category_id NVARCHAR(10) NOT NULL,
    PRIMARY KEY (discount_id, category_id),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
GO

/* 16. Discount_ProductTypes: áp dụng khuyến mãi cho loại sản phẩm */
CREATE TABLE Discount_ProductTypes (
    discount_id NVARCHAR(10) NOT NULL,
    type_id NVARCHAR(10) NOT NULL,
    PRIMARY KEY (discount_id, type_id),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
    FOREIGN KEY (type_id) REFERENCES ProductTypes(type_id)
);
GO

/* 17. Discount_Products: áp dụng khuyến mãi cho sản phẩm cụ thể */
--CREATE TABLE Discount_Products (
 --  discount_id NVARCHAR(10) NOT NULL,
 --  product_id NVARCHAR(10) NOT NULL,
 --   PRIMARY KEY (discount_id, product_id),
 --   FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
 --   FOREIGN KEY (product_id) REFERENCES Products(product_id)
--);
-- GO

/* 18. Policies: chính sách của cửa hàng */
CREATE TABLE Policies (
    policy_id NVARCHAR(10) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);
GO

/* 19. Banners: banner quảng cáo, thêm cột sort_order */
CREATE TABLE Banners (
    banner_id NVARCHAR(10) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    image_url NVARCHAR(255) NOT NULL,
    link NVARCHAR(255),
    display_order INT DEFAULT 1,
    sort_order INT DEFAULT 1,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE()
);
GO

/* 20. NewProducts: sản phẩm mới thêm vào */
CREATE TABLE NewProducts (
    product_id NVARCHAR(10) PRIMARY KEY,
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

/* 21. BestSellers: sản phẩm bán chạy */
CREATE TABLE BestSellers (
    product_id NVARCHAR(10) PRIMARY KEY,
    sold_quantity INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

/* 22. Inventory: tồn kho sản phẩm/biến thể */
CREATE TABLE Inventory (
    inventory_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id NVARCHAR(10) NULL,
    variant_id NVARCHAR(10) NULL,
    stock_quantity INT DEFAULT 0,
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
);
GO

/* 23. OrderStatus: trạng thái đơn hàng */
CREATE TABLE OrderStatus (
    order_id NVARCHAR(10) PRIMARY KEY,
    status NVARCHAR(50) NOT NULL CHECK (status IN 
        (N'Tất cả', N'Chờ xử lý', N'Đã thanh toán', N'Đang giao', N'Đã giao', N'Đã hủy')
    ),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

/* 24. Payments: thông tin thanh toán */
CREATE TABLE Payments (
    payment_id NVARCHAR(10) PRIMARY KEY,
    order_id NVARCHAR(10) NOT NULL,
    payment_method NVARCHAR(50) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT N'Chưa thanh toán',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

/* 25. Notifications: thông báo đến người dùng */
CREATE TABLE Notifications (
    notification_id NVARCHAR(10) PRIMARY KEY,
    user_id NVARCHAR(10) NULL,
    title NVARCHAR(255),
    content NVARCHAR(MAX),
    type NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT N'Chưa xem',
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO



-- DỮ LIỆU 


-- Users
INSERT INTO Users (user_id, full_name, birth, gender, email, password, phone, address, role)
VALUES
('KH001', N'Trịnh Trần Phương Tuấn', '1997-04-12', N'Nam', 'Tuan@gmail.com', HASHBYTES('SHA2_256', '12041997'), '0123456789', N'123 Đường A, Quận 1', 'user'),
('KH002', N'Nguyễn Bảo Khánh', '1999-07-12', N'Nam', 'Khanh@gmail.com', HASHBYTES('SHA2_256', '12071999'), '0987654321', N'456 Đường B, Quận 2', 'user'),
('KH003', N'Admin', '2000-01-01', N'Khác', 'admin@gmail.com', HASHBYTES('SHA2_256', 'admin123'), '0123987654', N'Trụ sở Admin', 'admin');
GO

-- Categories
INSERT INTO Categories (category_id, category_name, type)
VALUES
('DM001', N'Cây', N'Phòng khách, Phòng ngủ, Ban công, Phòng bếp, Decor'),
('DM002', N'Tranh', N'Phòng khách, Phòng ngủ, Ban công, Phòng bếp, Decor'),
('DM003', N'Đèn', N'Phòng khách, Phòng ngủ, Ban công, Phòng bếp, Decor'),
('DM004', N'Gương', N'Phòng khách, Phòng ngủ, Decor');
GO

-- Products
INSERT INTO Products (product_id, product_name, category_id, description)
VALUES
('SP001', N'Cây tiểu cảnh trang trí phòng khách', 'DM001', N'Với dáng huyền nghệ thuật, cây bonsai không chỉ là vật trang trí mà còn tượng trưng cho sự trường thọ, kiên cường và thịnh vượng.'),
('SP002', N'Tranh Canvas Hoa', 'DM002', N'Tranh canvas in hoa, chất liệu vải bền'),
('SP003', N'Đèn thả chùm hoa bồ công anh pha lê hiện đại', 'DM003', N'Ánh sáng vàng ấm giúp tạo không gian ấm cúng, sang trọng.'),
('SP004', N'Gương soi Lili Mirror lượn', 'DM004', N'Gương soi Lili Mirror lượn dùng để kết hợp sao cho phù hợp với không gian nhà mình.');
GO

-- ProductVariants
INSERT INTO ProductVariants (variant_id, product_id, style, color, size, material, price, stock, image_url)
VALUES
('BT001', 'SP001', N'Cổ điển', N'Xanh', N'120cm', N'Polyester, Gỗ', 2000000, 10, N'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-mbt0g23zdz6y09.webp'),
('BT002', 'SP002', N'Hiện đại', N'Trắng', N'30cm', N'Nhựa', 450000, 5, N'https://down-vn.img.susercontent.com/file/vn-11134207-7ra0g-m8m4f5792kxu87.webp'),
('BT003', 'SP003', N'Sang trọng', N'Trắng', N'90x30cm', N'Hợp kim mạ sơn tĩnh điện, pha lê', 800000, 20, N'https://down-vn.img.susercontent.com/file/890c3c7209ee651dcba710b29de73c21.webp'),
('BT004', 'SP004', N'Hiện đại', N'Đen', N'70x170cm', N'Gương có ốp gỗ', 2090000, 15, N'https://product.hstatic.net/200000486527/product/guong_luon5_b85715682457471a8ce4ab56cde1f015_master.jpg'),
('BT005', 'SP004', N'Hiện đại', N'Hồng', N'70x170cm', N'Gương có ốp gỗ', 2090000, 25, N'https://product.hstatic.net/200000486527/product/guong_luon_3_cdd45419f88b4daaa418bdd5652f2eca_master.jpg');
GO

-- ProductImages
INSERT INTO ProductImages (image_id, product_id, image_url)
VALUES
('ANH001', 'SP001', N'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-mbt0g23zdz6y09.webp'),
('ANH002', 'SP002', N'https://down-vn.img.susercontent.com/file/vn-11134207-7ra0g-m8m4f5792kxu87.webp'),
('ANH003', 'SP003', N'https://down-vn.img.susercontent.com/file/890c3c7209ee651dcba710b29de73c21.webp'),
('ANH004', 'SP004', N'https://product.hstatic.net/200000486527/product/guong_luon5_b85715682457471a8ce4ab56cde1f015_master.jpg'),
('ANH005', 'SP004', N'https://product.hstatic.net/200000486527/product/guong_luon_3_cdd45419f88b4daaa418bdd5652f2eca_master.jpg');
GO

-- Cart
INSERT INTO Cart (cart_id, user_id, created_at)
VALUES
('GH001', 'KH001', GETDATE()),
('GH002', 'KH002', GETDATE());
GO

-- CartDetails
INSERT INTO CartDetails (cart_detail_id, cart_id, product_id, variant_id, quantity, unit_price)
VALUES
('CTH001', 'GH001', 'SP001', 'BT001', 1, 2000000),
('CTH002', 'GH001', 'SP004', 'BT004', 1, 2090000),
('CTH003', 'GH002', 'SP003', 'BT003', 1, 800000);
GO

-- Orders
-- Lưu ý: orders table đã được thêm các cột cần thiết
INSERT INTO Orders (order_id, user_id, order_date, total_price, note, payment_method, shipping_address, shipping_method, recipient_name, recipient_phone)
VALUES
('DH001', 'KH001', GETDATE(), 2020000, N'Giao trong giờ hành chính', N'Thanh toán khi nhận hàng', N'123 Đường A, Quận 1', N'Tiêu chuẩn', N'Trịnh Trần Phương Tuấn', '0123456789'),
('DH002', 'KH002', GETDATE(), 830000, N'Giao nhanh', N'Chuyển khoản', N'456 Đường B, Quận 2', N'Hỏa tốc', N'Nguyễn Bảo Khánh', '0987654321');
GO

-- OrderDetails
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, variant_id, quantity, unit_price, shipping_fee)
VALUES
('CTDH001', 'DH001', 'SP001', 'BT001', 1, 2000000, 20000),
('CTDH002', 'DH002', 'SP003', 'BT003', 1, 800000, 30000);
GO

-- Discounts
INSERT INTO Discounts (discount_id, discount_name, discount_percent, start_date, end_date, description)
VALUES
('KM001', N'Giảm 20% cho Gương', 20, '2025-11-25', '2026-01-30', N'Giảm 20% sản phẩm gương'),
('KM002', N'Giảm 10% cho Cây', 10, '2025-11-15', '2025-12-30', N'Giảm 10% sản phẩm cây');
GO

-- Discount_Categories
INSERT INTO Discount_Categories (discount_id, category_id)
VALUES 
('KM001', 'DM004'),
('KM002', 'DM001');
GO

-- Discount_Products (bảng đã bổ sung)
--INSERT INTO Discount_Products (discount_id, product_id)
--VALUES ('KM002', 'SP002');
--GO

-- Contact
INSERT INTO Contact (contact_id, user_id, full_name, email, message, created_at, status)
VALUES
('LH001', 'KH001', N'Trịnh Trần Phương Tuấn', 'Tuan@gmail.com', N'Tôi muốn hỏi về cây tiểu cảnh SP001', GETDATE(), N'Chưa xem'),
('LH002', 'KH002', N'Nguyễn Bảo Khánh', 'Khanh@gmail.com', N'Tôi muốn hỏi về tranh canvas SP002', GETDATE(), N'Chưa xem'),
('LH003', NULL, N'Khách vãng lai', 'guest@gmail.com', N'Tôi muốn đặt hàng nhưng chưa có tài khoản', GETDATE(), N'Chưa xem');
GO

-- Shipping
INSERT INTO Shipping (shipping_id, order_id, shipping_type, shipping_fee, shipping_status, tracking_number)
VALUES
('GH001', 'DH001', N'Tiêu chuẩn', 20000, N'Đã giao hàng', 'VD001'),
('GH002', 'DH002', N'Hỏa tốc', 30000, N'Đang giao', 'VD002');
GO

-- Notifications (bảng đã bổ sung)
INSERT INTO Notifications (notification_id, user_id, title, content, type, created_at, status)
VALUES
('TB001', 'KH001', N'Đơn hàng mới', N'Đơn hàng DH001 đã được tạo', N'Order', GETDATE(), N'Chưa xem'),
('TB002', 'KH002', N'Khuyến mãi mới', N'Giảm 10% cho sản phẩm cây', N'Discount', GETDATE(), N'Chưa xem');
GO

-- Policies
INSERT INTO Policies (policy_id, title, content)
VALUES
('CS001', N'Chính sách đổi trả', N'Khách hàng có thể đổi trả trong vòng 7 ngày'),
('CS002', N'Chính sách bảo hành', N'Sản phẩm được bảo hành 12 tháng');
GO

-- Banners (đã thêm sort_order)
INSERT INTO Banners (banner_id, title, description, image_url, link, sort_order, is_active, created_at)
VALUES
('BN001', N'Banner Cây', N'Khuyến mãi cây', N'https://example.com/banner1.jpg', 'https://example.com/cay', 1, 1, GETDATE()),
('BN002', N'Banner Tranh', N'Khuyến mãi tranh', N'https://example.com/banner2.jpg', 'https://example.com/tranh', 2, 1, GETDATE());
GO

-- NewProducts (đã đổi cột thành added_at)
INSERT INTO NewProducts (product_id, added_at)
VALUES
('SP001', GETDATE()),
('SP002', GETDATE());
GO

-- BestSellers (bảng mới khớp với INSERT)
INSERT INTO BestSellers (product_id, sold_quantity)
VALUES
('SP001', 50),
('SP003', 30);
GO

-- Inventory (chấp nhận INSERT (variant_id, stock_quantity))
INSERT INTO Inventory (variant_id, stock_quantity)
VALUES
('BT001', 10),
('BT002', 5),
('BT003', 20),
('BT004', 15),
('BT005', 25);
GO

-- OrderStatus
INSERT INTO OrderStatus (order_id, status)
VALUES
('DH001', N'Đã thanh toán'),
('DH002', N'Đang giao');
GO

-- Payments (đã thêm payment_date, status)
INSERT INTO Payments (payment_id, order_id, payment_method, amount, payment_date, status)
VALUES
('TT001', 'DH001', N'COD', 2020000, GETDATE(), N'Đã thanh toán'),
('TT002', 'DH002', N'Chuyển khoản', 830000, GETDATE(), N'Chưa thanh toán');
GO
