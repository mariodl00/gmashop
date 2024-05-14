<%@ page import= "gmashopconnection.DBcon" %>
<%@ page import= "gmashopmodel.UserModel" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%
	UserModel auth = (UserModel) request.getSession().getAttribute("auth");
	if(auth!=null)
		request.setAttribute("auth", auth);
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
	<div class = "col-md-3">
	<div class="card w-100" style="width: 18rem;">
  <img class="card-img-top" src="product-images/t-shirt.jpg" alt="Card image cap">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <h6 class = "price"> Prezzo: 2$</h6>
    <h6 class = "category"> Categoria: some category </h6>
    <div class = "mt-3 d-flex justify-content-between">
    <a href="#" class="btn btn-primary">Carrello</a>
    <a href="#" class="btn btn-primary">Acquista</a></div>
  </div>
</div>
	</div>
	</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>