 CREATE DATABASE LTW_DOAN;
GO

USE LTW_DOAN;
GO


-- ==========================
-- 1. NGƯỜI DÙNG
-- ĐÃ CẬP NHẬT: mat_khau từ NVARCHAR(255) sang VARBINARY(64) để lưu trữ SHA-256 Hash
-- ==========================
CREATE TABLE NguoiDung (
    ma_nd NVARCHAR(10) PRIMARY KEY,    -- vd: KH001
    ten_nd NVARCHAR(100) NOT NULL,
    ngay_sinh DATE,
    gioi_tinh NVARCHAR(10),
    email NVARCHAR(100) UNIQUE NOT NULL,
    mat_khau VARBINARY(64) NOT NULL,    -- Hash SHA-256
    dien_thoai CHAR(12),
    dia_chi NVARCHAR(255),
    vai_tro NVARCHAR(20) DEFAULT 'user'
);
GO

-- ==========================
-- 2. DANH MỤC
-- ==========================
CREATE TABLE DanhMuc (
    ma_dm NVARCHAR(10) PRIMARY KEY,    -- vd: DM001
    ten_dm NVARCHAR(100) NOT NULL,
    loai NVARCHAR(100)
);
GO

-- ==========================
-- 3. SẢN PHẨM
-- ==========================
CREATE TABLE SanPham (
    ma_sp NVARCHAR(10) PRIMARY KEY,    -- vd: SP001
    ten_sp NVARCHAR(150) NOT NULL,
    ma_dm NVARCHAR(10) NOT NULL,
    mo_ta NVARCHAR(MAX),
    FOREIGN KEY (ma_dm) REFERENCES DanhMuc(ma_dm)
);
GO

-- ==========================
-- 4. BIẾN THỂ SẢN PHẨM
-- ==========================
CREATE TABLE BienTheSanPham (
    ma_bt NVARCHAR(10) PRIMARY KEY,    -- vd: BT001
    ma_sp NVARCHAR(10) NOT NULL,
    kieu NVARCHAR(100),
    mau_sac NVARCHAR(50),
    kich_thuoc NVARCHAR(50),
    chat_lieu NVARCHAR(100),
    gia DECIMAL(12,2),
    ton_kho INT DEFAULT 0,
    anh_url NVARCHAR(255),
    FOREIGN KEY (ma_sp) REFERENCES SanPham(ma_sp)
);
GO

-- ==========================
-- 5. ẢNH SẢN PHẨM
-- ==========================
CREATE TABLE AnhSanPham (
    ma_anh NVARCHAR(10) PRIMARY KEY,  -- vd: ANH001
    ma_sp NVARCHAR(10) NOT NULL,
    anh_url NVARCHAR(255) NOT NULL,
    FOREIGN KEY (ma_sp) REFERENCES SanPham(ma_sp)
);
GO

-- ==========================
-- 6. GIỎ HÀNG
-- ==========================
CREATE TABLE GioHang (
    ma_gh NVARCHAR(10) PRIMARY KEY,    -- vd: GH001
    ma_nd NVARCHAR(10) NOT NULL,
    ngay_tao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ma_nd) REFERENCES NguoiDung(ma_nd)
);
GO

-- ==========================
-- 7. CHI TIẾT GIỎ HÀNG
-- ==========================
CREATE TABLE ChiTietGioHang (
    ma_ct NVARCHAR(10) PRIMARY KEY,    -- vd: CTH001
    ma_gh NVARCHAR(10) NOT NULL,
    ma_sp NVARCHAR(10) NOT NULL,
    ma_bt NVARCHAR(10) NULL,
    so_luong INT DEFAULT 1,
    don_gia DECIMAL(12,2) NOT NULL,
    ngay_them DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ma_gh) REFERENCES GioHang(ma_gh),
    FOREIGN KEY (ma_sp) REFERENCES SanPham(ma_sp),
    FOREIGN KEY (ma_bt) REFERENCES BienTheSanPham(ma_bt)
);
GO

-- ==========================
-- 8. ĐƠN HÀNG
-- ==========================
CREATE TABLE DonHang (
    ma_dh NVARCHAR(10) PRIMARY KEY,    -- vd: DH001
    ma_nd NVARCHAR(10) NOT NULL,
    ngay_dat DATETIME DEFAULT GETDATE(),
    trang_thai NVARCHAR(50) DEFAULT N'Đang xử lý',
    tong_tien DECIMAL(12,2) NOT NULL,
    hinh_thuc_thanh_toan NVARCHAR(50),
    dia_chi_giao_hang NVARCHAR(255),
    phuong_thuc_giao_hang NVARCHAR(100),
    ghi_chu NVARCHAR(255),
    FOREIGN KEY (ma_nd) REFERENCES NguoiDung(ma_nd)
);
GO

-- ==========================
-- 9. CHI TIẾT ĐƠN HÀNG
-- ==========================
CREATE TABLE ChiTietDonHang (
    ma_ctdh NVARCHAR(10) PRIMARY KEY,    -- vd: CTDH001
    ma_dh NVARCHAR(10) NOT NULL,
    ma_sp NVARCHAR(10) NOT NULL,
    ma_bt NVARCHAR(10) NULL,
    so_luong INT NOT NULL,
    don_gia DECIMAL(12,2) NOT NULL,
    phi_giao_hang DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (ma_dh) REFERENCES DonHang(ma_dh),
    FOREIGN KEY (ma_sp) REFERENCES SanPham(ma_sp),
    FOREIGN KEY (ma_bt) REFERENCES BienTheSanPham(ma_bt)
);
GO

