import app from './WEB-INF/app.js';

document.addEventListener("DOMContentLoaded", () => {
    const root = document.getElementById('root');

    if (root && typeof app === "function") {
        root.innerHTML = app();
    } else {
        console.error("app is not a function or root is missing");
    }
});
