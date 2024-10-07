// validazioneformedit.js

function validateForm() {
    const nameField = document.getElementById("name");
    const categoryField = document.getElementById("category");
    const priceField = document.getElementById("price");

    // Pulire i messaggi di errore precedenti
    clearErrors();

    let isValid = true;

    // Funzione per mostrare i messaggi di errore
    function showError(input, message) {
        const error = document.createElement("div");
        error.className = "error-message";
        error.innerText = message;
        input.parentNode.insertBefore(error, input.nextSibling);
        input.focus(); // Porta il cursore sul campo
        isValid = false; // Indica che ci sono errori
    }

    // Controlla se i campi sono vuoti
    if (!nameField.value.trim()) {
        showError(nameField, "Il nome del prodotto non deve essere vuoto.");
    }

    if (!categoryField.value.trim()) {
        showError(categoryField, "La categoria non deve essere vuota.");
    }

    const priceValue = parseFloat(priceField.value);
    if (isNaN(priceValue) || priceValue <= 0) {
        showError(priceField, "Il prezzo non deve essere inferiore o uguale a 0.");
    }

    return isValid; // Ritorna true se non ci sono errori
}

// Funzione per pulire i messaggi di errore
function clearErrors() {
    const errorMessages = document.querySelectorAll(".error-message");
    errorMessages.forEach((error) => error.remove());
}
