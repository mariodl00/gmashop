<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione</title>
    <link rel="stylesheet" type="text/css" href="css/Register.css">
    <script src="script/validazioneregistrazione.js"></script> <!-- Collegamento al tuo script di validazione -->
    

</head>
<body>
    <div class="form-container">
        <h2>Registrati</h2>
        <form id="registration-form" action="user-register" method="POST">
            <div class="form-group">
                <label for="name">Nome:</label>
                <input type="text" id="registration-name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="registration-email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="registration-password" name="password" required>
            </div>
            <div class="form-group">
                <button type="submit">Registrati</button>
            </div>
        </form>
        <p>Hai già un account? <a href="login.jsp">Accedi</a></p>
    </div>
</body>
</html>
