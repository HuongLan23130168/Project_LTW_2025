// Xóa log trong console mỗi khi tải lại page
console.clear();

// Chờ nội dung HTML tải xong -> chạy script
document.addEventListener("DOMContentLoaded", () => {
  // Lấy 2 form: signup và signin
  const signup = document.querySelector(".signup");
  const signin = document.querySelector(".signin");

  const signinBtn = document.getElementById("signin");
  const signupBtn = document.getElementById("signup");

  // === CHUYỂN GIỮA 2 FORM ===
  // Khi nhấn "Đăng nhập" → ẩn signup, hiện signin
  signinBtn.addEventListener("click", (e) => {
    e.preventDefault();
    signup.classList.add("slide-up");
    signin.classList.remove("slide-up");
  });

  // Khi nhấn "Đăng ký" → ẩn signin, hiện signup
  signupBtn.addEventListener("click", (e) => {
    e.preventDefault();
    signin.classList.add("slide-up");
    signup.classList.remove("slide-up");
  });

  // === NÚT ĐĂNG KÝ ===
  document
    .querySelector(".signup .submit-btn")
    .addEventListener("click", (e) => {
      e.preventDefault();
      signup.classList.add("slide-up");
      signin.classList.remove("slide-up");
    });

  // === NÚT ĐĂNG NHẬP ===
  document
    .querySelector(".signin .submit-btn")
    .addEventListener("click", (e) => {
      e.preventDefault();
      window.location.href = "index.html";
    });
});
