// =======================
// DỮ LIỆU MẪU (nếu chưa có)
// =======================
const defaultProducts = [
    {
        id: "SP001",
        name: "Bình hoa gốm vintage cao cấp sang trọng",
        category: ["Phòng khách"],
        price: 350000,
        stock: 12,
        sale: 10,
        image: "https://via.placeholder.com/100"
    }
];

// Lấy dữ liệu từ localStorage
let products = JSON.parse(localStorage.getItem("products")) || defaultProducts;

// =======================
// RENDER TABLE
// =======================
const tbody = document.getElementById("tbody");

function renderProducts(list) {
    tbody.innerHTML = "";

    if (list.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="7">Không có sản phẩm</td>
            </tr>
        `;
        return;
    }

    list.forEach((p, index) => {
        const tr = document.createElement("tr");

        tr.innerHTML = `
            <td>${p.id}</td>

            <td>
                <div class="product-info">
                    <img src="${p.image}" alt="">
                    <span class="product-name" title="${p.name}">
                        ${p.name}
                    </span>
                </div>
            </td>

            <td style="text-align: left;">
                ${p.category.map(c => `<span class="pill">${c}</span>`).join(" ")}
            </td>

            <td>${p.price.toLocaleString()}.000</td>
            <td>${p.stock}</td>
            <td>
                ${p.sale > 0 ? `<span class="tag">${p.sale}%</span>` : "-"}
            </td>

            <td>
                <button class="btn secondary" onclick="editProduct(${index})">
                    Sửa
                </button>
                <button class="btn delete" onclick="deleteProduct(${index})">
                    Xóa
                </button>
            </td>
        `;

        tbody.appendChild(tr);
    });
}

// =======================
// SEARCH
// =======================
const searchInput = document.getElementById("searchProduct");

searchInput.addEventListener("input", () => {
    const keyword = searchInput.value.toLowerCase();

    const filtered = products.filter(p =>
        p.name.toLowerCase().includes(keyword) ||
        p.id.toLowerCase().includes(keyword)
    );

    renderProducts(filtered);
});

// =======================
// FILTER CATEGORY
// =======================
const filterType = document.getElementById("filterType");

filterType.addEventListener("change", () => {
    const value = filterType.value;

    if (!value) {
        renderProducts(products);
        return;
    }

    const filtered = products.filter(p =>
        p.category.includes(value)
    );

    renderProducts(filtered);
});

// =======================
// DELETE
// =======================
function deleteProduct(index) {
    if (!confirm("Bạn có chắc muốn xóa sản phẩm này?")) return;

    products.splice(index, 1);
    localStorage.setItem("products", JSON.stringify(products));
    renderProducts(products);
}

// =======================
// EDIT (chuyển sang trang add)
// =======================
function editProduct(index) {
    localStorage.setItem("editIndex", index);
    window.location.href = "addProducts.html";
}

// =======================
renderProducts(products);
