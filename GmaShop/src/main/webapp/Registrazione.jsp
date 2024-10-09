<%@ page import= "gmashopmodel.*" %>
<%@ page import= "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    UserModel auth = (UserModel) request.getSession().getAttribute("auth");
    if(auth != null) {
        response.sendRedirect("index.jsp");
    }
    
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if(cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Registrazione</title>
 	<%@include file="/includes/head.jsp"%>
    <link rel="stylesheet" type="text/css" href="css/Register.css">
    <script src="script/validazioneregistrazione.js"></script> <!-- Collegamento al tuo script di validazione -->
    

</head>

<body>
    <div class="form-container">
     <div class="card w-50 mx-auto my-5">
        <h2>Registrati</h2>
        <form id="registration-form" action="user-register" method="POST">
            <div class="form-group">
                <label for="name">Nome:</label>
                <input type="text" id="registration-name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" id="registration-email" name="email" required>
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
