
<%@page import="DAO.ProductDao"%>
<%@page import="java.util.*"%>
<%@ page import= "gmashopconnection.DBcon" %>
<%@ page import= "gmashopmodel.*" %>
<%@ page import= "java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%
	DecimalFormat dcf = new DecimalFormat("#.##");
	request.setAttribute("dcf", dcf);
	UserModel auth = (UserModel) request.getSession().getAttribute("auth");
	if(auth!=null)
		request.setAttribute("auth", auth);
	ArrayList<Cart> cart_list=(ArrayList <Cart>) session.getAttribute("cart-list");
	
	List <Cart> cartProduct=null;
	if(cart_list!=null) {
		ProductDao pDao= new ProductDao(DBcon.getConnection());
		cartProduct=pDao.getCartProducts(cart_list);
		Double total = pDao.getTotalCartPrice(cart_list);
		request.setAttribute("cart_list", cart_list);
		request.setAttribute("total", total);
	}
	
	%>

<!DOCTYPE html>
<html>
<head>
<title>Carrello</title>
<%@include file="/includes/head.jsp"%>
<style type="text-css">
.table tbody td{
vartical-align: middle;
}
.btn-incre, .btn-decre{
box-shadow: name;
font-size=25px;
}
</style>
</head>
<body>
	<div class= "container"> 
	<div class="d-flex py-3"><h3>Total Price: Euro ${ (total>0)?total:0  }</h3><a class="mx-3 btn btn-primary" href="cart-check-out">Check Out</a>
	</h3><a class="mx-3 btn btn-primary" href="cart-delete">Svuota</a>	</div>
	<table class="table table-loght">
	<thead> 
	<tr>
	<th scope="col"> Name</th>
	<th scope="col"> Category</th>
	<th scope="col"> Price</th>
	<th scope="col"> Buy Now</th>
	<th scope="col"> Cancel</th>
	</tr>
	</thead>
	<tbody>
	<%if(cart_list!=null) {
		for(Cart c:cartProduct) {%>
			<tr>
			<td><%=c.getName() %> </td>
			<td><%=c.getCategory()%> </td>
			<td><%=c.getPrice()%> </td>
			<td> 
			<form action="order-now" method="post" class="form-inline">
			<input type="hidden" name="id" value="<%=c.getId()%>" class="form-input">
			<div class="form-group d-flex justify-content-between w-50">
			<a class="btn bnt-sm btn-incre" href="quantity-inc-dec?action=inc&id=<%=c.getId()%>"><i class="fas fa-plus-square"></i></a> 
			<input type="text" name="quantity" class="form-control w-50"  value="<%=c.getQuantity()%>" readonly> 
			<a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=<%=c.getId()%>"><i class="fas fa-minus-square"></i></a>
			</div>
			<button type= "submit" class= "btn btn-primary btn-sm">Acquista</button>
			</form>
			</td>
			<td> <a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%= c.getId()%>">Remove</a></td>
			</tr>	
	<% }
	}
		%>
	
	
	</tbody>
	</table>
	</div>
	<%@include file="/includes/footer.jsp"%>


</body>
</html>