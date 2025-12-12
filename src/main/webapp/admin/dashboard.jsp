<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Noble Loft Theory - Admin</title>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>
<!-- === SIDEBAR === -->
<div class="sidebar" id="sidebar">
    <div class="logo">
        <a href="dashboard.jsp">Noble Loft Theory</a>
    </div>

    <ul>
        <li class="active">
            <a href="dashboard.jsp"><i class="fas fa-chart-line"></i> Dashboard</a>
        </li>
        <li>
            <a href="products.jsp"><i class="fas fa-box"></i> Sản phẩm</a>
        </li>
        <li>
            <a href="orders.jsp"><i class="fas fa-cart-shopping"></i> Đơn hàng</a>
        </li>
        <li>
            <a href="customers.jsp"><i class="fas fa-users"></i> Khách hàng</a>
        </li>
        <li>
            <a href="notifi.jsp"><i class="fas fa-bell"></i> Thông báo</a>
        </li>
        <li>
            <a href="account.jsp"><i class="fas fa-gear"></i> Tài khoản</a>
        </li>
    </ul>
</div>

<!-- === HEADER === -->
<header class="header">
    <div class="header-left">
        <div class="search-container">
            <i class="fa-solid fa-magnifying-glass" style="color: #74512d;"></i>
            <input type="text" placeholder="Tìm kiếm" class="search-input"/>
        </div>
    </div>

    <div class="header-right">
        <!-- Nút thông báo -->
        <div class="notify-wrapper">
            <a href="notifi.jsp" class="icon-button">
                <i class="fa-solid fa-bell"></i>
                <span id="notifyCount" class="notify-badge">3</span>
            </a>
        </div>

        <!-- Hồ sơ người dùng -->
        <div class="profile-dropdown">
            <button class="icon-button user-btn">
                <i class="fa-solid fa-user"></i>
            </button>

            <div class="dropdown-menu">
                <a href="account.jsp"><i class="fas fa-user"></i> Tài khoản</a>
                <a href="index.jsp"><i class="fas fa-right-from-bracket"></i> Đăng xuất</a>
            </div>
        </div>
    </div>
</header>

