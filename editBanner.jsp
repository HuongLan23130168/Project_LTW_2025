<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Chỉnh Sửa Banner Hệ Thống</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/banners.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />

</head>
<body>
<jsp:include page="/admin/header.jsp"/>
<jsp:include page="/admin/sidebar.jsp"/>

<main class="main-content">

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/admin/banners">Quản lý Banner</a> /
        <span class="current">Chỉnh sửa Banner #${banner.id}</span>
    </div>

    <div class="banner-header">
        <h1>Quản lý Banner & Khuyến Mãi</h1>
    </div>

    <div class="form-card">
        <h2>Chỉnh Sửa Banner #${banner.id}</h2>

        <form action="${pageContext.request.contextPath}/admin/banners" method="post" class="add-banner-form">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="${banner.id}">

            <div class="form-grid">
                <div class="form-section-title"><h3><i class="fas fa-image"></i> Banner Chính</h3></div>

                <div class="form-group">
                    <label for="title">Tiêu đề chính</label>
                    <input type="text" id="title" name="title" value="${banner.title}" placeholder="VD: BST Nội thất mùa Thu" required>
                </div>

                <div class="form-group">
                    <label for="image_url">Đường dẫn ảnh Banner chính (URL) <span style="color:red">*</span></label>
                    <div style="position: relative;">
                        <i class="fas fa-link" style="position: absolute; left: 12px; top: 12px; color: #888;"></i>
                        <input type="url" id="image_url" name="image_url" value="${banner.image_url}" placeholder="https://example.com/banner-main.jpg" required style="padding-left: 35px;">
                    </div>
                    <div id="main-preview-container" style="margin-top: 10px; min-height: 25px;">
                        <c:if test="${not empty banner.image_url}">
                            <p style="font-size: 13px; color: #3d8b58; margin-bottom: 5px;"><i class="fas fa-check-circle"></i> Ảnh hiện tại:</p>
                            <img src="${banner.image_url}" class="banner-thumbnail" style="max-height: 150px; width: auto; object-fit: contain; border-radius: 6px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border: 1px solid #ddd;">
                        </c:if>
                    </div>
                </div>

                <div class="form-group">
                    <label for="link">Đường dẫn chuyển hướng (Link Click)</label>
                    <div style="position: relative;">
                        <i class="fas fa-external-link-alt" style="position: absolute; left: 12px; top: 12px; color: #888;"></i>
                        <input type="text" id="link" name="link" value="${banner.link}" placeholder="/products hoặc link website" style="padding-left: 35px;">
                    </div>
                </div>

                <div class="form-group form-group-full">
                    <label for="description">Mô tả chính</label>
                    <textarea id="description" name="description" rows="2">${banner.description}</textarea>
                </div>

                <div class="form-section-title"><h3><i class="fas fa-ad"></i> Banner Phụ (Promo Side)</h3></div>

                <div class="form-group">
                    <label for="sub_title">Tiêu đề phụ</label>
                    <input type="text" id="sub_title" name="sub_title" value="${banner.sub_title}" placeholder="VD: Sale 50%">
                </div>

                <div class="form-group">
                    <label for="sub_image_url">Đường dẫn ảnh Banner phụ (URL)</label>
                    <div style="position: relative;">
                        <i class="fas fa-link" style="position: absolute; left: 12px; top: 12px; color: #888;"></i>
                        <input type="url" id="sub_image_url" name="sub_image_url" value="${banner.sub_image_url}" placeholder="https://example.com/banner-sub.jpg" style="padding-left: 35px;">
                    </div>
                    <div id="sub-preview-container" style="margin-top: 10px; min-height: 25px;">
                        <c:if test="${not empty banner.sub_image_url}">
                            <p style="font-size: 13px; color: #3d8b58; margin-bottom: 5px;"><i class="fas fa-check-circle"></i> Ảnh hiện tại:</p>
                            <img src="${banner.sub_image_url}" class="banner-thumbnail" style="max-height: 150px; width: auto; object-fit: contain; border-radius: 6px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border: 1px solid #ddd;">
                        </c:if>
                    </div>
                </div>

                <div class="form-group">
                    <label for="sub_description">Mô tả phụ</label>
                    <input type="text" id="sub_description" name="sub_description" value="${banner.sub_description}" placeholder="VD: Dành cho khách hàng mới">
                </div>

                <div class="form-section-title"><h3><i class="fas fa-cog"></i> Thông số cấu hình</h3></div>

                <div class="form-group">
                    <label for="display_order">Thứ tự hiển thị</label>
                    <input type="number" id="display_order" name="display_order" value="${banner.display_order}" required>
                </div>

                <div class="form-group">
                    <label for="is_active">Trạng thái hiển thị</label>
                    <select id="is_active" name="is_active" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px;">
                        <option value="true" ${banner.is_active ? 'selected' : ''}>Hiển thị (Công khai)</option>
                        <option value="false" ${not banner.is_active ? 'selected' : ''}>Tạm ẩn</option>
                    </select>
                </div>
            </div>

            <div class="form-actions" style="margin-top: 25px;">
                <a href="${pageContext.request.contextPath}/admin/banners" class="btn" style="background-color: #e9ecef; color: #495057;">
                    <i class="fas fa-times"></i> Hủy & Quay lại
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Cập nhật Banner
                </button>
            </div>
        </form>
    </div>
</main>

<script>

    function previewImageFromUrl(inputId, previewId) {
        const input = document.getElementById(inputId);
        const preview = document.getElementById(previewId);
        let typingTimer;
        const doneTypingInterval = 500;

        if(!input || !preview) return;

        input.addEventListener('input', function() {
            clearTimeout(typingTimer);
            const url = this.value.trim();

            if (!url) {
                preview.innerHTML = '';
                return;
            }

            preview.innerHTML = '<p style="font-size: 13px; color: #888;"><i class="fas fa-spinner fa-spin"></i> Đang tải ảnh...</p>';

            typingTimer = setTimeout(() => {
                const img = new Image();

                img.onload = function() {
                    preview.innerHTML = '<p style="font-size: 13px; color: #3d8b58; margin-bottom: 5px;"><i class="fas fa-check-circle"></i> Xem trước ảnh mới:</p>';
                    img.className = 'banner-thumbnail';
                    img.style.maxHeight = '150px';
                    img.style.width = 'auto';
                    img.style.objectFit = 'contain';
                    img.style.borderRadius = '6px';
                    img.style.boxShadow = '0 2px 8px rgba(0,0,0,0.1)';
                    img.style.border = '1px solid #ddd';
                    preview.appendChild(img);
                };

                img.onerror = function() {
                    preview.innerHTML = '<p style="color: #dc3545; font-size: 13px;"><i class="fas fa-exclamation-triangle"></i> Link ảnh không hợp lệ hoặc không thể tải được.</p>';
                };

                img.src = url;
            }, doneTypingInterval);
        });
    }

    document.addEventListener("DOMContentLoaded", function() {
        previewImageFromUrl('image_url', 'main-preview-container');
        previewImageFromUrl('sub_image_url', 'sub-preview-container');
    });
</script>
</body>
</html>