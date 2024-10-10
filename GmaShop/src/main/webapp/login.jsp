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
<html>
<head>
    <title>Login</title>
    <%@include file="/includes/head.jsp"%>
    <link rel="stylesheet" type="text/css" href="css/Login.css">
     <script src="script/validazionelogin.js"></script> <!-- Collegamento al tuo script di validazione -->
</head>
<body>
    <div class="form-container">
     <div class="card w-50 mx-auto my-5">
        <h2>Login</h2>
        <form id="login-form" action="user-login" method="POST">
           
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" id="login-email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="login-password" name="password" required>
            </div>
            <div class="form-group">
                <button type="submit">Login</button>
            </div>
        </form>
        <p>Non hai un account? <a href="Registrazione.jsp">Registrati</a></p>
    </div>
</body>
</html>