<%@ page import= "gmashopmodel.Product" %>
<%@ page import= "DAO.ProductDao" %>
<%@ page import= "gmashopconnection.DBcon" %>
<%@ page import= "gmashopmodel.UserModel" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
    // Verifica che l'utente sia autenticato
    UserModel auth = (UserModel) request.getSession().getAttribute("auth");
    if (auth == null) {
        response.sendRedirect("login.jsp"); // Reindirizza se non autenticato
        return;
    }

    // Ottenere il prodotto da modificare
    ProductDao pd = new ProductDao(DBcon.getConnection());
    int productId = Integer.parseInt(request.getParameter("id"));
    Product product = pd.getSingleProduct(productId);
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica Prodotto</title>
    <%@include file="/includes/HeadAmm.jsp"%>			
    <!-- Includi il file CSS esterno -->
    <link rel="stylesheet" type="text/css" href="css/Edit-product.css">
    <!-- Includi il file JavaScript per la validazione -->
    <script src="script/validazioneformedit.js"></script>
</head>
<body>
    <div class="container">
    <div class="card">
        <h2 class="my-3">Modifica Prodotto</h2>
        <form action="update-product" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
            <!-- Campo nascosto con l'ID del prodotto -->
            <input type="hidden" name="id" value="<%= product.getId() %>">

            <!-- Nome Prodotto -->
            <div class="form-group">
                <label for="name">Nome Prodotto</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= product.getName() %>" required>
            </div>

            <!-- Categoria -->
            <div class="form-group">
                <label for="category">Categoria</label>
                <input type="text" class="form-control" id="category" name="category" value="<%= product.getCategory() %>" required>
            </div>

            <!-- Prezzo -->
            <div class="form-group">
                <label for="price">Prezzo</label>
                <input type="number" step="0.01" class="form-control" id="price" name="price" value="<%= product.getPrice() %>" required>
            </div>

            <!-- Immagine -->
            <div class="form-group">
                <label for="image">Immagine</label>
                <input type="file" class="form-control" id="image" name="image">
                <%-- Mostra l'immagine esistente solo se disponibile --%>
                <% if (product.getImage() != null && !product.getImage().isEmpty()) { %>
                    <img src="product-images/<%= product.getImage() %>" alt="Immagine prodotto" class="product-image">
                <% } %>
	</div>
	</div>
            <!-- Pulsante di invio -->
            <button type="submit" class="btn btn-primary">Salva Modifiche</button>
        </form>
    </div>

    <%@include file="/includes/footer.jsp"%> <!-- Inclusione del footer -->
</body>
</html>
