console.clear();

document.addEventListener("DOMContentLoaded", () => {
  const btnAgree = document.getElementById("btnAgree");

  btnAgree.addEventListener("click", () => {
    const newPass = document.getElementById("newPassword").value.trim();
    const confirmPass = document.getElementById("confirmPassword").value.trim();

    if (!newPass || !confirmPass) {
      showToast("⚠️ Vui lòng nhập đầy đủ mật khẩu!", "error");
      return;
    }

    if (newPass !== confirmPass) {
      showToast("❌ Mật khẩu nhập lại không trùng khớp!", "error");
      return;
    }

    // Giả lập cập nhật mật khẩu thành công
    showToast("✅ Mật khẩu đã được thay đổi thành công!", "success");

    setTimeout(() => {
      window.location.href = "../login.html";
    }, 1500);
  });
});

function showToast(message, type = "success") {
  const toast = document.getElementById("toast");
  toast.textContent = message;
  toast.className = `toast show ${type}`;
  setTimeout(() => (toast.className = "toast"), 3000);
}
