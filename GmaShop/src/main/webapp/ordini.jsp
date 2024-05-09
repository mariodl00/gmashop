

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
<title>Ordine</title>
<%@include file="/includes/head.jsp"%>

</head>
<body>
	<h1>Hello world</h1>
	<%@include file="/includes/footer.jsp"%>
</body>
</html>