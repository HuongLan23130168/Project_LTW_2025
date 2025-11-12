document.addEventListener("DOMContentLoaded", () => {
    const allMenuItems = document.querySelectorAll(".menu-account > li, .menu-account .submenu li");
    const pages = document.querySelectorAll(".page");
    const submenuParents = document.querySelectorAll(".menu-account .has-submenu");

    function clearAllActive() {
        allMenuItems.forEach(i => i.classList.remove("active"));
        submenuParents.forEach(p => p.classList.remove("open", "active"));
    }

    function showPage(selector) {
        pages.forEach(p => p.classList.remove("active"));
        const page = document.querySelector(selector);
        if (page) page.classList.add("active");
    }

    // Click menu
    allMenuItems.forEach(item => {
        item.addEventListener("click", e => {
            e.stopPropagation();
            clearAllActive();

            if (item.classList.contains("has-submenu")) {
                item.classList.add("open", "active");
                return;
            }

            item.classList.add("active");
            const parent = item.closest(".has-submenu");
            if (parent) parent.classList.add("open", "active");

            const target = item.getAttribute("data-target");
            if (target) showPage(target);
        });
    });

    // Toggle submenu khi click menu-title
    document.querySelectorAll(".has-submenu .menu-title").forEach(toggle => {
        toggle.addEventListener("click", e => {
            e.stopPropagation();
            const parent = toggle.parentElement;
            const wasOpen = parent.classList.contains("open");
            submenuParents.forEach(p => p.classList.remove("open"));
            if (!wasOpen) parent.classList.add("open");
        });
    });

    // Click ngoài sidebar đóng submenu
    document.addEventListener("click", () => {
        submenuParents.forEach(p => p.classList.remove("open"));
    });

    // Order-tab
    document.querySelectorAll(".order-tab").forEach(tab => {
        tab.addEventListener("click", () => {
            document.querySelectorAll(".order-tab").forEach(t => t.classList.remove("active"));
            tab.classList.add("active");
            const status = tab.getAttribute("data-tab");
            document.querySelectorAll(".order-card").forEach(order => {
                order.style.display = (status === "all" || order.dataset.status === status) ? "block" : "none";
            });
        });
    });
});
