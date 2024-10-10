<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import= "gmashopmodel.Product" %>
<%@ page import= "java.util.*" %>
<%@ page import= "gmashopconnection.DBcon" %>
<%@ page import= "gmashopmodel.*" %>
<%@ page import= "DAO.*" %>

<%
    UserModel auth = (UserModel) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }
   
%>
    
<!DOCTYPE html>
<html>
<head>
    <title>Inserisci Nuovo Prodotto</title>
    <%@include file="/includes/HeadAmm.jsp"%>
    <link rel="stylesheet" type="text/css" href="css/IndexAmm.css">
    <script src="script/validazioneforminsert.js"></script>
</head>
<body>
    <div class="container">
        <h2 class="my-3">Inserisci Nuovo Prodotto</h2>
        <form action="insert-product" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="name">Nome del Prodotto</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="category">Categoria</label>
                <input type="text" class="form-control" id="category" name="category" required>
            </div>
            <div class="form-group">
                <label for="price">Prezzo</label>
                <input type="number" step="0.01" class="form-control" id="price" name="price" required>
            </div>
            <div class="form-group">
                <label for="image">Immagine del Prodotto</label>
                <input type="file" class="form-control-file" id="image" name="image" required>
            </div>
            <button type="submit" class="btn btn-primary">Aggiungi Prodotto</button>
        </form>
    </div>
    <%@include file="/includes/footer.jsp"%>



</body>
</html>

