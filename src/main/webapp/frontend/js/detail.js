document.querySelectorAll(".select-group .option").forEach((opt) => {
  opt.onclick = () => {
    // active
    opt.parentNode
      .querySelectorAll(".option")
      .forEach((o) => o.classList.remove("active"));
    opt.classList.add("active");

    // kích thước được chọn
    let size = opt.textContent.trim();

    // ẩn tất cả giá
    document
      .querySelectorAll(".price-wrapper")
      .forEach((p) => p.classList.add("hidden"));

    // hiện giá đúng kích thước
    let show = document.querySelector(`.price-wrapper[data-size="${size}"]`);
    if (show) show.classList.remove("hidden");
  };
});
