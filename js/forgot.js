// Xóa log trong console mỗi khi tải lại page
console.clear();

// Chờ nội dung HTML tải xong -> chạy script
document.addEventListener("DOMContentLoaded", () => {
  const btnForgot = document.getElementById("btnForgot");

  btnForgot.addEventListener("click", () => {
    // Lấy giá trị email nhập (loại bỏ khoảng trắng đầu & cuối)
    const email = document.getElementById("emailForgot").value.trim();

    // Giả lập gửi mail → chuyển sang page đặt mật khẩu mới
    setTimeout(() => {
      window.location.href = "newPass.html";
    }, 1000);
  });
});
