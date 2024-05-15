<%@ page import= "gmashopmodel.Product" %>
<%@ page import= "java.util.List" %>
<%@ page import= "gmashopconnection.DBcon" %>
<%@ page import= "gmashopmodel.UserModel" %>
<%@ page import= "DAO.ProductDao" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%
	UserModel auth = (UserModel) request.getSession().getAttribute("auth");
	if(auth!=null) {
		request.setAttribute("auth", auth);
	}
	ProductDao pd=new ProductDao(DBcon.getConnection());
	List<Product> products = pd.getAllProducts();
	%>

<!DOCTYPE html>
<html>
<head>
<title>E-Commerce Cart</title>
	<%@include file="/includes/head.jsp"%>

</head>
<body>
	<div class = "container">
	<div class = "card-header my-3">All Products</div>
	<div class = "row">
	<% 
		if(!products.isEmpty()){
			for(Product p:products){ %>
				<div class = "col-md-3">
				<div class="card w-100" style="width: 18rem;">
			  <img class="card-img-top" src="product-images/<%= p.getImage() %>" alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title"><%= p.getName() %></h5>
			    <h6 class = "price">Prezzo: Euro <%= p.getPrice() %> </h6>
			    <h6 class = "category"> Categoria: <%= p.getCategory() %> </h6>
			    <div class = "mt-3 d-flex justify-content-between">
			    <a href="add-to-cart?id=<%= p.getId() %>" class="btn btn-primary">Carrello</a>
			    <a href="#" class="btn btn-primary">Acquista</a></div>
			  </div>
			</div>
				</div>
			<%}
		}
	%>
	
	</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>