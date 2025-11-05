console.clear();

document.addEventListener("DOMContentLoaded", () => {
  const filterGroups = document.querySelectorAll(".filter-group");

  filterGroups.forEach((group) => {
    const label = group.querySelector(".filter-label");
    const optionsDiv = group.querySelector(".options");
    const icon = group.querySelector(".filter-icon");

    if (label && optionsDiv && icon) {
      icon.style.transform = "rotate(0deg)";
      icon.style.transition = "transform 0.2s";

      label.addEventListener("click", () => {
        const isHidden = optionsDiv.style.display === "none";

        // Toggle display
        optionsDiv.style.display = isHidden ? "block" : "none";

        // Toggle rotation: 180 độ khi mở (isHidden = true), 0 độ khi đóng
        icon.style.transform = isHidden ? "rotate(180deg)" : "rotate(0deg)";
      });
    }
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
