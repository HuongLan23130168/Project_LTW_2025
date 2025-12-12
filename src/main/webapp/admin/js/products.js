const addBtn = document.getElementById("addProductBtn");
const modalBackdrop = document.getElementById("modalBackdrop");
const form = document.getElementById("productForm");
const cancelBtn = document.getElementById("cancelBtn");
const preview = document.getElementById("preview");
const tbody = document.getElementById("tbody");

let editRow = null;

// === Mở modal ===
addBtn.onclick = () => openModal("add");

// function openModal(mode, el) {
//   modalBackdrop.classList.add("show");
//   document.getElementById("modalTitle").textContent =
//     mode === "edit" ? "Sửa sản phẩm" : "Thêm sản phẩm";

//   if (mode === "edit") {
//     editRow = el.closest("tr");
//     const tds = editRow.querySelectorAll("td");
//     form.name.value = tds[1].querySelector("div div").textContent.trim();
//     form.size.value = tds[2].innerText.trim(); // cột 3: kích thước
//     form.category.value = tds[3].innerText.trim(); // cột 4: danh mục
//     form.price.value = tds[4].innerText.replace(/[^\d]/g, "");
//     form.discount.value = tds[5].innerText.replace(/[^\d]/g, "");
//     form.stock.value = tds[6].innerText.trim();
//     form.tag.value = tds[7].innerText.trim();
//   } else {
//     form.reset();
//     preview.style.display = "none";
//     editRow = null;
//   }
// }

// // === Đóng modal ===
// cancelBtn.onclick = () => modalBackdrop.classList.remove("show");

// // === Xem trước ảnh ===
// form.image.onchange = (e) => {
//   const file = e.target.files[0];
//   if (file) {
//     preview.src = URL.createObjectURL(file);
//     preview.style.display = "block";
//   }
// };

// // === Xóa sản phẩm ===
// function deleteRow(btn) {
//   btn.closest("tr").remove();
// }

// // === Lưu sản phẩm ===
// form.onsubmit = (e) => {
//   e.preventDefault();

//   const name = form.name.value.trim();
//   const category = form.category.value.trim();
//   const size = form.size.value.trim();
//   const price = form.price.value;
//   const discount = form.discount.value || 0;
//   const stock = form.stock.value;
//   const tag = form.tag.value;
//   const description = form.description.value.trim();
//   const imgSrc = preview.src || "img/no-image.png";

//   const tagHTML = tag
//     ? `<span class="tag ${tag.toLowerCase()}">${tag}</span>`
//     : "";

//   const rowHTML = `
//         <td>${
//           editRow ? editRow.children[0].innerText : tbody.children.length + 1
//         }</td>
//         <td>
//             <div style="display:flex;gap:12px;align-items:center">
//                 <img class="img" src="${imgSrc}" alt="${name}" />
//                 <div>
//                     <div style="font-weight:600">${name}</div>
//                 </div>
//             </div>
//         </td>
//         <td><div class="size">${size}</div></td>
//         <td><div class="pill">${category}</div></td>
//         <td><b>${Number(price).toLocaleString()} ₫</b></td>
//         <td>${discount ? Number(discount).toLocaleString() + "₫" : "-"}</td>
//         <td>${stock}</td>
//         <td>${tagHTML}</td>
//         <td>
//             <div class="actions">
//                 <button class="btn secondary" onclick="openModal('edit', this)">Sửa</button>
//                 <button class="btn deleteRow" onclick="deleteRow(this)">Xóa</button>
//             </div>
//         </td>`;

//   if (editRow) {
//     editRow.innerHTML = rowHTML;
//   } else {
//     const tr = document.createElement("tr");
//     tr.innerHTML = rowHTML;
//     tbody.appendChild(tr);
//   }

//   modalBackdrop.classList.remove("show");
// };