-- ==========================
-- 10. GIAO HÀNG
-- ==========================
CREATE TABLE GiaoHang (
    ma_gh NVARCHAR(10) PRIMARY KEY,     -- vd: GH001 (Cho Giao Hàng, không trùng với GioHang)
    ma_dh NVARCHAR(10) NOT NULL,
    loai_giao_hang NVARCHAR(20) CHECK (loai_giao_hang IN (N'Tiêu chuẩn', N'Hỏa tốc')),
    phi_giao_hang DECIMAL(10,2) DEFAULT 0,
    trang_thai_giao_hang NVARCHAR(50) DEFAULT N'Chưa giao',
    ma_van_don NVARCHAR(50),
    FOREIGN KEY (ma_dh) REFERENCES DonHang(ma_dh)
);
GO

-- ==========================
-- 11. LIÊN HỆ
-- ==========================
CREATE TABLE LienHe (
    ma_lh NVARCHAR(10) PRIMARY KEY,    -- vd: LH001
    ma_nd NVARCHAR(10) NULL,
    ten_nd NVARCHAR(150),
    email NVARCHAR(255),
    noi_dung NVARCHAR(MAX),
    ngay_gui DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ma_nd) REFERENCES NguoiDung(ma_nd)
);
GO

-- ==========================
-- 12. KHUYẾN MÃI
-- ==========================
CREATE TABLE KhuyenMai (
    ma_km NVARCHAR(10) PRIMARY KEY,    -- vd: KM001
    ten_km NVARCHAR(150) NOT NULL,
    phan_tram_km DECIMAL(5,2) NOT NULL,
    ngay_bat_dau DATETIME NOT NULL,
    ngay_ket_thuc DATETIME NOT NULL,
    mo_ta NVARCHAR(255),
    ngay_tao DATETIME DEFAULT GETDATE()
);
GO

-- ==========================
-- 13. KHUYẾN MÃI DANH MỤC
-- ==========================
CREATE TABLE KhuyenMai_DanhMuc (
    ma_km NVARCHAR(10) NOT NULL,
    ma_dm NVARCHAR(10) NOT NULL,
    PRIMARY KEY (ma_km, ma_dm),
    FOREIGN KEY (ma_km) REFERENCES KhuyenMai(ma_km),
    FOREIGN KEY (ma_dm) REFERENCES DanhMuc(ma_dm)
);
GO
-- ==========================
-- 14. KHUYẾN MÃI SẢN PHẨM
-- ==========================
CREATE TABLE KhuyenMai_SanPham (
    ma_km NVARCHAR(10) NOT NULL,
    ma_sp NVARCHAR(10) NOT NULL,
    PRIMARY KEY (ma_km, ma_sp),
    FOREIGN KEY (ma_km) REFERENCES KhuyenMai(ma_km),
    FOREIGN KEY (ma_sp) REFERENCES SanPham(ma_sp)
);
GO

------------------------------------
-- CHÈN DỮ LIỆU MẪU
------------------------------------

-- ==========================
-- 1. NGƯỜI DÙNG (Mật khẩu đã được HASH)
-- ==========================
INSERT INTO NguoiDung (ma_nd, ten_nd, ngay_sinh , gioi_tinh, email, mat_khau, dien_thoai, dia_chi, vai_tro)
VALUES
('KH001', N'Trịnh Trần Phương Tuấn', '1997-04-12', N'Nam', 'Tuan@gmail.com', HASHBYTES('SHA2_256', '12041997'), '0123456789', N'123 Đường A, Quận 1', 'user'),
('KH002', N'Nguyễn Bảo Khánh', '1999-07-12', N'Nam', 'Khanh@gmail.com', HASHBYTES('SHA2_256', '12071999'), '0987654321', N'456 Đường B, Quận 2', 'user'),
('KH003', N'Admin', '2000-01-01', N'Khác', 'admin@gmail.com', HASHBYTES('SHA2_256', 'admin123'), '0123987654', N'Trụ sở Admin', 'admin');
GO

-- ==========================
-- 2. DANH MỤC
-- ==========================
INSERT INTO DanhMuc (ma_dm, ten_dm, loai)
VALUES
('DM001', N'Cây', N'Phòng khách, Phòng ngủ, Ban công, Phòng bếp, Decor'),
('DM002', N'Tranh', N'Phòng khách, Phòng ngủ, Ban công, Phòng bếp, Decor'),
('DM003', N'Đèn', N'Phòng khách, Phòng ngủ, Ban công, Phòng bếp, Decor'),
('DM004', N'Gương', N'Phòng khách, Phòng ngủ, Decor');

-- ==========================
-- 3. SẢN PHẨM
-- ==========================
INSERT INTO SanPham (ma_sp, ten_sp, ma_dm, mo_ta)
VALUES
('SP001', N'Cây tiểu cảnh trang trí phòng khách', 'DM001', N'Với dáng huyền nghệ thuật, cây bonsai không chỉ là vật trang trí mà còn tượng trưng cho sự trường thọ, kiên cường và thịnh vượng.'),
('SP002', N'Tranh Canvas Hoa', 'DM002', N'Tranh canvas in hoa, chất liệu vải bền'),
('SP003', N'Đèn thả chùm hoa bồ công anh pha lê hiện đại', 'DM003', N'Ánh sáng vàng ấm giúp tạo không gian ấm cúng, sang trọng. Thiết kế gọn nhẹ, hiện đại. Có hướng dẫn lắp đặt, bóng led đuôi ghim dễ dàng thay đổi khi cần thiết'),
('SP004', N'Gương soi Lili Mirror lượn', 'DM004', N'Gương soi Lili Mirror lượn dùng để kết hợp sao cho phù hợp với không gian nhà mình góp phần tạo điểm nhấn nổi bật cho không gian, là món đồ trang trí ngày càng được yêu thích trong thiết kế nội thất.');

