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
    
    <link rel="stylesheet" type="text/css" href="css/Add-product.css">
    
    <script src="script/validazioneforminsert.js"></script>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2>Inserisci Nuovo Prodotto</h2>
            <form action="insert-product" method="post" enctype="multipart/form-data">
               
                <div class="form-group">
                    <label for="name">Nome del Prodotto</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="category">Categoria</label>
                    <input type="text" id="category" name="category" class="form-control" onkeyup="getSuggestions(this.value)" required>
                    <div id="suggestions" class="suggestions-box"></div> <!-- Div per mostrare i suggerimenti -->
                </div>

                <div class="form-group">
                    <label for="price">Prezzo</label>
                    <input type="number" id="price" name="price" class="form-control" step="0.01" required>
                </div>

                <div class="form-group">
                    <label for="image">Immagine del Prodotto</label>
                    <input type="file" id="image" name="image" class="form-control-file" required>
                </div>

                <button type="submit" class="btn btn-primary">Aggiungi Prodotto</button>
            </form>
        </div>
    </div>
    
    <%@include file="/includes/footer.jsp" %>

    <script>
        function getSuggestions(query) {
            if (query.length === 0) {
                document.getElementById("suggestions").innerHTML = "";
                return;
            }
            const xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("suggestions").innerHTML = xhr.responseText;
                }
            };
            xhr.open("GET", "Category-suggestions.jsp?query=" + encodeURIComponent(query), true);
            xhr.send();
        }
    </script>

    <style>
        .suggestions-box {
            border: 1px solid #ddd;
            background-color: #fff;
            max-height: 150px;
            overflow-y: auto;
            position: absolute;
            z-index: 1000;
            width: calc(100% - 20px);
        }
        .suggestion-item {
            padding: 8px;
            cursor: pointer;
        }
        .suggestion-item:hover {
            background-color: #f0f0f0;
        }
    </style>
</body>
</html>