<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phòng khách</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/living.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">
</head>

<body>
<!-- === HEADER === -->
<header class="header">
    <div class="header-top">
        <div class="logo">
            <img src="https://i.postimg.cc/5t4yq9qJ/logo-ltw.jpg" alt="Logo">
            <span>
                <a href="${pageContext.request.contextPath}/home.jsp">
                    Noble Loft Theory
                </a>
            </span>
        </div>

        <div class="search-box">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" placeholder="Tìm kiếm">
        </div>

        <div class="header-right">
            <a href="${pageContext.request.contextPath}/tracking.jsp">Tra cứu đơn hàng</a>
            <a href="${pageContext.request.contextPath}/gioithieu.jsp">Giới thiệu</a>
            <a href="${pageContext.request.contextPath}/contact.jsp">Liên hệ</a>
            <div class="icons">
                <a href="${pageContext.request.contextPath}/cart.jsp" class="circle">
                    <i class="fa-solid fa-cart-shopping"></i>
                </a>
                <a href="${pageContext.request.contextPath}/account.jsp" class="circle">
                    <i class="fa-solid fa-user"></i>
                </a>
            </div>
        </div>
    </div>

    <nav class="menu">
        <a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a>

        <a href="${pageContext.request.contextPath}/list-product"
           class="active">Phòng khách</a>

        <a href="${pageContext.request.contextPath}/kitchen.jsp">Phòng bếp</a>
        <a href="${pageContext.request.contextPath}/bedroom.jsp">Phòng ngủ</a>
        <a href="${pageContext.request.contextPath}/office.jsp">Phòng làm việc</a>
        <a href="${pageContext.request.contextPath}/balcony.jsp">Ban Công</a>
    </nav>
</header>

<!-- === BREADCRUMB === -->
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/home.jsp">Trang chủ</a> &#47;
    <span class="current">Phòng khách</span>
</nav>

<div class="container">
    <!-- === SIDEBAR === -->
    <form action="${pageContext.request.contextPath}/list-product" method="get">
        <aside class="sidebar" id="filter-sidebar">
            <h3>Bộ lọc tìm kiếm</h3>

            <!-- === MỨC GIÁ === -->
            <div class="filter-group">
                <label class="filter-label" style="cursor: pointer;">
                    <span>Mức giá</span>
                    <span class="filter-icon"><i class="fa-solid fa-chevron-down"></i></span>
                </label>
                <div class="options" style="display: none;">
                    <div><input type="radio" name="price" value="all" checked> Tất cả</div>
                    <div><input type="radio" name="price" value="1"> Dưới 500.000₫</div>
                    <div><input type="radio" name="price" value="2"> 500.000₫ - 1.000.000₫</div>
                    <div><input type="radio" name="price" value="3"> 1.000.000₫ - 3.000.000₫</div>
                    <div><input type="radio" name="price" value="4"> Trên 3.000.000₫</div>
                </div>
            </div>

            <!-- === DANH MỤC === -->
            <div class="filter-group">
                <label class="filter-label" style="cursor: pointer;">
                    <span>Danh mục</span>
                    <span class="filter-icon"><i class="fa-solid fa-chevron-down"></i></span>
                </label>
                <div class="options" style="display: none;">
                    <div><input type="checkbox" name="category" value="cay"> Cây</div>
                    <div><input type="checkbox" name="category" value="hoa"> Hoa</div>
                    <div><input type="checkbox" name="category" value="den"> Đèn</div>
                    <div><input type="checkbox" name="category" value="phukien"> Tượng & Phụ kiện</div>
                    <div><input type="checkbox" name="category" value="dongho"> Đồng hồ</div>
                    <div><input type="checkbox" name="category" value="tranh"> Tranh</div>
                    <div><input type="checkbox" name="category" value="guong"> Gương</div>
                    <div><input type="checkbox" name="category" value="nen"> Nến & Tinh dầu</div>
                    <div><input type="checkbox" name="category" value="lo"> Bình & Lọ hoa</div>
                    <div><input type="checkbox" name="category" value="changoi"> Chăn & Gối</div>
                    <div><input type="checkbox" name="category" value="ke"> Kệ & Giá đỡ mini</div>
                    <div><input type="checkbox" name="category" value="ban"> Bàn decor</div>
                    <div><input type="checkbox" name="category" value="ghe"> Ghế decor</div>
                </div>
            </div>

            <!-- === PHÒNG === -->
            <div class="filter-group">
                <label class="filter-label" style="cursor: pointer;">
                    <span>Phòng</span>
                    <span class="filter-icon"><i class="fa-solid fa-chevron-down"></i></span>
                </label>
                <div class="options" style="display: none;">
                    <div><input type="checkbox" name="room" value="livingroom"> Phòng khách</div>
                    <div><input type="checkbox" name="room" value="bedroom"> Phòng ngủ</div>
                    <div><input type="checkbox" name="room" value="kitchen"> Phòng bếp</div>
                    <div><input type="checkbox" name="room" value="balcony"> Ban công</div>
                </div>
            </div>

            <!-- === MỨC SẮC === -->
            <div class="filter-group">
                <label class="filter-label" style="cursor: pointer;">
                    <span>Màu sắc</span>
                    <span class="filter-icon"><i class="fa-solid fa-chevron-down"></i></span>
                </label>
                <div class="options" style="display: none;">
                    <div><input type="checkbox" name="color" value="white"> Trắng</div>
                    <div><input type="checkbox" name="color" value="beige"> Be</div>
                    <div><input type="checkbox" name="color" value="black"> Đen</div>
                    <div><input type="checkbox" name="color" value="pink"> Hồng</div>
                    <div><input type="checkbox" name="color" value="brown"> Nâu</div>
                    <div><input type="checkbox" name="color" value="grey"> Xám</div>
                    <div><input type="checkbox" name="color" value="green"> Xanh lá</div>
                    <div><input type="checkbox" name="color" value="blue"> Xanh dương</div>
                    <div><input type="checkbox" name="color" value="yellow"> Vàng</div>
                    <div><input type="checkbox" name="color" value="red"> Đỏ</div>
                    <div><input type="checkbox" name="color" value="orange"> Cam</div>
                    <div><input type="checkbox" name="color" value="sliver"> Bạc</div>
                    <div><input type="checkbox" name="color" value="purple"> Tím</div>
                </div>
            </div>

            <button type="submit" class="filter-btn">Áp dụng</button>
        </aside>
    </form>


    <!-- === MAIN === -->
    <main>
        <div class="sort">
            <div class="category-header">
                <h2 id="categoryName">Danh mục: Tất cả sản phẩm</h2>
            </div>
            <div class="sortProducts">
                <label for="sortProducts">Sắp xếp: </label>
                <select id="sortProducts">
                    <option value="default">Mặc định</option>
                    <option value="price-asc">Giá tăng dần</option>
                    <option value="price-desc">Giá giảm dần</option>
                    <option value="stock-asc">Tồn kho ít → nhiều</option>
                    <option value="stock-desc">Tồn kho nhiều → ít</option>
                </select>
            </div>
        </div>

        <!-- === DANH SÁCH SẢN PHẨM === -->
        <div class="product-list" id="productList">
            <c:if test="${empty products}">
                <p>Không có sản phẩm</p>
            </c:if>

            <c:forEach var="p" items="${products}">
                <a href="${pageContext.request.contextPath}/frontend/products?id=${p.id}" class="product">
                    <div class="img"
                         style="background-image: url('${p.imageUrl}');">
                    </div>
                    <h4>${p.productName}</h4>
                    <!-- TAGS -->
                    <div class="tags">
                        <span class="tag">${p.categoryName}</span>
                        <span class="tag">${p.productTypeName}</span>
                    </div>

                    <div class="price-cart">
                        <div class="price-box">
                            <span class="price"><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>₫</span>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
        <!-- PHÂN TRANG -->
        <div id="pagination">
            <button class="page-btn active">1</button>
            <button class="page-btn">2</button>
            <button class="page-btn">3</button>
        </div>
    </main>