-- ==========================
-- 4. BIẾN THỂ SẢN PHẨM
-- ==========================
INSERT INTO BienTheSanPham (ma_bt, ma_sp, kieu, mau_sac, kich_thuoc, chat_lieu, gia, ton_kho, anh_url)
VALUES
('BT001', 'SP001', N'Cổ điển', N'Xanh', N'120cm', N'Polyester, Gỗ', 2000000, 10, N'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-mbt0g23zdz6y09.webp'),
('BT002', 'SP002', N'Hiện đại', N'Trắng', N'30cm', N'Nhựa', 450000, 5, N'https://down-vn.img.susercontent.com/file/vn-11134207-7ra0g-m8m4f5792kxu87.webp'),
('BT003', 'SP003', N'Sang trọng, Qúy phái', N'Trắng', N'90x30cm', N'Hợp kim mạ sơn tĩnh điện, pha lê', 800000, 20, N'https://down-vn.img.susercontent.com/file/890c3c7209ee651dcba710b29de73c21.webp'),
('BT004', 'SP004', N'Hiện đại', N'Đen', N'70x170cm', N'Gương soi có ốp gỗ công nghiệp', 2090000, 15, N'https://product.hstatic.net/200000486527/product/guong_luon5_b85715682457471a8ce4ab56cde1f015_master.jpg'),
('BT005', 'SP004', N'Hiện đại', N'Hồng', N'70x170cm', N'Gương soi có ốp gỗ công nghiệp', 2090000, 25, N'https://product.hstatic.net/200000486527/product/guong_luon_3_cdd45419f88b4daaa418bdd5652f2eca_master.jpg');

-- ==========================
-- 5. ẢNH SẢN PHẨM
-- ==========================
INSERT INTO AnhSanPham (ma_anh, ma_sp, anh_url)
VALUES
('ANH001', 'SP001', N'https://down-vn.img.susercontent.com/file/vn-11134207-7ras8-mbt0g23zdz6y09.webp'),
('ANH002', 'SP002', N'https://down-vn.img.susercontent.com/file/vn-11134207-7ra0g-m8m4f5792kxu87.webp'),
('ANH003', 'SP003', N'https://down-vn.img.susercontent.com/file/890c3c7209ee651dcba710b29de73c21.webp'),
('ANH004', 'SP004', N'https://product.hstatic.net/200000486527/product/guong_luon5_b85715682457471a8ce4ab56cde1f015_master.jpg'),
('ANH005', 'SP004', N'https://product.hstatic.net/200000486527/product/guong_luon_3_cdd45419f88b4daaa418bdd5652f2eca_master.jpg');

-- ==========================
-- 6. GIỎ HÀNG
-- ==========================
INSERT INTO GioHang (ma_gh, ma_nd, ngay_tao)
VALUES
('GH001', 'KH001', GETDATE()),
('GH002', 'KH002', GETDATE());

-- ==========================
-- 7. CHI TIẾT GIỎ HÀNG
-- ==========================
INSERT INTO ChiTietGioHang (ma_ct, ma_gh, ma_sp, ma_bt, so_luong, don_gia)
VALUES
('CTH001', 'GH001', 'SP001', 'BT001', 1, 2000000),
('CTH002', 'GH001', 'SP004', 'BT004', 1, 2090000),
('CTH003', 'GH002', 'SP003', 'BT003', 1, 800000);

-- ==========================
-- 8. ĐƠN HÀNG
-- ==========================
INSERT INTO DonHang (ma_dh, ma_nd, ngay_dat, trang_thai, tong_tien, hinh_thuc_thanh_toan, dia_chi_giao_hang, phuong_thuc_giao_hang, ghi_chu)
VALUES
('DH001', 'KH001', GETDATE(), N'Đã hoàn thành', 2020000, N'Thanh toán khi nhận hàng', N'123 Đường A, Quận 1', N'Tiêu chuẩn', N'Giao trong giờ hành chính'),
('DH002', 'KH002', GETDATE(), N'Đang xử lý', 830000, N'Chuyển khoản', N'456 Đường B, Quận 2', N'Hỏa tốc', N'Giao nhanh');

-- ==========================
-- 9. CHI TIẾT ĐƠN HÀNG
-- ==========================
INSERT INTO ChiTietDonHang (ma_ctdh, ma_dh, ma_sp, ma_bt, so_luong, don_gia, phi_giao_hang)
VALUES
('CTDH001', 'DH001', 'SP001', 'BT001', 1, 2000000, 20000),
('CTDH002', 'DH002', 'SP003', 'BT003', 1, 800000, 30000);

