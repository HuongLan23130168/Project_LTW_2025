<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Noble Loft Theory - Products</title>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/account.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>
<!-- === SIDEBAR === -->
<div class="sidebar" id="sidebar">
    <div class="logo">
        <a href="dashboard.jsp">Noble Loft Theory</a>
    </div>
    <ul>
        <li>
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
        <li class="active">
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
<!-- === ACCOUNT === -->
<div class="main-content account-page">
    <div class="profile-container">
        <h2>Tài khoản Admin</h2>

        <!-- Header -->
        <div class="profile-header">
            <div class="avatar">
                <img src="" alt="Admin">
            </div>
            <div class="info">
                <h3 id="adminName">Nguyễn Lan</h3>
                <p>Administrator | Hồ Chí Minh, Việt Nam</p>
            </div>
            <button class="edit-btn" onclick="toggleEdit()">
                <i class="fas fa-pen-to-square"></i>
                Sửa
            </button>
        </div>

        <!-- Personal Information -->
        <div class="card">
            <h4>Thông tin tài khoản</h4>
            <div class="row"><strong>Email:</strong> <span id="email">admin@gmail.com</span></div>
            <div class="row"><strong>Số điện thoại:</strong> <span id="phone">+84 981 182 4411</span></div>
            <div class="row"><strong>Chức vụ:</strong> Administrator</div>
        </div>

        <!-- Address -->
        <div class="card">
            <h4>Địa chỉ</h4>
            <div class="row"><strong>Quốc gia:</strong> <span id="country">Việt Nam</span></div>
            <div class="row"><strong>Thành phố:</strong> <span id="city">Hồ Chí Minh</span></div>
            <div class="row"><strong>Mã:</strong> <span id="postal">23130168</span></div>
        </div>

        <!-- Form chỉnh sửa (ẩn mặc định) -->
        <div id="editForm" class="card hidden account-page">
            <h4>Thay đổi thông tin</h4>

            <label>Email:</label>
            <input type="email" id="editEmail" value="admin@gmail.com">
            <label>Số điện thoại:</label>
            <input type="text" id="editPhone" value="+84 981 182 4411">
            <label>Thành phố:</label>
            <input type="text" id="editCity" value="Hồ Chí Minh">
            <label>Mã:</label>
            <input type="text" id="editPostal" value="700000">

            <div class="btn-group">
                <button class="save-btn">Lưu</button>
                <button class="cancel-btn" onclick="toggleEdit()">Hủy</button>
            </div>
        </div>

    </div>
</div>

<script src="js/account.js"></script>
</body>

</html>