</div>

<!-- === FOOTER === -->
<footer class="footer">
    <div class="container">
        <div class="footer-columns">
            <!-- Cột 1: Giới thiệu -->
            <div class="footer-col">
                <h3>Giới thiệu</h3>
                <p>Chào mừng bạn đến với <strong>Noble Loft Theory</strong> — không gian dành cho những ai yêu thích
                    cái đẹp và nghệ thuật trang trí nội thất.</p>
                <p>Chúng tôi mang đến các sản phẩm decor trang trí nhà với phong cách hiện đại, tối giản nhưng vẫn
                    giữ được sự tinh tế trong từng chi tiết.</p>

            </div>

            <!-- Cột 2: Liên kết -->
            <div class="footer-col">
                <h3>Liên kết</h3>
                <ul>
                    <li><a>Chính sách đổi trả hoàn hàng</a></li>
                    <li><a>Chính sách bảo mật mật khẩu</a></li>
                    <li><a>Hướng dẫn mua hàng, sản phẩm</a></li>
                    <li><a>Chính sách kiểm hàng hóa vận chuyển</a></li>
                    <li><a>Chính sách giao hàng tận nơi</a></li>
                    <li><a>Hướng dẫn thanh toán đơn hàng</a></li>
                </ul>

            </div>

            <!-- Cột 3: Thông tin liên hệ -->
            <div class="footer-col">
                <h3>Thông tin liên hệ</h3>
                <p><i class="fa fa-map-marker"></i>Khu phố 33, P.Linh Xuân, TP.HCM</p>
                <p><i class="fa fa-map-marker"></i> Đại học Nông Lâm TP.Hồ Chí Minh</p>
                <p><i class="fa fa-phone"></i> Liên hệ: 03751841444 - 03381776315 </p>

                <p><i class="fa fa-envelope"></i> <a
                        href="mailto:NLT@noblelofttheory.com">NLT@noblelofttheory.com</a></p>
            </div>


            <!-- Cột 4: Fanpage -->
            <div class="footer-col">
                <h3>Fanpage</h3>
                <div class="fanpage-box">
                    <p>Liên hệ ngay trang chủ của shop Noble Loft Theory.</p>
                    <p>Nếu bạn đang có thắc mắc gì ở sản phẩm.</p>
                    <p>Fanpage, Youtube và Instagram.</p>


                    <div class="social-box">
                        <div class="social-icons">
                            <!-- mấy cái # này là chưa có link liên kết nào có gắn v -->
                            <a href="https://www.facebook.com/share/1HP5fZGNqb/?mibextid=wwXIfr">
                                <i class="fa-brands fa-facebook"></i></a>
                            <a href="https://www.instagram.com/nltnoblelofttheory/">
                                <i class="fa-brands fa-instagram"></i></a>
                            <a href="https://www.youtube.com/channel/UC931-4vCWPGos5fSNQ8Rh-g">
                                <i class="fa-brands fa-youtube"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        <p>Copyright © 2025 NLT Noble Loft Theory. Powered by NLT </p>
    </div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/frontend/js/living.js"></script>
</body>
</html>
