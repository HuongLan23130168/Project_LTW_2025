// =======================
// MULTI SELECT DANH MỤC
// =======================
const btn = document.getElementById("msBtn");
const dropdown = document.getElementById("msDropdown");
const text = document.getElementById("msText");
const checkboxes = dropdown.querySelectorAll("input[type='checkbox']");

btn.addEventListener("click", () => {
    btn.classList.toggle("active");
    dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
});

checkboxes.forEach(cb => cb.addEventListener("change", updateText));

function updateText() {
    const selected = [...checkboxes]
        .filter(cb => cb.checked)
        .map(cb => cb.value);

    text.textContent = selected.length ? selected.join(", ") : "Chọn danh mục";
}

document.addEventListener("click", e => {
    if (!btn.contains(e.target) && !dropdown.contains(e.target)) {
        dropdown.style.display = "none";
        btn.classList.remove("active");
    }
});


// =======================
// GROUP ĐỘNG (MÀU / SIZE / GIÁ)
// =======================
function dynamicGroup(wrapperId, addClass, removeClass) {
    const wrapper = document.getElementById(wrapperId);

    wrapper.addEventListener("click", e => {
        if (e.target.classList.contains(addClass)) {
            const clone = e.target.parentElement.cloneNode(true);
            clone.querySelector("input").value = "";
            wrapper.appendChild(clone);
        }

        if (e.target.classList.contains(removeClass)) {
            if (wrapper.children.length > 1) {
                e.target.parentElement.remove();
            }
        }
    });
}

dynamicGroup("color-wrapper", "add-btn", "remove-btn");
dynamicGroup("size-wrapper", "add-size", "remove-size");
dynamicGroup("price-wrapper", "add-price", "remove-price");


// =======================
// IMAGE UPLOAD + URL
// =======================
const previewBox = document.getElementById("preview-box");
const fileInput = document.getElementById("image-input");
const urlInput = document.getElementById("image-url");
const addUrlBtn = document.getElementById("add-url-btn");

let images = [];

fileInput.addEventListener("change", () => {
    [...fileInput.files].forEach(file => {
        const reader = new FileReader();
        reader.onload = e => {
            images.push(e.target.result);
            renderImages();
        };
        reader.readAsDataURL(file);
    });
});

addUrlBtn.addEventListener("click", () => {
    if (!urlInput.value.trim()) return;
    images.push(urlInput.value.trim());
    urlInput.value = "";
    renderImages();
});

function renderImages() {
    previewBox.innerHTML = "";
    images.forEach((src, index) => {
        previewBox.innerHTML += `
            <div class="preview-item">
                <img src="${src}">
                <button class="remove-img-btn" onclick="removeImg(${index})">×</button>
            </div>
        `;
    });
}

function removeImg(index) {
    images.splice(index, 1);
    renderImages();
}


// =======================
// SAVE / EDIT PRODUCT
// =======================
const form = document.getElementById("productForm");
let products = JSON.parse(localStorage.getItem("products")) || [];
const editIndex = localStorage.getItem("editIndex");

// LOAD DATA KHI EDIT
if (editIndex !== null && products[editIndex]) {
    const p = products[editIndex];

    productId.value = p.id;
    productName.value = p.name;
    quantity.value = p.stock;
    salePercent.value = p.sale || 0;

    images = p.images || [];
    renderImages();

    checkboxes.forEach(cb => {
        cb.checked = p.category.includes(cb.value);
    });
    updateText();

    document.getElementById("pageTitle").innerText = "Chỉnh sửa sản phẩm";
    document.getElementById("breadcrumbTitle").innerText = "Chỉnh sửa sản phẩm";
}


// =======================
// SUBMIT FORM
// =======================
form.addEventListener("submit", e => {
    e.preventDefault();

    if (!productId.value || !productName.value) {
        alert("Vui lòng nhập mã và tên sản phẩm");
        return;
    }

    const priceValue = document.querySelector(".price-input").value;

    const newProduct = {
        id: productId.value.trim(),
        name: productName.value.trim(),
        category: [...checkboxes]
            .filter(cb => cb.checked)
            .map(cb => cb.value),
        price: Number(priceValue),      // QUAN TRỌNG
        stock: Number(quantity.value),
        sale: Number(salePercent.value) || 0,
        image: images[0] || "",
        images: images
    };

    if (editIndex !== null) {
        products[editIndex] = newProduct;
        localStorage.removeItem("editIndex");
    } else {
        products.push(newProduct);
    }

    localStorage.setItem("products", JSON.stringify(products));
    window.location.href = "products.html";
});
