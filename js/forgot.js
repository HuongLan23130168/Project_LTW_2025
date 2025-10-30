document.addEventListener("DOMContentLoaded", () => {
  const btnForgot = document.getElementById("btnForgot");
  const msg = document.getElementById("forgotMsg");

  btnForgot.addEventListener("click", () => {
    const email = document.getElementById("emailForgot").value.trim();
    const user = JSON.parse(localStorage.getItem("user") || "null");

    if (!email) {
      msg.textContent = "⚠️ Vui lòng nhập email!";
      msg.style.color = "orange";
      return;
    }

    if (!user || user.email !== email) {
      msg.textContent = "❌ Không tìm thấy tài khoản!";
      msg.style.color = "red";
      return;
    }

    // ✅ Giả lập gửi email khôi phục
    msg.textContent = "📩 Liên kết khôi phục mật khẩu đã được gửi tới email!";
    msg.style.color = "green";

    // ⏳ Chuyển sang trang đặt lại mật khẩu
    setTimeout(() => {
      window.location.href = "newPass.html";
    }, 1500);
  });
});
