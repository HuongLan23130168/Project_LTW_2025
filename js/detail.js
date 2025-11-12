// Thay đổi ảnh chính khi click thumbnail
function changeImage(element) {
  const mainImage = document.getElementById("mainImage");
  const thumbs = document.querySelectorAll(".thumbs img");

  mainImage.src = element.src;

  thumbs.forEach((img) => img.classList.remove("active"));
  element.classList.add("active");
}

// Trượt slider sản phẩm tương tự
function scrollSlider(direction) {
  const slider = document.getElementById("productSlider");
  const scrollAmount = 260; // px
  slider.scrollBy({
    left: direction * scrollAmount,
    behavior: "smooth",
  });
}
// chọn màu & kích thước
document.querySelectorAll(".option-list .option").forEach((opt) => {
  opt.addEventListener("click", function () {
    this.parentNode
      .querySelectorAll(".option")
      .forEach((o) => o.classList.remove("active"));
    this.classList.add("active");
  });
});
// Nút quay lại đầu trang
const backToTopBtn = document.getElementById("backToTop");

window.addEventListener("scroll", () => {
  if (window.scrollY > 300) {
    backToTopBtn.classList.add("show");
  } else {
    backToTopBtn.classList.remove("show");
  }
});

backToTopBtn.addEventListener("click", () => {
  window.scrollTo({
    top: 0,
    behavior: "smooth",
  });
});
