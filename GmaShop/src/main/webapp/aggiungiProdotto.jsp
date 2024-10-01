<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Inserisci Nuovo Prodotto</title>
    
    <link rel="stylesheet" type="text/css" href="css/Index.css">
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        // AJAX function example for adding product
        $('#addProductForm').submit(function(event) {
            event.preventDefault();  // Prevent form submission
            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    $('#responseMessage').html(response);  // Display server response
                },
                error: function() {
                    alert('Error while adding product.');
                }
            });
        });
    });
</script>

</body>
</html>