-- ==========================
-- 10. KHUYẾN MÃI
-- ==========================
INSERT INTO KhuyenMai (ma_km, ten_km, phan_tram_km, ngay_bat_dau, ngay_ket_thuc, mo_ta)
VALUES
('KM001', N'Giảm 20% cho Gương', 20, '2025-11-25', '2026-01-30', N'Giảm 20% sản phẩm gương'),
('KM002', N'Giảm 10% cho Cây', 10, '2025-11-15', '2025-12-30', N'Giảm 10% sản phẩm cây');

-- ==========================
-- 11. KHUYẾN MÃI DANH MỤC
-- ==========================
INSERT INTO KhuyenMai_DanhMuc (ma_km, ma_dm)
VALUES 
('KM001', 'DM004'),
('KM002', 'DM001');

-- ==========================
-- 12. KHUYẾN MÃI SẢN PHẨM
-- ==========================
INSERT INTO KhuyenMai_SanPham(ma_km, ma_sp)
VALUES ('KM002', 'SP002');

-- ==========================
-- 13. LIÊN HỆ
-- ==========================
INSERT INTO LienHe (ma_lh, ma_nd, ten_nd, email, noi_dung, ngay_gui)
VALUES
('LH001', 'KH001', N'Trịnh Trần Phương Tuấn', 'Tuan@gmail.com', N'Tôi muốn hỏi về cây tiểu cảnh SP001', GETDATE()),
('LH002', 'KH002', N'Nguyễn Bảo Khánh', 'Khanh@gmail.com', N'Tôi muốn hỏi về tranh canvas SP002', GETDATE()),
('LH003', NULL, N'Khách vãng lai', 'guest@gmail.com', N'Tôi muốn đặt hàng nhưng chưa có tài khoản', GETDATE());

-- ==========================
-- 14. GIAO HÀNG
-- ==========================
INSERT INTO GiaoHang (ma_gh, ma_dh, loai_giao_hang, phi_giao_hang, trang_thai_giao_hang, ma_van_don)
VALUES
('GH001', 'DH001', N'Tiêu chuẩn', 20000, N'Đã giao hàng', 'VD001'),
('GH002', 'DH002', N'Hỏa tốc', 30000, N'Đang giao', 'VD002');


------------------------------------
-- CÁC TRUY VẤN ỨNG DỤNG (USER & ADMIN)
------------------------------------

-- Hiển thị tất cả dữ liệu mẫu
SELECT * FROM NguoiDung;
SELECT * FROM LienHe;
SELECT * FROM GioHang;
SELECT * FROM ChiTietGioHang;
SELECT * FROM DonHang;
SELECT * FROM ChiTietDonHang;
SELECT * FROM GiaoHang;
SELECT * FROM DanhMuc;
SELECT * FROM SanPham;
SELECT * FROM BienTheSanPham;
SELECT * FROM AnhSanPham;
SELECT * FROM KhuyenMai;
SELECT * FROM KhuyenMai_DanhMuc;
SELECT * FROM KhuyenMai_SanPham


--USER

-- ==========================
-- ĐĂNG KÝ NGƯỜI DÙNG MỚI
-- ==========================
-- Ktra email đã tồn tại chưa
DECLARE @email_check_exist NVARCHAR(100) = 'Tung@gmail.com';

IF EXISTS (SELECT 1 FROM NguoiDung WHERE email = @email_check_exist)
    PRINT 'Email đã tồn tại';
ELSE
    PRINT 'Email có thể sử dụng';
GO

-- Thêm người dùng mới (Mật khẩu được HASH)
INSERT INTO NguoiDung (ma_nd, ten_nd, ngay_sinh, gioi_tinh, email, mat_khau, dien_thoai, dia_chi, vai_tro)
VALUES
('KH004', N'Nguyễn Thanh Tùng', '1994-07-05', N'Nam', 'Tung@gmail.com', HASHBYTES('SHA2_256', 'SonTung'), '0571994033', N'12 Thái Bình', 'user'),
('KH005', N'Hoàng Thái Hậu', '1998-09-23', N'Nữ', 'Hau123@gmail.com', HASHBYTES('SHA2_256', 'Hau456'), '0911222333', N'12 Nguyễn Trãi', 'user');
GO

-- Lấy ds 10 tài khoản mới đăng ký
SELECT TOP 10 *
FROM NguoiDung
ORDER BY ma_nd DESC;
GO


-- ==========================
-- ĐĂNG NHẬP NGƯỜI DÙNG
-- ==========================
-- Ktra người dùng đã đăng nhập (Email + Mật khẩu plaintext)

IF EXISTS (SELECT 1 
           FROM NguoiDung 
           WHERE email = 'Tung@gmail.com' 
             AND mat_khau = HASHBYTES('SHA2_256', 'SonTung'))
    PRINT N'Người dùng đã đăng nhập thành công';
ELSE
    PRINT N'Người dùng chưa đăng nhập hoặc sai thông tin';

--Ktra email tồn tại nhưng sai mk 
DECLARE @Email NVARCHAR(100) = 'Hau123@gmail.com';
DECLARE @MatKhau NVARCHAR(64) = 'SonTung';

IF EXISTS (SELECT 1 
           FROM NguoiDung 
           WHERE email = @Email)
BEGIN
    IF NOT EXISTS (SELECT 1 
                   FROM NguoiDung 
                   WHERE email = @Email AND mat_khau = HASHBYTES('SHA2_256', @MatKhau))
        PRINT 'Email đã tồn tại nhưng mật khẩu sai';
    ELSE
        PRINT 'Đăng nhập thành công';
END
ELSE
BEGIN
	PRINT 'Email không tồn tại';
