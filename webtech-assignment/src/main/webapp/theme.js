document.addEventListener("DOMContentLoaded", function () {

    const themeToggle = document.getElementById("themeToggle");

    if (!themeToggle) {
        return;
    }

    const savedTheme = localStorage.getItem("campusCollabTheme");

    if (savedTheme === "dark") {
        document.body.classList.add("dark-mode");
        themeToggle.textContent = "☀";
    } else {
        themeToggle.textContent = "☾";
    }


    themeToggle.addEventListener("click", function () {

        document.body.classList.toggle("dark-mode");

        if (document.body.classList.contains("dark-mode")) {

            localStorage.setItem("campusCollabTheme", "dark");

            themeToggle.textContent = "☀";

        } else {

            localStorage.setItem("campusCollabTheme", "light");

            themeToggle.textContent = "☾";
        }

    });

});