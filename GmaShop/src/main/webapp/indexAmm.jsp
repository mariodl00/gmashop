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
    List<Product> products = pd.getAllProducts();
    
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>E-Commerce Catalog</title>
    <%@include file="/includes/HeadAmm.jsp"%>			
    <link rel="stylesheet" type="text/css" href="css/Index.css">
    <style>
        .btn-small {
            font-size: 0.8rem;
            padding: 0.3rem 0.5rem;
        }
        .btn-insert {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <h2 class="my-3">All Products</h2>
            
        </div>
        <div class="row">
            <% 
                if (!products.isEmpty()) {
                    for (Product p : products) { %>
                        <div class="col-md-3">
                            <div class="card w-100" style="width: 18rem;">
                                <img class="card-img-top" src="product-images/<%= p.getImage() %>" alt="Card image cap">
                                <div class="card-body">
                                    <h5 class="card-title"><%= p.getName() %></h5>
                                    <h6 class="price">Prezzo: Euro <%= p.getPrice() %> </h6>
                                    <h6 class="category"> Categoria: <%= p.getCategory() %> </h6>
                                    <div class="mt-3 d-flex justify-content-between">
                                       <a href="edit-product.jsp?id=<%= p.getId() %>" class="btn btn-warning btn-small">Modifica</a>
                                       
                                        <a href="remove-product?id=<%= p.getId() %>" class="btn btn-danger btn-small">Rimuovi</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <% }
                }
            %>
        </div>
    </div>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>