END

-- Lấy đầy đủ thông tin người dùng sau khi đăng nhập (Cách tốt nhất: Dùng biến tham số và Hash)
SELECT ma_nd, ten_nd, ngay_sinh, gioi_tinh, email, dien_thoai, dia_chi, vai_tro
FROM NguoiDung
WHERE email = 'Tung@gmail.com' AND mat_khau = HASHBYTES('SHA2_256','SonTung');
GO

--Ktra vai trò (User/Admin) 
SELECT vai_tro
FROM NguoiDung 
WHERE email = 'Tung@gmail.com';

-- ==========================
--QUÊN MẬT KHẨU 
-- ==========================
--Cập nhật mk mới cho tài khoản 
UPDATE NguoiDung 
SET mat_khau = HASHBYTES('SHA2_256','Matkhaumoi')
WHERE email = 'Hau123@gmail.com'; 
SELECT ma_nd, ten_nd, email, mat_khau
FROM NguoiDung
WHERE email = 'Hau123@gmail.com';

-- ==========================
-- QUẢN LÝ TÀI KHOẢN
-- ==========================
-- Cập nhật thông tin người dùng (Ví dụ: Cập nhật Giới tính và Địa chỉ)
UPDATE NguoiDung
SET gioi_tinh = N'Nam', dia_chi = N'123 Đường C, Quận 3'
WHERE ma_nd = 'KH005';

SELECT * FROM NguoiDung WHERE ma_nd = 'KH005';
GO

-- Thay đổi mật khẩu người dùng
DECLARE 
    @MaND NVARCHAR(10) = 'KH004',             -- Mã người dùng
    @MatKhauCu NVARCHAR(255) = 'SonTung',     -- Mật khẩu cũ (plaintext)
    @MatKhauMoi NVARCHAR(255) = 'STMTP';      -- Mật khẩu mới (plaintext)

-- Thử cập nhật
IF EXISTS (
    SELECT 1 
    FROM NguoiDung
    WHERE ma_nd = @MaND 
      AND mat_khau = HASHBYTES('SHA2_256', @MatKhauCu)
)
BEGIN
    UPDATE NguoiDung
    SET mat_khau = HASHBYTES('SHA2_256', @MatKhauMoi)
    WHERE ma_nd = @MaND;

    PRINT N'Đổi mật khẩu thành công!';
END
ELSE
BEGIN
    PRINT N'Mật khẩu cũ không đúng, không thể thay đổi.';
END

-- Xem kết quả (hash mật khẩu mới)
SELECT ma_nd, email, mat_khau 
FROM NguoiDung
WHERE ma_nd = @MaND;
GO

-- Lấy ds tất cả người dùng (Admin xem)
SELECT *
FROM NguoiDung
WHERE vai_tro = 'user'
ORDER BY ma_nd ASC;

-- ==========================
-- ĐƯỜNG DẪN TRANG
-- ==========================
-- Lấy breadcrumb khi đang ở trang sản phẩm
SELECT 
    p.ten_sp AS san_pham,
    d.ten_dm AS danh_muc
FROM SanPham p
JOIN DanhMuc d ON p.ma_dm = d.ma_dm
WHERE p.ma_sp = 'SP001';

-- ==========================
-- BỘ LỌC TÌM KIẾM
-- ==========================
-- Lọc theo danh mục
SELECT *
FROM SanPham 
WHERE ma_dm = 'DM004'

-- Lọc theo khoảng giá
SELECT 
    p.*, 
    MIN(bt.gia) AS min_gia
FROM SanPham p
JOIN BienTheSanPham bt ON p.ma_sp = bt.ma_sp
GROUP BY p.ma_sp, p.ten_sp, p.ma_dm, p.mo_ta
HAVING MIN(bt.gia) BETWEEN 500000 AND 1000000;

-- Lọc theo màu sắc
SELECT DISTINCT p.*
FROM SanPham p
JOIN BienTheSanPham bt ON p.ma_sp = bt.ma_sp
WHERE bt.mau_sac =  N'Trắng';

-- Lọc theo phòng (loại)
SELECT p.*
FROM SanPham p
JOIN DanhMuc d ON p.ma_dm = d.ma_dm
WHERE d.loai LIKE '%' + N'Ban công' + '%';

-- Lọc theo đa tiêu chí (Khuyến mãi)
SELECT DISTINCT
    p.ma_sp,
    p.ten_sp,
    dm.ten_dm,
    km.ten_km,
    km.phan_tram_km
FROM KhuyenMai km
JOIN KhuyenMai_DanhMuc kdm ON km.ma_km = kdm.ma_km
JOIN SanPham p ON p.ma_dm = kdm.ma_dm
JOIN DanhMuc dm ON dm.ma_dm = p.ma_dm
WHERE 
    GETDATE() BETWEEN km.ngay_bat_dau AND km.ngay_ket_thuc;

DECLARE @today DATE = '2025-11-26'; -- Ngày nằm trong KM001
SELECT DISTINCT
    p.ma_sp,
    p.ten_sp,
    dm.ten_dm,
    km.ten_km,
    km.phan_tram_km
FROM KhuyenMai km
JOIN KhuyenMai_DanhMuc kdm ON km.ma_km = kdm.ma_km
JOIN SanPham p ON p.ma_dm = kdm.ma_dm
JOIN DanhMuc dm ON dm.ma_dm = p.ma_dm
WHERE @today BETWEEN km.ngay_bat_dau AND km.ngay_ket_thuc
  AND dm.ten_dm = N'Gương';


