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
    <script src="script/validazionelogin.js"></script> <!-- Assicurati che questo percorso sia corretto -->
</head>
<body>
    <div class="container">
        <div class="card w-50 mx-auto my-5">
            <div class="card-header text-center">User Login</div>
            <div class="card-body">
                <form id="login-form" action="user-login" method="POST">
                    <div class="form-group">
                        <label>Email address</label> 
                        <input type="text" id="login-email" name="login-email" placeholder="Enter email">
                    </div>
                    <div class="form-group">
                        <label>Password</label> 
                        <input type="password" id="login-password" name="login-password" placeholder="Password">
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Login</button>
                    </div>
                </form> <!-- Chiusura corretta del form -->
                <p>Non hai un account? <a href="Registrazione.jsp">Registrati</a></p> <!-- Link per la registrazione -->
            </div>
        </div>
    </div>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>
