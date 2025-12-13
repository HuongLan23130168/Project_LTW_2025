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

        optionsDiv.style.display = isHidden ? "block" : "none";

        icon.style.transform = isHidden ? "rotate(180deg)" : "rotate(0deg)";
      });
    }
  });
});