select * from SanPham
SELECT * FROM DanhMuc
select * from KhuyenMai
select * from KhuyenMai_DanhMuc
select * from KhuyenMai_SanPham


-- DANH SÁCH SẢN PHẨM (Lấy tất cả sản phẩm + giá thấp nhất/cao nhất của biến thể và ảnh đại diện)
SELECT
    p.ma_sp,
    p.ten_sp,
    d.ten_dm,
    MIN(bt.gia) AS gia_thap_nhat,
    MAX(bt.gia) AS gia_cao_nhat
    --(SELECT TOP 1 anh_url FROM AnhSanPham WHERE ma_sp = p.ma_sp ORDER BY ma_anh) AS anh_dai_dien
FROM
    SanPham p
JOIN
    DanhMuc d ON p.ma_dm = d.ma_dm
JOIN
    BienTheSanPham bt ON p.ma_sp = bt.ma_sp
GROUP BY
    p.ma_sp, p.ten_sp, d.ten_dm;
GO


-- ==========================
-- GIỎ HÀNG
-- ==========================
-- Kiểm tra khách hàng có giỏ chưa
SELECT ma_gh 
FROM GioHang 
WHERE ma_nd = 'KH001';

-- Lấy giỏ hàng của người dùng
SELECT gh.ma_gh, cth.ma_ct, p.ten_sp, bt.kieu, bt.mau_sac, cth.so_luong, cth.don_gia
FROM GioHang gh
	JOIN ChiTietGioHang cth ON gh.ma_gh = cth.ma_gh
	JOIN SanPham p ON cth.ma_sp = p.ma_sp
	LEFT JOIN BienTheSanPham bt ON cth.ma_bt = bt.ma_bt
WHERE gh.ma_nd = 'KH001';

-- Checkbox sản phẩm
DECLARE @SelectedCT NVARCHAR(MAX) = 'CTH001,CTH002';
-- Chuyển chuỗi thành bảng tạm
DECLARE @SelectedCTs TABLE (ma_ct NVARCHAR(10));
INSERT INTO @SelectedCTs (ma_ct)
SELECT value FROM STRING_SPLIT(@SelectedCT, ',');

-- Lấy chi tiết các sản phẩm được chọn
SELECT 
    c.ma_ct,
    p.ten_sp,
    bt.kieu,
    bt.mau_sac,
    c.so_luong,
    c.don_gia,
    (c.so_luong * c.don_gia) AS thanh_tien
FROM ChiTietGioHang c
JOIN GioHang g ON c.ma_gh = g.ma_gh
JOIN SanPham p ON c.ma_sp = p.ma_sp
LEFT JOIN BienTheSanPham bt ON c.ma_bt = bt.ma_bt
JOIN @SelectedCTs s ON c.ma_ct = s.ma_ct
WHERE g.ma_nd = 'KH001';



-- Tăng số lượng sản phẩm trong giỏ
UPDATE c
SET so_luong = so_luong + 1
FROM ChiTietGioHang c
JOIN GioHang g ON c.ma_gh = g.ma_gh
WHERE g.ma_nd = 'KH001'
  AND c.ma_ct = 'CTH001';

-- Giảm số lượng sản phẩm trong giỏ (ko <1)
UPDATE c
SET so_luong = so_luong - 1
FROM ChiTietGioHang c
JOIN GioHang g ON c.ma_gh = g.ma_gh
WHERE g.ma_nd = 'KH001'
  AND c.ma_ct = 'CTH001'
  AND c.so_luong > 1;

-- Xóa sản phẩm trong giỏ
DELETE c
FROM ChiTietGioHang c
JOIN GioHang g ON c.ma_gh = g.ma_gh
WHERE g.ma_nd = 'KH001'
  AND c.ma_ct = 'CTH002';

select * from ChiTietGioHang
select * from BienTheSanPham

-- Thêm sản phẩm 
INSERT INTO ChiTietGioHang (ma_ct, ma_gh, ma_sp, ma_bt, so_luong, don_gia)
VALUES
('CTH002', 'GH001', 'SP004', 'BT004', 1, 2090000);

-- Lấy tổng số sản phẩm có trong giỏ của khách hàng
SELECT SUM(c.so_luong) AS tong_so_san_pham
FROM ChiTietGioHang c
JOIN GioHang g ON c.ma_gh = g.ma_gh
WHERE g.ma_nd = 'KH001';

-- Tính tổng tiền trong giỏ
SELECT 
    SUM(c.so_luong * c.don_gia) AS tong_tien
FROM ChiTietGioHang c
JOIN GioHang g ON c.ma_gh = g.ma_gh
WHERE g.ma_nd = 'KH001';

-- ==========================
-- ĐƠN HÀNG
-- ==========================
-- Thông tin khách hàng + đơn hàng
SELECT 
    nd.ma_nd,
    nd.ten_nd,
    nd.email,
    nd.dien_thoai,
    nd.dia_chi,
    dh.ma_dh,
    dh.ngay_dat,
    dh.trang_thai,
    dh.tong_tien,
    dh.hinh_thuc_thanh_toan,
    dh.phuong_thuc_giao_hang,
    dh.dia_chi_giao_hang
FROM DonHang dh
JOIN NguoiDung nd ON dh.ma_nd = nd.ma_nd
ORDER BY dh.ngay_dat DESC;

