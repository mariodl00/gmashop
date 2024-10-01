<%@ page import= "gmashopmodel.*" %>
<%@ page import= "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	UserModel auth = (UserModel) request.getSession().getAttribute("auth");
	if(auth!=null)
		response.sendRedirect("index.jsp");
	
	ArrayList<Cart> cart_list=(ArrayList <Cart>) session.getAttribute("cart-list");
	if(cart_list!=null) {
		request.setAttribute("cart_list", cart_list);
	}
	%>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<%@include file="/includes/head.jsp"%>
 <link rel="stylesheet" type="text/css" href="css/Login.css">

</head>
<body>
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">User Login</div>
			<div class="card-body">
				<form action="user-login" method="post">
					<div class="form-group">
						<label>Email address</label> 
						<input type="email" name="login-email" class="form-control" placeholder="Enter email">
					</div>
					<div class="form-group">
						<label>Password</label> 
						<input type="password" name="login-password" class="form-control" placeholder="Password">
					</div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</form>
			</div>
		</div>
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