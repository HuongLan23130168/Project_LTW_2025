document.addEventListener("click", function (e) {
  const toggle = e.target.closest(".action-toggle");
  const allMenus = document.querySelectorAll(".action-menu");

  // Ẩn tất cả menu trước
  allMenus.forEach((m) => (m.style.display = "none"));

  // Nếu bấm vào nút ...
  if (toggle) {
    e.preventDefault();
    const menu = toggle.nextElementSibling;
    menu.style.display = "flex";
  }
});
