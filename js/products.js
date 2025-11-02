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

  const productList = document.getElementById("productList");
  const products = Array.from(productList.children); // tất cả sản phẩm
  const productsPerPage = 16;
  let currentPage = 1;

  // Hàm hiển thị trang
  function showPage(page) {
    const start = (page - 1) * productsPerPage;
    const end = start + productsPerPage;

    products.forEach((product, index) => {
      product.style.display = index >= start && index < end ? "block" : "none";
    });
  }

  // Tạo nút phân trang
  function createPagination() {
    const totalPages = Math.ceil(products.length / productsPerPage);
    const pagination = document.getElementById("pagination");
    pagination.innerHTML = "";

    for (let i = 1; i <= totalPages; i++) {
      const btn = document.createElement("button");
      btn.textContent = i;
      btn.classList.add("page-btn");
      if (i === currentPage) btn.classList.add("active");

      btn.addEventListener("click", () => {
        currentPage = i;
        showPage(currentPage);

        // Cập nhật style active
        document
          .querySelectorAll(".page-btn")
          .forEach((b) => b.classList.remove("active"));
        btn.classList.add("active");
      });

      pagination.appendChild(btn);
    }
  }

  products.forEach((product) => {
    const cartBtn = product.querySelector(".add-cart");
    if (cartBtn) {
      cartBtn.addEventListener("click", () => {
        window.location.href = "cart.html";
      });
    }
  });

  // Sau khi định nghĩa xong các hàm
  showPage(currentPage); // Hiển thị trang đầu tiên
  createPagination(); // Tạo nút phân trang
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
