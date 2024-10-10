function validateLoginForm(event) {
    // Prevenire l'invio del form fino alla validazione
    event.preventDefault();

    // Ottieni i valori dai campi del form
    const email = document.getElementById("login-email");
    const password = document.getElementById("login-password");
  	
	clearErrors();
    // Variabile per controllare la validità del form
    let isValid = true;


    // Funzione per mostrare gli errori
    function showError(input, message) {
        const error = document.createElement("div");
        error.className = "error-message";
        error.innerText = message;
        input.parentNode.insertBefore(error, input.nextSibling);
        input.focus(); // Porta il cursore sul campo
        isValid = false; // Indica che ci sono errori
    }


    // Validazione campo email
    if (!email.value.trim()) {
        showError(email, "L'email non deve essere vuota.");
    } else if (!validateEmailFormat(email.value)) {
        showError(email, "Inserisci un'email valida.");
    }

    // Validazione campo password
    if (!password.value.trim()) {
        showError(password, "La password non deve essere vuota.");
    } else if (!validatePassword(password.value)) {
        showError(password, "La password deve contenere almeno 8 caratteri, inclusi una lettera maiuscola, una minuscola e un numero.");
    }

    // Se tutto è valido, invia il form
    if (isValid) {
        document.getElementById("registration-form").submit();
    }
}

// Funzione per validare il formato dell'email
function validateEmailFormat(email) {
    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return emailPattern.test(email);
}

// Funzione per validare la password
function validatePassword(password) {
    const passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
    return passwordPattern.test(password);
}

// Funzione per rimuovere gli errori precedenti
function clearErrors() {
    const errorMessages = document.querySelectorAll(".error-message");
    errorMessages.forEach((error) => error.remove());
}

// Aggiungi un listener per il submit del form
document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('login-form');
    loginForm.addEventListener('submit', validateLoginForm);
});
/**
 * 
 */