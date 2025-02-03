export default class Form extends HTMLElement {
    constructor() {
        super();
        this.innerHTML = `
            <form id="customForm">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
                <button type="submit">Submit</button>
            </form>
            <p id="responseMessage"></p>
        `;

        this.querySelector("#customForm").addEventListener("submit", async (event) => {
            event.preventDefault();

            const name = this.querySelector("#name").value;
            const responseMessage = this.querySelector("#responseMessage");

            const response = await fetch("/submit-form", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `name=${encodeURIComponent(name)}`
            });

            const result = await response.text();
            responseMessage.innerHTML = result;
        });
    }
}

customElements.define("custom-form", Form);
