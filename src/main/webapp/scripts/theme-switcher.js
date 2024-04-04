function getThemeCookieValue() {
    return document.cookie
        .split("; ")
        .find((row) => row.startsWith("theme="))
        ?.split("=")[1];
}
if (getThemeCookieValue() === "dark") {
    document.getElementsByTagName("html")[0].setAttribute("data-bs-theme", "dark")
    document.getElementById("theme-switcher").firstElementChild.classList.add("bi-sun")
    document.getElementById("theme-switcher").firstElementChild.classList.remove("bi-moon")
}

document.getElementById("theme-switcher").addEventListener("click", function () {
    if (getThemeCookieValue() === "dark") {
        document.cookie = "theme=light; path=/; max-age=31536000"
        document.getElementsByTagName("html")[0].setAttribute("data-bs-theme", "light")
        document.getElementById("theme-switcher").firstElementChild.classList.remove("bi-sun")
        document.getElementById("theme-switcher").firstElementChild.classList.add("bi-moon")
    } else {
        document.cookie = "theme=dark; path=/; max-age=31536000"
        document.getElementsByTagName("html")[0].setAttribute("data-bs-theme", "dark")
        document.getElementById("theme-switcher").firstElementChild.classList.add("bi-sun")
        document.getElementById("theme-switcher").firstElementChild.classList.remove("bi-moon")
    }
})
