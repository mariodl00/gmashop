<%@ page import= "gmashopconnection.DBcon" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html>
<head>
<title>E-Commerce Cart</title>
	<%@include file="/includes/head.jsp"%>

</head>
<body>
	<% out.print(DBcon.getConnection());%>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>