console.clear();

document.addEventListener("DOMContentLoaded", () => {
  const btnAgree = document.getElementById("btnAgree");

  btnAgree.addEventListener("click", () => {
    // Lấy dữ liệu người dùng nhập (mật khẩu mới + xác nhận)
    const newPass = document.getElementById("newPassword").value.trim();
    const confirmPass = document.getElementById("confirmPassword").value.trim();

    // Sau 1 giây, chuyển về trang đăng nhập
    setTimeout(() => {
      window.location.href = "login.html";
    }, 1000);
  });
});
