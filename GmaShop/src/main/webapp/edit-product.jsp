
<%@ page import= "gmashopmodel.Product" %>
<%@ page import= "java.util.*" %>
<%@ page import= "gmashopconnection.DBcon" %>
<%@ page import= "gmashopmodel.*" %>
<%@ page import= "DAO.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    UserModel auth = (UserModel) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }
    ProductDao pd = new ProductDao(DBcon.getConnection());
    int productId = Integer.parseInt(request.getParameter("id"));
    Product product = pd.getSingleProduct(productId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Modifica Prodotto</title>
    <%@include file="/includes/head.jsp"%>
    <link rel="stylesheet" type="text/css" href="css/Index.css">
    <script src="script/validazioneformedit.js"></script> <!-- Includi il file JavaScript -->
</head>
<body>
    <div class="container">
        <h2 class="my-3">Modifica Prodotto</h2>
        <form action="update-product" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <div class="form-group">
                <label for="name">Nome Prodotto</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= product.getName() %>" required>
            </div>
            <div class="form-group">
                <label for="category">Categoria</label>
                <input type="text" class="form-control" id="category" name="category" value="<%= product.getCategory() %>" required>
            </div>
            <div class="form-group">
                <label for="price">Prezzo</label>
                <input type="number" step="0.01" class="form-control" id="price" name="price" value="<%= product.getPrice() %>" required>
            </div>
            <div class="form-group">
                <label for="image">Immagine</label>
                <input type="file" class="form-control" id="image" name="image">
                <%-- Mostra l'immagine esistente --%>
                <% if (product.getImage() != null && !product.getImage().isEmpty()) { %>
                    <img src="product-images/<%= product.getImage() %>" alt="Immagine prodotto" style="max-width: 200px; max-height: 200px;">
                <% } %>
            </div>
            <button type="submit" class="btn btn-primary">Salva Modifiche</button>
        </form>
    </div>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>