<!-- === DASHBOARD === -->
<div class="main-content">

    <div class="cards">
        <div class="card">
            <div class="card-header">
                <i class="fas fa-coins"></i>
                <h4>Doanh thu (tháng)</h4>
            </div>
            <h2>₫152,500,000</h2>
            <p>+12% so với tháng trước</p>
        </div>

        <div class="card">
            <div class="card-header">
                <i class="fas fa-box-open"></i>
                <h4>Sản phẩm bán chạy</h4>
            </div>
            <h2>24</h2>
            <p>Top: Gương trang trí</p>
        </div>

        <div class="card">
            <div class="card-header">
                <i class="fas fa-warehouse"></i>
                <h4>Tồn kho</h4>
            </div>
            <h2>420 sp</h2>
            <p>Cần nhập: 12</p>
        </div>

        <div class="card">
            <div class="card-header">
                <i class="fas fa-shopping-bag"></i>
                <h4>Đơn hàng mới</h4>
            </div>
            <h2>18</h2>
            <p>Chờ xử lý: 5</p>
        </div>
    </div>

    <div class="stats-section">
        <div class="chart-section">
            <h3>Biểu đồ Doanh thu (7 ngày)</h3>
        </div>

        <div class="best-seller">
            <h3>Sản phẩm bán chạy</h3>
            <ul class="top-products">
                <li>
                    <img src="https://product.hstatic.net/200000486527/product/guong_luon_4_a612966793bb490497b9612c2aec1d88_master.jpg"
                         alt="">
                    <div>
                        <strong class="prod-title">Gương soi Lili Mirror lượn</strong>
                        <p class="muted">2.100.000₫ • 120 bán</p>
                    </div>
                </li>
                <li>
                    <img src="https://down-vn.img.susercontent.com/file/sg-11134201-7rdww-m0byn0wu6vda84.webp"
                         alt="">
                    <div>
                        <strong class="prod-title">Đồng Hồ Tráng Gương Hươu Tài Lộc</strong>
                        <p class="muted">320,000₫ • 89 bán</p>
                    </div>
                </li>
                <li>
                    <img src="https://down-vn.img.susercontent.com/file/vn-11134207-820l4-mek6225m4q9x4c.webp"
                         alt="">
                    <div>
                        <strong class="prod-title">Nến thơm Soyam by Citta</strong>
                        <p class="muted">185,000₫ • 70 bán</p>
                    </div>
                </li>
                <li>
                    <img src="https://product.hstatic.net/200000486527/product/img_4118_3465223127a34592a0671827a04680e8_master.jpg"
                         alt="">
                    <div>
                        <strong class="prod-title">Thảm trải sàn cao cấp Arcus phong cách Bắc Âu</strong>
                        <p class="muted">180,000₫ • 65 bán</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>


    <div class="recent-orders">
        <div class="recent-orders-header">
            <h3>Đơn hàng gần đây</h3>
            <div class="search-orders">
                <input type="text" placeholder="Tìm mã / Khách hàng..." class="search-input-orders">
                <i class="fas fa-search search-icon-orders"></i>
            </div>
        </div>

        <div class="recent-orders">
            <table>
                <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Khách hàng</th>
                    <th>Sản phẩm</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td><a href="viewOrders.jsp">#1029</a></td>
                    <td>Trần Hoàng Thượng</td>
                    <td>Gương trang trí</td>
                    <td>450,000₫</td>
                    <td><span class="status delivered">Đã giao</span></td>
                </tr>
                <tr>
                    <td><a href="viewOrders.jsp">#1031</a></td>
                    <td>Hoàng Thái Hậu</td>
                    <td>Bình hoa gốm</td>
                    <td>180,000₫</td>
                    <td><span class="status cancelled">Đã hủy</span></td>
                </tr>
                <tr>
                    <td><a href="viewOrders.jsp">#1030</a></td>
                    <td>Nguyễn Thanh Tùng</td>
                    <td>Đèn bàn treo</td>
                    <td>320,000₫</td>
                    <td><span class="status processing">Đang xử lý</span></td>
                </tr>
                <tr>
                    <td><a href="viewOrders.jsp">#1032</a></td>
                    <td>Lê Quang Hải Tú</td>
                    <td>Đồng hồ treo tường hoa hướng dương theo phòng cách Châu Âu</td>
                    <td>180,000₫</td>
                    <td><span class="status cancelled">Đã hủy</span></td>
                </tr>
                <tr>
                    <td><a href="viewOrders.jsp">#1033</a></td>
                    <td>Nguyễn Thúc Cao Thị Kim Ngân</td>
                    <td>Đồng hồ treo tường hoa hướng dương theo phòng cách Châu Âu</td>
                    <td>180,000₫</td>
                    <td><span class="status delivered">Đã giao</span></td>
                </tr>
                <tr>
                    <td><a href="viewOrders.jsp">#1034</a></td>
                    <td>Trịnh Trần Phương Tuấn</td>
                    <td>Đồng hồ treo tường hoa hướng dương theo phòng cách Châu Âu</td>
                    <td>180,000₫</td>
                    <td><span class="status cancelled">Đã hủy</span></td>
                </tr>
                <tr>
                    <td><a href="viewOrders.jsp">#1035</a></td>
                    <td>Nguyễn Bảo Khánh</td>
                    <td>Đồng hồ treo tường hoa hướng dương theo phòng cách Châu Âu</td>
                    <td>180,000₫</td>
                    <td><span class="status processing">Đang xử lý</span></td>
                </tr>
                <tr>
                    <td><a href="viewOrders.jsp">#1036</a></td>
                    <td>Phan Thảo Tiên</td>
                    <td>Đồng hồ treo tường hoa hướng dương theo phòng cách Châu Âu</td>
                    <td>180,000₫</td>
                    <td><span class="status processing">Đang xử lý</span></td>
                </tr>
                </tbody>
            </table>
        </div>

    </div>


    <script src="js/main.js"></script>
</body>

</html>