<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import= "gmashopmodel.UserModel" %>
<%@ page import= "gmashopconnection.DBcon" %>
<%@ page import= "DAO.ProductDao" %>

<%
    // Verifica autenticazione
    UserModel auth = (UserModel) request.getSession().getAttribute("auth");
    if (auth == null) {
        response.sendRedirect("login.jsp"); // Reindirizza alla pagina di login se non autenticato
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inserisci Nuovo Prodotto</title>
    <%@include file="/includes/HeadAmm.jsp"%>
    <!-- Includi il CSS esterno -->
    <link rel="stylesheet" type="text/css" href="css/Add-product.css">
    <!-- JavaScript per la validazione -->
    <script src="script/validazioneforminsert.js"></script>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2>Inserisci Nuovo Prodotto</h2>
            <form action="insert-product" method="post" enctype="multipart/form-data">
                <!-- Nome del Prodotto -->
                <div class="form-group">
                    <label for="name">Nome del Prodotto</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>

                <!-- Categoria del Prodotto -->
                <div class="form-group">
                    <label for="category">Categoria</label>
                    <input type="text" id="category" name="category" class="form-control" required>
                </div>

                <!-- Prezzo del Prodotto -->
                <div class="form-group">
                    <label for="price">Prezzo</label>
                    <input type="number" id="price" name="price" class="form-control" step="0.01" required>
                </div>

                <!-- Immagine del Prodotto -->
                <div class="form-group">
                    <label for="image">Immagine del Prodotto</label>
                    <input type="file" id="image" name="image" class="form-control-file" required>
                </div>

                <!-- Pulsante di invio -->
                <button type="submit" class="btn btn-primary">Aggiungi Prodotto</button>
            </form>
        </div>
    </div>
    
    <%@include file="/includes/footer.jsp" %> <!-- Inclusione del footer -->
</body>
</html>
