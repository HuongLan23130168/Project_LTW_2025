console.clear();

document.addEventListener("DOMContentLoaded", () => {
  const signup = document.querySelector(".signup");
  const login = document.querySelector(".login");

  // Lấy trạng thái hiển thị form từ localStorage
  const showForm = localStorage.getItem("showForm");

  if (showForm === "signup") {
    signup.classList.remove("slide-up");
    login.classList.add("slide-up");
  } else {
    signup.classList.add("slide-up");
    login.classList.remove("slide-up");
  }

  // Nút chuyển form
  const loginBtn = document.getElementById("login");
  const signupBtn = document.getElementById("signup");

  loginBtn.addEventListener("click", () => {
    signup.classList.add("slide-up");
    login.classList.remove("slide-up");
    localStorage.setItem("showForm", "login");
  });

  signupBtn.addEventListener("click", () => {
    login.classList.add("slide-up");
    signup.classList.remove("slide-up");
    localStorage.setItem("showForm", "signup");
  });
});

// ====== Thông báo ======
function showToast(message, type = "success") {
  const toast = document.getElementById("toast");
  toast.textContent = message;
  toast.className = `toast show ${type}`;
  setTimeout(() => {
    toast.className = "toast";
  }, 3000);
}

// ====== Xử lý Đăng nhập ======
document.querySelector(".login .submit-btn").addEventListener("click", (e) => {
  e.preventDefault();
  const email = document.querySelector(".login input[type='email']").value;
  const password = document.getElementById("loginPassword").value;

  if (!email || !password) {
    showToast("⚠️ Vui lòng nhập đầy đủ thông tin!", "error");
    return;
  }

  const storedUser = JSON.parse(localStorage.getItem("user"));
  if (!storedUser) {
    showToast("❌ Chưa có tài khoản nào được đăng ký!", "error");
  } else if (storedUser.email === email && storedUser.password === password) {
    showToast(`✅ Chào mừng ${storedUser.name}!`, "success");
  } else {
    showToast("❌ Email hoặc mật khẩu không đúng!", "error");
  }
});

// ====== Xử lý Đăng ký ======
document.querySelector(".signup .submit-btn").addEventListener("click", (e) => {
  e.preventDefault();
  const name = document.querySelector(
    '.signup input[placeholder="Họ và tên"]'
  ).value;
  const email = document.querySelector(
    '.signup input[placeholder="Email"]'
  ).value;
  const pass = document.getElementById("signupPassword").value;
  const confirm = document.getElementById("confirmPassword").value;

  if (!name || !email || !pass || !confirm) {
    showToast("⚠️ Vui lòng nhập đầy đủ thông tin!", "error");
  } else if (pass !== confirm) {
    showToast("❌ Mật khẩu không khớp!", "error");
  } else {
    // ✅ Lưu thông tin đăng ký vào localStorage
    const user = { name, email, password: pass };
    localStorage.setItem("user", JSON.stringify(user));

    showToast("🎉 Đăng ký thành công!", "success");

    // Tự chuyển sang form đăng nhập
    localStorage.setItem("showForm", "login");
    setTimeout(() => location.reload(), 1000);
  }
});
