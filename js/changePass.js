console.clear();

document.addEventListener("DOMContentLoaded", () => {
    const btnChange = document.getElementById("btnChange");

    btnChange.addEventListener("click", () => {
        // Lấy mật khẩu mới người dùng nhập (chỉ để hiển thị hoặc test)
        const newPass = document.getElementById("newPassword").value.trim();

        // Sau 1 giây quay về trang đăng nhập
        setTimeout(() => {
            window.location.href = "index.html";
        }, 1000);
    });
});