-- Xem chi tiết sản phẩm trong đơn hàng
SELECT 
    dh.ma_dh,
    cth.ma_ctdh,
    sp.ten_sp,
    bt.kieu,
    bt.mau_sac,
    cth.so_luong,
    cth.don_gia,
    cth.phi_giao_hang,
    (cth.so_luong * cth.don_gia + cth.phi_giao_hang) AS thanh_tien
FROM ChiTietDonHang cth
JOIN DonHang dh ON cth.ma_dh = dh.ma_dh
JOIN SanPham sp ON cth.ma_sp = sp.ma_sp
LEFT JOIN BienTheSanPham bt ON cth.ma_bt = bt.ma_bt
WHERE dh.ma_nd = 'KH001'
ORDER BY dh.ma_dh;

-- Xem thôn tin vận chuyển
SELECT 
    dh.ma_dh,
    dh.trang_thai AS trang_thai_dh,
    gh.loai_giao_hang,
    gh.phi_giao_hang,
    gh.trang_thai_giao_hang,
    gh.ma_van_don
FROM DonHang dh
LEFT JOIN GiaoHang gh ON dh.ma_dh = gh.ma_dh
WHERE dh.ma_nd = 'KH001'
ORDER BY dh.ngay_dat DESC;

-- Xem thanh toán của 1 đơn hàng cụ thể
DECLARE @ma_dh NVARCHAR(10) = 'DH001';

SELECT 
    dh.ma_dh,
    dh.tong_tien,
    dh.hinh_thuc_thanh_toan,
    SUM(cth.so_luong * cth.don_gia + cth.phi_giao_hang) AS thanh_toan_tong
FROM DonHang dh
JOIN ChiTietDonHang cth ON dh.ma_dh = cth.ma_dh
WHERE dh.ma_dh = @ma_dh
GROUP BY dh.ma_dh, dh.tong_tien, dh.hinh_thuc_thanh_toan;

-- viết một Stored Procedure SQL Server cho bạn, có thể xem tất cả thông tin đơn hàng của người dùng dựa trên ma_nd (mã người dùng) hoặc ma_dh (mã đơn hàng)
-- =============================================
-- Procedure: XemDonHangNguoiDung
-- Input: @MaND NVARCHAR(10) = NULL, @MaDH NVARCHAR(10) = NULL
-- Output: Thông tin khách hàng, đơn hàng, chi tiết sản phẩm, vận chuyển
-- =============================================
CREATE PROCEDURE XemDonHangNguoiDung
    @MaND NVARCHAR(10) = NULL,
    @MaDH NVARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        nd.ma_nd,
        nd.ten_nd,
        nd.email,
        nd.dien_thoai,
        nd.dia_chi AS dia_chi_khach_hang,
        dh.ma_dh,
        dh.ngay_dat,
        dh.trang_thai AS trang_thai_dh,
        dh.tong_tien,
        dh.hinh_thuc_thanh_toan,
        dh.phuong_thuc_giao_hang,
        dh.dia_chi_giao_hang,
        gh.loai_giao_hang,
        gh.phi_giao_hang,
        gh.trang_thai_giao_hang,
        gh.ma_van_don,
        sp.ten_sp,
        bt.kieu,
        bt.mau_sac,
        cth.so_luong,
        cth.don_gia,
        cth.phi_giao_hang,
        (cth.so_luong * cth.don_gia + cth.phi_giao_hang) AS thanh_tien
    FROM DonHang dh
    JOIN NguoiDung nd ON dh.ma_nd = nd.ma_nd
    LEFT JOIN ChiTietDonHang cth ON dh.ma_dh = cth.ma_dh
    LEFT JOIN SanPham sp ON cth.ma_sp = sp.ma_sp
    LEFT JOIN BienTheSanPham bt ON cth.ma_bt = bt.ma_bt
    LEFT JOIN GiaoHang gh ON dh.ma_dh = gh.ma_dh
    WHERE (@MaND IS NULL OR nd.ma_nd = @MaND)
      AND (@MaDH IS NULL OR dh.ma_dh = @MaDH)
    ORDER BY dh.ma_dh, cth.ma_ctdh;
END;
GO

EXEC XemDonHangNguoiDung @MaND = 'KH001';

-- ==================================
-- HOÀN TẤT
-- ==================================
-- Xem chi tiết dơn hàng vừa tạo
SELECT dh.ma_dh, dh.ngay_dat, dh.trang_thai, dh.tong_tien, c.ma_sp, p.ten_sp, c.so_luong, c.don_gia
FROM DonHang dh
JOIN ChiTietDonHang c ON dh.ma_dh = c.ma_dh
JOIN SanPham p ON c.ma_sp = p.ma_sp
WHERE dh.ma_dh = 'DH001';

SELECT * FROM NguoiDung
select * from GioHang
select * from ChiTietGioHang
select * from DonHang
select * from ChiTietDonHang


-- ==================================
-- ADMIN
-- ==================================
-- Doanh thu theo tháng
CREATE PROCEDURE DoanhThuTheoThang
    @Nam INT,
    @Thang INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        dh.ma_dh,
        dh.ngay_dat,
        dh.tong_tien,
        nd.ten_nd AS khach_hang
    FROM DonHang dh
    JOIN NguoiDung nd ON dh.ma_nd = nd.ma_nd
    WHERE YEAR(dh.ngay_dat) = @Nam
      AND MONTH(dh.ngay_dat) = @Thang
    ORDER BY dh.ngay_dat;

    -- Tổng doanh thu tháng
    SELECT SUM(tong_tien) AS Tong_Doanh_Thu
    FROM DonHang
    WHERE YEAR(ngay_dat) = @Nam
      AND MONTH(ngay_dat) = @Thang;
