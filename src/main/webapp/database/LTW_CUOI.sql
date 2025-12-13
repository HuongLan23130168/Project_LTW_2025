---------------------------------------------------
-- DATABASE LTW24_CUOI
---------------------------------------------------
CREATE DATABASE LTW24_CUOI;
GO

USE LTW24_CUOI;
GO

---------------------------------------------------
-- PHẦN 1: USERS & ADDRESSES & CONTACT
---------------------------------------------------
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
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

INSERT INTO Users (full_name, birth, gender, email, password, phone, address, role)
VALUES
(N'Trịnh Trần Phương Tuấn', '1997-04-12', N'Nam', 'tuan@gmail.com', HASHBYTES('SHA2_256','12041997'), '0123456789', N'123 Đường A, Quận 1', 'user'),
(N'Nguyễn Bảo Khánh', '1999-07-12', N'Nam', 'khanh@gmail.com', HASHBYTES('SHA2_256','12071999'), '0987654321', N'456 Đường B, Quận 2', 'user'),
(N'Admin', '2000-01-01', N'Khác','admin@gmail.com', HASHBYTES('SHA2_256','admin123'), '0123987654', N'Trụ sở Admin', 'admin');
GO

CREATE TABLE Addresses (
    address_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    address NVARCHAR(200),
    is_default BIT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

INSERT INTO Addresses (user_id, address, is_default)
VALUES
(1, N'123 Đường A, Quận 1', 1),
(2, N'456 Đường B, Quận 2', 1),
(1, N'789 Đường C, Quận 3', 0);
GO

CREATE TABLE Contact (
    contact_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NULL,
    full_name NVARCHAR(150),
    email NVARCHAR(255),
    message NVARCHAR(MAX),
    status NVARCHAR(50) DEFAULT N'Chưa xử lý',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

INSERT INTO Contact (user_id, full_name, email, message, status)
VALUES
(1, N'Trịnh Trần Phương Tuấn', 'tuan@gmail.com', N'Tôi muốn hỏi về cây tiểu cảnh SP001', N'Chưa xem'),
(2, N'Nguyễn Bảo Khánh', 'khanh@gmail.com', N'Tôi muốn hỏi về tranh canvas SP002', N'Chưa xem'),
(NULL, N'Khách vãng lai', 'guest@gmail.com', N'Tôi muốn đặt hàng nhưng chưa có tài khoản', N'Chưa xem');
GO

---------------------------------------------------
-- PHẦN 2: PRODUCTS
---------------------------------------------------
CREATE TABLE ProductTypes (
    type_id NVARCHAR(10) PRIMARY KEY,
    type_name NVARCHAR(100) NOT NULL
);
GO

INSERT INTO ProductTypes (type_id, type_name) VALUES
('TP001', N'Cây cảnh'),
('TP002', N'Tranh'),
('TP003', N'Đèn'),
('TP004', N'Gương');
GO

CREATE TABLE Categories (
    category_id NVARCHAR(10) PRIMARY KEY,
    category_name NVARCHAR(100) NOT NULL
);
GO

INSERT INTO Categories (category_id, category_name) VALUES
('DM001', N'Phòng khách'),
('DM002', N'Phòng ngủ'),
('DM003', N'Ban công'),
('DM004', N'Decor');
GO

CREATE TABLE Products (
    product_id NVARCHAR(10) PRIMARY KEY,
    product_name NVARCHAR(150) NOT NULL,
    category_id NVARCHAR(10) NOT NULL,
    type_id NVARCHAR(10),
    description NVARCHAR(MAX),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (type_id) REFERENCES ProductTypes(type_id)
);
GO

INSERT INTO Products (product_id, product_name, category_id, type_id, description) VALUES
('SP001', N'Cây tiểu cảnh trang trí phòng khách', 'DM001', 'TP001', N'Cây bonsai tượng trưng sự thịnh vượng.'),
('SP002', N'Tranh Canvas Hoa', 'DM002', 'TP002', N'Tranh canvas chất liệu bền đẹp.'),
('SP003', N'Đèn thả chùm hoa bồ công anh pha lê hiện đại', 'DM003', 'TP003', N'Ánh sáng vàng ấm, không gian sang trọng.'),
('SP004', N'Gương soi Lili Mirror lượn', 'DM004', 'TP004', N'Gương phù hợp trang trí phòng hiện đại.');
GO

CREATE TABLE ProductVariants (
    variant_id NVARCHAR(10) PRIMARY KEY,
    product_id NVARCHAR(10) NOT NULL,
    style NVARCHAR(100),
    color NVARCHAR(50),
    size NVARCHAR(50),
    material NVARCHAR(100),
    price DECIMAL(12,2),
    image_url NVARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

INSERT INTO ProductVariants (variant_id, product_id, style, color, size, material, price, image_url) VALUES
('BT001', 'SP001', N'Cổ điển',  N'Xanh',  '120cm',  N'Polyester, Gỗ', 2000000, N'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-mbt0g23zdz6y09.webp'),
('BT002', 'SP002', N'Hiện đại', N'Trắng', '30cm',   N'Nhựa', 450000,  N'https://down-vn.img.susercontent.com/file/vn-11134207-7ra0g-m8m4f5792kxu87.webp'),
('BT003', 'SP003', N'Sang trọng',N'Trắng','90x30cm',N'Hợp kim + pha lê', 800000,  N'https://down-vn.img.susercontent.com/file/890c3c7209ee651dcba710b29de73c21.webp'),
('BT004', 'SP004', N'Hiện đại', N'Đen',   '70x170', N'Gương + gỗ', 2090000, N'https://product.hstatic.net/200000486527/product/guong_luon5_b85715682457471a8ce4ab56cde1f015_master.jpg'),
('BT005', 'SP004', N'Hiện đại', N'Hồng',  '70x170', N'Gương + gỗ', 2090000, N'https://product.hstatic.net/200000486527/product/guong_luon_3_cdd45419f88b4daaa418bdd5652f2eca_master.jpg');
GO

CREATE TABLE Inventory (
    inventory_id INT IDENTITY(1,1) PRIMARY KEY,
    variant_id NVARCHAR(10) NOT NULL,
    stock_quantity INT DEFAULT 0,
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
);
GO

INSERT INTO Inventory (variant_id, stock_quantity) VALUES
('BT001', 10),
('BT002', 5),
('BT003', 20),
('BT004', 15),
('BT005', 25);
GO

CREATE TABLE ProductImages (
    image_id NVARCHAR(10) PRIMARY KEY,
    product_id NVARCHAR(10) NOT NULL,
    image_url NVARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

INSERT INTO ProductImages (image_id, product_id, image_url) VALUES
('IMG001','SP001',N'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-mbt0g23zdz6y09.webp'),
('IMG002','SP002',N'https://down-vn.img.susercontent.com/file/vn-11134207-7ra0g-m8m4f5792kxu87.webp'),
('IMG003','SP003',N'https://down-vn.img.susercontent.com/file/890c3c7209ee651dcba710b29de73c21.webp'),
('IMG004','SP004',N'https://product.hstatic.net/200000486527/product/guong_luon5_b85715682457471a8ce4ab56cde1f015_master.jpg'),
('IMG005','SP004',N'https://product.hstatic.net/200000486527/product/guong_luon_3_cdd45419f88b4daaa418bdd5652f2eca_master.jpg');
GO

CREATE TABLE NewProducts (
    product_id NVARCHAR(10) PRIMARY KEY,
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

INSERT INTO NewProducts (product_id) VALUES ('SP001'), ('SP002');
GO

CREATE TABLE BestSellers (
    product_id NVARCHAR(10) PRIMARY KEY,
    sold_quantity INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO

INSERT INTO BestSellers (product_id, sold_quantity) VALUES ('SP001',50), ('SP003',30);
GO

---------------------------------------------------
-- PHẦN 3: CART & ORDERS
---------------------------------------------------
CREATE TABLE Cart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

INSERT INTO Cart (user_id) VALUES (1), (2);
GO

CREATE TABLE CartDetails (
    cart_id INT NOT NULL,
    variant_id NVARCHAR(10) NOT NULL,
    quantity INT DEFAULT 1,
    unit_price DECIMAL(12,2),
    added_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (cart_id, variant_id),
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id),
    FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
);
GO

INSERT INTO CartDetails (cart_id, variant_id, quantity, unit_price) VALUES
(1,'BT001',1,2000000),
(1,'BT004',1,2090000),
(2,'BT003',1,800000);
GO

CREATE TABLE Orders (
    order_id NVARCHAR(10) PRIMARY KEY,
    user_id INT NOT NULL,
    recipient_name NVARCHAR(150),
    recipient_phone CHAR(12),
    order_date DATETIME DEFAULT GETDATE(),
    total_price DECIMAL(12,2),
    note NVARCHAR(255),
    shipping_address NVARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

INSERT INTO Orders (order_id, user_id, recipient_name, recipient_phone, total_price, note, shipping_address) VALUES
('DH001',1,N'Trịnh Trần Phương Tuấn','0123456789',2020000,N'Giao trong giờ hành chính',N'123 Đường A'),
('DH002',2,N'Nguyễn Bảo Khánh','0987654321',830000,N'Giao nhanh',N'456 Đường B');
GO

CREATE TABLE OrderDetails (
    order_detail_id NVARCHAR(10) PRIMARY KEY,
    order_id NVARCHAR(10) NOT NULL,
    variant_id NVARCHAR(10) NOT NULL,
    quantity INT,
    unit_price DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (variant_id) REFERENCES ProductVariants(variant_id)
);
GO

INSERT INTO OrderDetails (order_detail_id, order_id, variant_id, quantity, unit_price) VALUES
('CTDH001','DH001','BT001',1,2000000),
('CTDH002','DH002','BT003',1,800000);
GO

CREATE TABLE Shipping (
    shipping_id NVARCHAR(10) PRIMARY KEY,
    order_id NVARCHAR(10) NOT NULL UNIQUE,
    shipping_type NVARCHAR(20) CHECK (shipping_type IN (N'Tiêu chuẩn',N'Hỏa tốc')),
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    shipping_status NVARCHAR(50) DEFAULT N'Đang giao',
    tracking_number NVARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

INSERT INTO Shipping (shipping_id, order_id, shipping_type, shipping_fee, shipping_status, tracking_number) VALUES
('SH001','DH001',N'Tiêu chuẩn',20000,N'Đã giao hàng','VD001'),
('SH002','DH002',N'Hỏa tốc',30000,N'Đang giao','VD002');
GO

CREATE TABLE Payments (
    payment_id NVARCHAR(10) PRIMARY KEY,
    order_id NVARCHAR(10) NOT NULL,
    payment_method NVARCHAR(50),
    amount DECIMAL(12,2),
    payment_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT N'Chưa thanh toán',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

INSERT INTO Payments (payment_id, order_id, payment_method, amount, status) VALUES
('TT001','DH001',N'COD',2020000,N'Đã thanh toán'),
('TT002','DH002',N'Chuyển khoản',830000,N'Chưa thanh toán');
GO

CREATE TABLE OrderStatusHistory (
    order_status_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(10) NOT NULL,
    status NVARCHAR(50) CHECK (status IN (N'Chờ xử lý',N'Đã thanh toán',N'Đang giao',N'Đã giao',N'Đã hủy')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
GO

INSERT INTO OrderStatusHistory (order_id, status)VALUES
('DH001',N'Chờ xử lý'),
('DH001',N'Đã thanh toán'),
('DH002',N'Chờ xử lý');
GO

---------------------------------------------------
-- PHẦN 4: DISCOUNTS & NOTIFICATIONS
---------------------------------------------------
CREATE TABLE Discounts (
    discount_id NVARCHAR(10) PRIMARY KEY,
    discount_name NVARCHAR(150),
    discount_percent DECIMAL(5,2),
    start_date DATETIME,
    end_date DATETIME,
    description NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Discounts (discount_id, discount_name, discount_percent, start_date, end_date, description) VALUES
('KM001',N'Giảm 20% Gương',20,'2025-11-25','2026-01-30',N'Ưu đãi gương'),
('KM002',N'Giảm 10% Cây',10,'2025-11-15','2025-12-30',N'Ưu đãi cây'),
('KM003',N'Giảm 41% Cây',10,'2025-11-15','2025-12-30',N'Ưu đãi cây');

GO

CREATE TABLE Discount_Categories (
    discount_id NVARCHAR(10),
    category_id NVARCHAR(10),
    PRIMARY KEY (discount_id, category_id),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
GO

INSERT INTO Discount_Categories (discount_id, category_id) VALUES
('KM001','DM004'),
('KM002','DM001'),
('KM003','DM001');
GO

CREATE TABLE Discount_ProductTypes (
    discount_id NVARCHAR(10),
    type_id NVARCHAR(10),
    PRIMARY KEY (discount_id, type_id),
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
    FOREIGN KEY (type_id) REFERENCES ProductTypes(type_id)
);
GO

INSERT INTO Discount_ProductTypes (discount_id, type_id) VALUES
('KM002','TP001');
GO

CREATE TABLE Notifications (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    title NVARCHAR(255),
    content NVARCHAR(MAX),
    type NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT N'Chưa xem',
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
GO

INSERT INTO Notifications (user_id, title, content, type, status) VALUES
(1,N'Đơn hàng mới',N'Đơn hàng DH001 đã được tạo',N'Order',N'Chưa xem'),
(2,N'Khuyến mãi mới',N'Giảm 10% cho sản phẩm cây',N'Discount',N'Chưa xem');
GO

---------------------------------------------------
-- PHẦN 5: POLICIES & BANNERS
---------------------------------------------------
CREATE TABLE Policies (
    policy_id NVARCHAR(10) PRIMARY KEY,
    title NVARCHAR(255),
    content NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO Policies (policy_id, title, content) VALUES
('CS001',N'Chính sách đổi trả',N'Đổi trả trong 7 ngày'),
('CS002',N'Chính sách bảo hành',N'Bảo hành 12 tháng');
GO

CREATE TABLE Banners (
    banner_id NVARCHAR(10) PRIMARY KEY,
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

INSERT INTO Banners (banner_id, title, description, image_url, link, display_order, sort_order, is_active) VALUES
('BN001',N'Banner Cây',N'Khuyến mãi cây',N'https://example.com/banner1.jpg','https://example.com/cay',1,1,1),
('BN002',N'Banner Tranh',N'Khuyến mãi tranh',N'https://example.com/banner2.jpg','https://example.com/tranh',2,1,0);
GO



SELECT * FROM Users;
SELECT * FROM Addresses;
SELECT * FROM Contact;
SELECT * FROM ProductTypes;
SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM ProductVariants;
SELECT * FROM Inventory;
SELECT * FROM ProductImages;
SELECT * FROM NewProducts;
SELECT * FROM BestSellers;
SELECT * FROM Cart;
SELECT * FROM CartDetails;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Shipping;
SELECT * FROM Payments;
SELECT * FROM OrderStatusHistory;
SELECT * FROM Discounts;
SELECT * FROM Discount_Categories;
SELECT * FROM Discount_ProductTypes;
SELECT * FROM Notifications;
SELECT * FROM Policies;
SELECT * FROM Banners;

-- ======================== USER ========================
-- ============ ĐĂNG KÝ ============
	-- Kiểm tra người dùng đã tồn tại hay chưa
	SELECT email
	FROM Users
	WHERE email = 'tuan@gmail.com';
	-- Thêm một người dùng mới vào bảng Users
	INSERT INTO Users (full_name, birth, gender, email, password, phone, address, role)
	VALUES (N'Trịnh Trần Phương Tuấn', '1997-04-12', N'Nam', 'tuan@gmail.com', HASHBYTES('SHA2_256','12041997'), '0123456789', N'123 Đường A, Quận 1', 'user');
-- ============ ĐĂNG NHẬP ============
	-- Kiểm tra email và mật khẩu để xác thực người dùng
	SELECT user_id, full_name, role
	FROM Users
	WHERE email = 'tuan@gmail.com' AND password = HASHBYTES('SHA2_256', '12041997');
-- ============ QUÊN MẬT KHẨU + MẬT KHẨU MỚI ============
	-- Cập nhật mật khẩu mới
	UPDATE Users
	SET password = HASHBYTES('SHA2_256', '123456')
	WHERE email = 'tuan@gmail.com';
-- ============ THAY ĐỔI MẬT KHẨU ============
	-- Thay đổi mật khẩu người dùng đã đăng nhập
	UPDATE Users
	SET password =  HASHBYTES('SHA2_256', '789012')
	WHERE user_id = 1 AND password = HASHBYTES ('SHA2_256', '123456');
-- ============ BỘ LỌC TÌM KIẾM ============
	-- Lọc sản phẩm theo Category (Phòng khách), giá <= 2000000
	SELECT P.product_id, P.product_name, C.category_name, V.price, V.color, V.image_url
	FROM Products P 
		JOIN Categories C ON C.category_id = P.category_id
		JOIN ProductVariants V ON V.product_id = P.product_id
	WHERE C.category_name = N'Phòng khách' AND V.price <= 2000000
	ORDER BY V.price ASC;
-- ============ DANH SÁCH SẢN PHẨM ============
	-- Xem danh sách sản phẩm
	SELECT P.product_id, P.product_name, P.description, P.category_id, PV.variant_id, PV.style, PV.color, PV.size, PV.price, I.stock_quantity
	FROM Products P
		JOIN ProductVariants PV ON P.product_id = PV.product_id
		JOIN Inventory I ON I.variant_id = PV.variant_id
	-- Xem sản phẩm còn hàng
	SELECT P.product_id, P.product_name, P.description, P.category_id, PV.variant_id, PV.style, PV.color, PV.size, PV.price, I.stock_quantity
	FROM Products P
		JOIN ProductVariants PV ON P.product_id = PV.product_id
		JOIN Inventory I ON I.variant_id = PV.variant_id
	WHERE I.stock_quantity > 0
	-- Xem sản phẩm hết hàng
	SELECT P.product_id, P.product_name, P.description, P.category_id, PV.variant_id, PV.color, PV.size, PV.price, I.stock_quantity
	FROM Products P
		JOIN ProductVariants PV ON P.product_id = PV.product_id
		JOIN Inventory I ON I.variant_id = PV.variant_id
	WHERE i.stock_quantity = 0;
-- ============ BỘ LỌC SẮP XẾP ============
	-- Sắp xếp theo giá giảm dần
	SELECT P.product_id, P.product_name, V.price
	FROM Products P
		JOIN ProductVariants V ON V.product_id = P.product_id
	ORDER BY V.price DESC;
	-- Sắp xếp sản phẩm tôn fkho ít -> nhiều
	SELECT P.product_id, P.product_name, P.description, P.category_id, PV.variant_id, PV.style, PV.color, PV.size, PV.price, I.stock_quantity
	FROM Products P
		JOIN ProductVariants PV ON P.product_id = PV.product_id
		JOIN Inventory I ON I.variant_id = PV.variant_id
	ORDER BY I.stock_quantity ASC;
-- ============ GIỎ HÀNG ============
	-- ============ Cập nhật (tăng/giảm) số lượng sản phẩm ============
	UPDATE CartDetails
	SET quantity = quantity + 1
	WHERE cart_id = 1 AND variant_id = 'BT001';
	-- ============ Xóa sản phẩm ============
	DELETE FROM CartDetails
	WHERE cart_id = 1 AND variant_id = 'BT001';
	-- ============ Tính tổng tiền của giỏ hàng (khi được tick chọn) ============
	SELECT
		P.product_name, PV.style, CD.quantity, CD.unit_price, (CD.quantity * CD.unit_price) AS sub_total
	FROM CartDetails CD
		JOIN ProductVariants PV ON CD.variant_id = PV.variant_id
		JOIN Products P ON PV.product_id = P.product_id
	WHERE CD.cart_id = 1 AND CD.variant_id IN ('BT001', 'BT004');
-- ============ THANH TOÁN ============
DELETE FROM Orders WHERE order_id = 'DH003'
	-- ============ ĐIỀN THÔNG TIN KHÁCH HÀNG ============
	-- 1. Thêm đơn hàng mới vào Orders
	INSERT INTO Orders (order_id, user_id, recipient_name, recipient_phone, total_price, note, shipping_address) 
	VALUES ('DH004', 2,N'Nguyễn Bảo Khánh','0987654321',0,N'Giao nhanh',N'456 Đường B');
	-- 2. Thêm sản phẩm từ giỏ hàng vào OrderDetails
	INSERT INTO OrderDetails  (order_detail_id, order_id, variant_id, quantity, unit_price)
	SELECT 'CTDH' + FORMAT(ROW_NUMBER() OVER(ORDER BY CD.variant_id) + (SELECT COUNT(*) FROM OrderDetails), '000'), 'DH004', CD.variant_id, CD.quantity, CD.unit_price * (1 - COALESCE(D.discount_percent, 0) / 100.0) AS final_unit_price
	FROM CartDetails CD
		JOIN ProductVariants PV ON CD.variant_id = PV.variant_id
		JOIN Products Pr ON PV.product_id = Pr.product_id
		LEFT JOIN ProductTypes PT ON PT.type_id = Pr.type_id
		LEFT JOIN Discount_ProductTypes DT ON DT.type_id = PT.type_id
		LEFT JOIN Discounts D ON D.discount_id = DT.discount_id
	WHERE CD.cart_id = 1;
	-- 3. Cập nhật tổng tiền cho đơn hàng dựa vào OrderDetails
	UPDATE Orders
	SET total_price = (SELECT SUM(quantity * unit_price) FROM OrderDetails WHERE order_id = 'DH004')
	WHERE order_id = 'DH004';
	-- ============ CHỌN HÌNH THỨC THANH TOÁN, VẬN CHUYỂN ============
	INSERT INTO Payments (payment_id, order_id, payment_method, amount, status) 
	VALUES ('TT004', 'DH004', N'COD', (SELECT total_price FROM Orders WHERE order_id = 'DH004'), N'Chưa thanh toán');

	INSERT INTO Shipping (shipping_id, order_id, shipping_type, shipping_fee, shipping_status, tracking_number) 
	VALUES ('SH004', 'DH004', N'Hỏa tốc', 30000, N'Chờ lấy hàng', 'VD004');

	INSERT INTO OrderStatusHistory (order_id, status)
	VALUES ('DH004',N'Chờ xử lý');

	-- Xem tổng tiền khách hàng phải trả
	SELECT O.total_price + S.shipping_fee AS total_payment
	FROM Orders O
		JOIN Shipping S ON O.order_id = S.order_id
	WHERE O.order_id = 'DH004';

-- ============ HOÀN TẤT ============
	-- ============ XEM CHI TIẾT ĐƠN VỪA ĐƯỢC THANH TOÁN ============
	SELECT O.order_id, O.order_date, S.shipping_status, P.payment_method, Pr.product_name, OD.quantity, OD.unit_price, D.discount_name, D.discount_percent, S.shipping_type, S.shipping_fee, O.total_price AS final_order_total
	FROM Orders O
		JOIN OrderDetails OD ON O.order_id = OD.order_id
		JOIN ProductVariants PV ON OD.variant_id = PV.variant_id
		JOIN Products Pr ON PV.product_id = Pr.product_id
		JOIN Shipping S ON O.order_id = S.order_id
		JOIN Payments P ON O.order_id = P.order_id
		LEFT JOIN ProductTypes PT ON PT.type_id = Pr.type_id
		LEFT JOIN Discount_ProductTypes DT ON DT.type_id = PT.type_id
		LEFT JOIN Discounts D ON D.discount_id = DT.discount_id
	WHERE O.order_id = 'DH004'; 
-- ======================== ADMIN ========================
-- ============ THANH TÌM KIẾM ============
	SELECT P.product_id, P.product_name, PV.image_url, pv.price
	FROM Products P
		JOIN ProductVariants PV ON P.product_id = PV.product_id
	WHERE P.product_name LIKE N'%Cây%' 
	GROUP BY P.product_id, P.product_name, PV.image_url,  pv.price
-- ============ DOANH THU ============
	-- Tính toán tổng doanh thu theo một khoảng thời gian
	SELECT SUM(P.amount) AS TotalRevenue
	FROM Payments P
		JOIN Orders O ON P.order_id = O.order_id
	WHERE P.status = N'Đã thanh toán' AND P.payment_date >= '2025-11-01' AND P.payment_date < '2025-12-01';
-- ============ SẢN PHẨM BÁN CHẠY ============
SELECT Top 10 BS.product_id, P.product_name, BS.sold_quantity
FROM BestSellers BS
	JOIN Products P ON BS.product_id = P.product_id
ORDER BY BS.sold_quantity DESC;
-- ============ DANH SÁCH ĐƠN HÀNG GẦN NHẤT ============
SELECT Top 10 O.order_id, U.full_name AS customer_name, O.order_date, S.shipping_status,O.total_price
FROM Orders O
	JOIN Users U ON O.user_id = U.user_id
	JOIN Shipping S ON O.order_id = S.order_id
ORDER BY O.order_date DESC;
-- ============ THÔNG TIN ADMIN ============
	-- Thay đổi thông tin admin
	UPDATE Users
	SET email = 'admin123@gmail.com', phone = '0985674231'
	WHERE role = 'admin' ;


-- ============ CHI TIẾT SẢN PHẨM ============
	-- Xem thông tin cở bản
	SELECT P.product_id, P.product_name, C.category_name, PR.price, D.discount_percent, D.discount_name , PR.color, PR.size, I.image_url, ((1-D.discount_percent/100)*PR.price) AS Sale
	FROM Products P
		JOIN ProductVariants PR ON PR.product_id = P.product_id
		JOIN ProductImages I ON I.product_id = P.product_id
		JOIN Categories C ON C.category_id = P.category_id
		JOIN Discount_Categories DC ON DC.category_id = C.category_id
		JOIN Discounts D ON D.discount_id = DC.discount_id
	WHERE P.product_id = 'SP004'

	-- 