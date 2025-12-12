document.addEventListener("DOMContentLoaded", () => {
  const pages = document.querySelectorAll(".page");
  const menuItems = document.querySelectorAll(".menu-account li[data-target]");

  function showPage(selector) {
    pages.forEach((p) => p.classList.remove("active"));
    const page = document.querySelector(selector);
    if (page) page.classList.add("active");
  }

  // Di chuột vào submenu cha -> mở submenu
  document.querySelectorAll(".menu-account .has-submenu").forEach((parent) => {
    parent.addEventListener("mouseenter", () => {
      parent.classList.add("open");
    });
    parent.addEventListener("mouseleave", () => {
      parent.classList.remove("open");
    });
  });

  // Hover vào item -> active + show page
  menuItems.forEach((item) => {
    item.addEventListener("mouseenter", () => {
      menuItems.forEach((i) => i.classList.remove("active"));
      item.classList.add("active");

      const target = item.getAttribute("data-target");
      if (target) showPage(target);
    });
  });

  // Order-tab giữ click
  document.querySelectorAll(".order-tab").forEach((tab) => {
    tab.addEventListener("click", () => {
      document
        .querySelectorAll(".order-tab")
        .forEach((t) => t.classList.remove("active"));
      tab.classList.add("active");
      const status = tab.getAttribute("data-tab");
      document.querySelectorAll(".order-card").forEach((order) => {
        order.style.display =
          status === "all" || order.dataset.status === status
            ? "block"
            : "none";
      });
    });
  });
});