END;
GO

-- Sử dụng:
EXEC DoanhThuTheoThang @Nam = 2025, @Thang = 11;

-- Doanh thu theo tháng
SELECT dh.ma_dh, dh.ngay_dat, dh.tong_tien, nd.ten_nd AS khach_hang
FROM DonHang dh
JOIN NguoiDung nd ON dh.ma_nd = nd.ma_nd
WHERE YEAR(dh.ngay_dat) = 2025 AND MONTH(dh.ngay_dat) = 11
ORDER BY dh.ngay_dat;

SELECT SUM(tong_tien) AS Tong_Doanh_Thu
FROM DonHang
WHERE YEAR(ngay_dat) = 2025 AND MONTH(ngay_dat) = 11;


-- Sản phẩm bán chạy
CREATE PROCEDURE SanPhamBanChay
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 10 
        sp.ma_sp,
        sp.ten_sp,
        SUM(cth.so_luong) AS tong_da_ban
    FROM ChiTietDonHang cth
    JOIN SanPham sp ON cth.ma_sp = sp.ma_sp
    GROUP BY sp.ma_sp, sp.ten_sp
    ORDER BY tong_da_ban DESC;
END;
GO

-- Sử dụng:
EXEC SanPhamBanChay;

-- Top 10 sp bán chạy
SELECT TOP 10 
    sp.ma_sp,
    sp.ten_sp,
    SUM(cth.so_luong) AS tong_da_ban
FROM ChiTietDonHang cth
JOIN SanPham sp ON cth.ma_sp = sp.ma_sp
GROUP BY sp.ma_sp, sp.ten_sp
ORDER BY tong_da_ban DESC;


-- Đơn hàng gần nhất
CREATE PROCEDURE DonHangGanNhat
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 10 
        dh.ma_dh,
        dh.ngay_dat,
        dh.trang_thai,
        dh.tong_tien,
        nd.ten_nd AS khach_hang
    FROM DonHang dh
    JOIN NguoiDung nd ON dh.ma_nd = nd.ma_nd
    ORDER BY dh.ngay_dat DESC;
END;
GO

-- Sử dụng:
EXEC DonHangGanNhat;

-- ADMIN: Thay đổi thông tin Admin
UPDATE NguoiDung
SET dien_thoai = '0988776655', dia_chi = N'Trụ sở Admin mới'
WHERE ma_nd = 'KH003' AND vai_tro = 'admin';

SELECT * FROM NguoiDung WHERE ma_nd = 'KH003';
GO

CREATE PROCEDURE CapNhatAdmin
    @MaND NVARCHAR(10),
    @DienThoai CHAR(12),
    @DiaChi NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE NguoiDung
    SET dien_thoai = @DienThoai,
        dia_chi = @DiaChi
    WHERE ma_nd = @MaND
      AND vai_tro = 'admin';

    SELECT * 
    FROM NguoiDung
    WHERE ma_nd = @MaND;
END;
GO

-- Sử dụng:
EXEC CapNhatAdmin @MaND = 'KH003', @DienThoai = '0999888777', @DiaChi = N'Trụ sở Admin mới';


-- Tìm kiếm đơn hàng theo mã khách, tên khách hoặc mã đơn hàng:
CREATE PROCEDURE TimKiemDonHang
    @TuKhoa NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        dh.ma_dh,
        nd.ma_nd,
        nd.ten_nd,
        dh.ngay_dat,
        dh.tong_tien,
        dh.trang_thai
    FROM DonHang dh
    JOIN NguoiDung nd ON dh.ma_nd = nd.ma_nd
    WHERE dh.ma_dh LIKE '%' + @TuKhoa + '%'
       OR nd.ma_nd LIKE '%' + @TuKhoa + '%'
       OR nd.ten_nd LIKE '%' + @TuKhoa + '%'
    ORDER BY dh.ngay_dat DESC;
END;
GO

-- Sử dụng:
EXEC TimKiemDonHang @TuKhoa = 'KH001';

-- Tìm kiếm sản phẩm theo tên hoặc danh mục:
IF OBJECT_ID('TimKiemSanPham', 'P') IS NOT NULL
    DROP PROCEDURE TimKiemSanPham;
GO

CREATE PROCEDURE TimKiemSanPham
    @TuKhoa NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        sp.ma_sp,
        sp.ten_sp,
        dm.ten_dm,
        MIN(bt.gia) AS gia_thap_nhat  -- hoặc MAX(bt.gia) nếu muốn giá cao nhất
    FROM SanPham sp
    JOIN DanhMuc dm ON sp.ma_dm = dm.ma_dm
    LEFT JOIN BienTheSanPham bt ON sp.ma_sp = bt.ma_sp
    WHERE sp.ten_sp LIKE '%' + @TuKhoa + '%'
       OR dm.ten_dm LIKE '%' + @TuKhoa + '%'
    GROUP BY sp.ma_sp, sp.ten_sp, dm.ten_dm
    ORDER BY sp.ten_sp;
END;
GO

-- Sử dụng:
EXEC TimKiemSanPham @TuKhoa = N'Gương';

