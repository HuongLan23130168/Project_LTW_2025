// sidebar menu-account
document.querySelectorAll(".menu-account li").forEach(item => {
    item.addEventListener("click", () => {

        document.querySelectorAll(".menu-account li").forEach(i => i.classList.remove("active"));
        item.classList.add("active");

        const target = item.getAttribute("data-target");
        document.querySelectorAll(".page").forEach(page => page.classList.remove("active"));
        document.querySelector(target).classList.add("active");
    });
});


//order tabs
document.querySelectorAll(".order-tab").forEach(tab => {
    tab.addEventListener("click", () => {
        document.querySelectorAll(".order-tab").forEach(t => t.classList.remove("active"));
        tab.classList.add("active");

        const status = tab.getAttribute("data-tab");

        document.querySelectorAll(".order-card").forEach(order => {
            if (status === "all" || order.dataset.status === status) {
                order.style.display = "block";
            } else {
                order.style.display = "none";
            }
        });
    });
});



