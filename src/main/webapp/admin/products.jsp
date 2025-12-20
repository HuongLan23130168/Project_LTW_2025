<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Noble Loft Theory - Products</title>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/products.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>
<!-- === SIDEBAR === -->
<div class="sidebar" id="sidebar">
    <div class="logo"><a href="dashboard.jsp">Noble Loft Theory</a></div>
    <ul>
        <li><a href="dashboard.jsp"><i class="fas fa-chart-line"></i> Dashboard</a></li>
        <li class="active"><a href="products.jsp"><i class="fas fa-box"></i> Sản phẩm</a></li>
        <li><a href="orders.jsp"><i class="fas fa-cart-shopping"></i> Đơn hàng</a></li>
        <li><a href="customers.jsp"><i class="fas fa-users"></i> Khách hàng</a></li>
        <li><a href="notifi.jsp"><i class="fas fa-bell"></i> Thông báo</a></li>
        <li><a href="account.jsp"><i class="fas fa-gear"></i> Tài khoản</a></li>
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
        <div class="notify-wrapper">
            <a href="notifi.jsp" class="icon-button">
                <i class="fa-solid fa-bell"></i>
                <span id="notifyCount" class="notify-badge">3</span>
            </a>
        </div>
        <div class="profile-dropdown">
            <button class="icon-button user-btn"><i class="fa-solid fa-user"></i></button>
            <div class="dropdown-menu">
                <a href="account.jsp"><i class="fas fa-user"></i> Tài khoản</a>
                <a href="index.jsp"><i class="fas fa-right-from-bracket"></i> Đăng xuất</a>
            </div>
        </div>
    </div>
</header>

<!-- === PRODUCTS === -->
<div class="main-content">
    <h1>Quản lý sản phẩm</h1>

    <div class="top-bar">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" id="searchProduct" placeholder="Tìm kiếm sản phẩm...">
        </div>
        <a href="addProducts.jsp" class="btn-add">+ Thêm sản phẩm</a>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
            <tr>
                <th>Mã</th>
                <th>Thông tin</th>
                <th>Kích thước</th>
                <th>Danh mục</th>
                <th>Giá</th>
                <th>Giá KM</th>
                <th>Kho</th>
                <th>Tag</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody id="tbody">
            <tr>
                <td>1</td>
                <td class="product-info">
                    <img src="https://product.hstatic.net/200000065946/product/pro_mau_trang_ban_sofa_kline__3__fd8b995b9431476890de2dc742aacb75_master.png"
                         alt="">
                    <span>Set Bàn Sofa Gỗ KLINE</span>
                </td>
                <td>50x48 cm</td>
                <td><span class="pill">Bàn</span></td>
                <td><b>1.490.000₫</b></td>
                <td>1.400.000₫</td>
                <td>12</td>
                <td><span class="tag hot">Hot</span></td>
                <td>
                    <button class="btn secondary">Sửa</button>
                    <button class="btn delete">Xóa</button>
                </td>
            </tr>

            <tr>
                <td>2</td>
                <td class="product-info">
                    <img src="https://product.hstatic.net/200000065946/product/pro_mau_trang_ban_sofa_kline__3__fd8b995b9431476890de2dc742aacb75_master.png"
                         alt="">
                    <span>Set Bàn Sofa Gỗ KLINE</span>
                </td>
                <td>50x48 cm</td>
                <td><span class="pill">Bàn</span></td>
                <td><b>1.490.000₫</b></td>
                <td>1.400.000₫</td>
                <td>12</td>
                <td><span class="tag hot">Hot</span></td>
                <td>
                    <button class="btn secondary">Sửa</button>
                    <button class="btn delete">Xóa</button>
                </td>
            </tr>

            <tr>
                <td>3</td>
                <td class="product-info">
                    <img src="https://product.hstatic.net/200000065946/product/pro_mau_trang_ban_sofa_kline__3__fd8b995b9431476890de2dc742aacb75_master.png"
                         alt="">
                    <span>Set Bàn Sofa Gỗ KLINE</span>
                </td>
                <td>50x48 cm</td>
                <td><span class="pill">Bàn</span></td>
                <td><b>1.490.000₫</b></td>
                <td>1.400.000₫</td>
                <td>12</td>
                <td><span class="tag hot">Hot</span></td>
                <td>
                    <button class="btn secondary">Sửa</button>
                    <button class="btn delete">Xóa</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>


    <script src="js/main.js"></script>
    <script src="js/products.js"></script>
</body>

</html>