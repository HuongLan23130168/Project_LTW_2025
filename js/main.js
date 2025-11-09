document.addEventListener("DOMContentLoaded", () => {
  const track = document.getElementById("galleryTrack");
  const slides = Array.from(document.querySelectorAll(".gallery-set"));
  let currentIndex = 0;
  let isAnimating = false;

  // Clone đầu & cuối để tạo vòng tròn mượt
  const firstClone = slides[0].cloneNode(true);
  const lastClone = slides[slides.length - 1].cloneNode(true);
  track.appendChild(firstClone);
  track.insertBefore(lastClone, slides[0]);

  const allSlides = document.querySelectorAll(".gallery-set");
  const total = allSlides.length;

  // Đặt vị trí ban đầu ở slide 1 thật (bỏ clone đầu)
  track.style.transform = `translateX(-100%)`;

  function goToSlide(index, direction) {
    if (isAnimating) return;
    isAnimating = true;
    track.style.transition = "transform 0.6s ease-in-out";
    track.style.transform = `translateX(-${(index + 1) * 100}%)`;

    track.addEventListener(
      "transitionend",
      () => {
        if (index < 0) {
          // Nếu lùi trước clone đầu -> nhảy về cuối thật
          track.style.transition = "none";
          index = slides.length - 1;
          track.style.transform = `translateX(-${(index + 1) * 100}%)`;
        } else if (index >= slides.length) {
          // Nếu tới clone cuối -> nhảy về đầu thật
          track.style.transition = "none";
          index = 0;
          track.style.transform = `translateX(-${(index + 1) * 100}%)`;
        }
        currentIndex = index;
        setTimeout(() => (isAnimating = false), 50);
      },
      { once: true }
    );
  }

  window.nextSlide = function () {
    goToSlide(currentIndex + 1, "right");
  };

  window.prevSlide = function () {
    goToSlide(currentIndex - 1, "left");
  };
});
// Cuộn mượt xuống phần bộ sưu tập
document.addEventListener("DOMContentLoaded", () => {
  const btn = document.getElementById("scrollToGallery");
  const gallery = document.getElementById("gallery");

  if (!btn || !gallery) return;

  btn.addEventListener("click", (e) => {
    e.preventDefault();

    const galleryTop = gallery.getBoundingClientRect().top + window.scrollY - 40;
    window.scrollTo({
      top: galleryTop,
      behavior: "smooth",
    });
  });
});
// Cuộn mượt đến phần sản phẩm mới
document.addEventListener("DOMContentLoaded", () => {
  const btn = document.getElementById("scrollToProducts");
  const section = document.getElementById("newProducts");

  if (btn && section) {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      section.scrollIntoView({ behavior: "smooth" });
    });
  }
});
// Khi bấm "Khám phá ngay" → cuộn mượt đến phần sản phẩm mới
document.addEventListener("DOMContentLoaded", () => {
  const btn = document.getElementById("scrollToProducts");
  const section = document.getElementById("newProducts");

  if (btn && section) {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      section.scrollIntoView({ behavior: "smooth" });
    });
  }
});
// Slide tự động đổi banner chính + phụ
document.addEventListener("DOMContentLoaded", () => {
  const track = document.querySelector(".slider-track");
  const slides = document.querySelectorAll(".promo-group");
  let index = 0;

  function updateSlide() {
    track.style.transform = `translateX(-${index * 100}%)`;
  }

  function nextSlide() {
    index = (index + 1) % slides.length;
    updateSlide();
  }

  // Tự chuyển mỗi 6 giây
  setInterval(nextSlide, 5000);
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
    behavior: "smooth"
  });
});zz
