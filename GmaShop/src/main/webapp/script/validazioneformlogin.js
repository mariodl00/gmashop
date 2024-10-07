/**
 * 
 *// validazioneformlogin.js

document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("form");
    const emailInput = document.querySelector("input[name='login-email']");
    const passwordInput = document.querySelector("input[name='login-password']");

    // Funzione per visualizzare i messaggi di errore
    function showError(input, message) {
        const error = document.createElement("div");
        error.className = "error-message";
        error.innerText = message;
        input.parentNode.insertBefore(error, input.nextSibling);
        input.focus();
    }

    // Pulire i messaggi di errore precedenti
    function clearErrors() {
        const errorMessages = document.querySelectorAll(".error-message");
        errorMessages.forEach((error) => error.remove());
    }

    // Validare i campi del modulo
    function validateFields() {
        clearErrors();
        let isValid = true;

        // Validare l'email
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailInput.value.trim() || !emailRegex.test(emailInput.value)) {
            showError(emailInput, "Inserisci un indirizzo email valido.");
            isValid = false;
        }

        // Validare la password
        if (!passwordInput.value.trim()) {
            showError(passwordInput, "La password non deve essere vuota.");
            isValid = false;
        }

        return isValid;
    }

    // Gestire l'invio del modulo
    form.addEventListener("submit", function(event) {
        if (!validateFields()) {
            event.preventDefault(); // Impedire l'invio del modulo
        }
    });

    // Validare i campi al termine dell'input
    emailInput.addEventListener("blur", validateFields);
    passwordInput.addEventListener("blur", validateFields);
});
