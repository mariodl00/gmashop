<%@ page import= "java.util.*" %>
<%@ page import= "gmashopconnection.DBcon" %>
<%@ page import= "java.text.DecimalFormat" %>
<%@ page import= "gmashopmodel.*" %>
<%@ page import= "DAO.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
UserModel auth = (UserModel) request.getSession().getAttribute("auth");
List<Order> orders = null;
if(auth != null) {
    request.setAttribute("auth", auth);
    String startDate = request.getParameter("start_date");
    String endDate = request.getParameter("end_date");
    String selectedCustomerId = request.getParameter("customer_id");

    OrderDao orderDao = new OrderDao(DBcon.getConnection());

    // Se sono presenti filtri di data o cliente
    if (startDate != null && endDate != null && selectedCustomerId != null) {
        orders = orderDao.getOrdersByDateAndCustomer(startDate, endDate, Integer.parseInt(selectedCustomerId));
    } else {
        orders = orderDao.userOrders(auth.getId()); // Ordini standard dell'utente loggato
    }
} else {
    response.sendRedirect("login.jsp");
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if(cart_list != null) {
    request.setAttribute("cart_list", cart_list);
}
%>


<!DOCTYPE html>
<html>
<head>
    <title>Ordine</title>
    <!-- Collegamento al file CSS esterno -->
    <link rel="stylesheet" type="text/css" href="css/Orders.css">
    <%@include file="/includes/HeadAmm.jsp"%>
</head>
<body>
    <div class="container">
        <div class="card-header my-3">Filtra Ordini</div>
        
        <!-- Form per filtrare per data e cliente -->
        <!-- Form per filtrare per data e cliente -->
<form method="get" action="orders.jsp">
    <div class="form-row">
        <div class="form-group col-md-3">
            <label for="start_date">Data Inizio</label>
            <input type="date" class="form-control" id="start_date" name="start_date"
                   value="<%= request.getParameter("start_date") != null ? request.getParameter("start_date") : "" %>" required>
        </div>
        <div class="form-group col-md-3">
            <label for="end_date">Data Fine</label>
            <input type="date" class="form-control" id="end_date" name="end_date"
                   value="<%= request.getParameter("end_date") != null ? request.getParameter("end_date") : "" %>" required>
        </div>
        <div class="form-group col-md-3">
            <label for="customer_id">Cliente</label>
            <select class="form-control" id="customer_id" name="customer_id" required>
                <option value="">Seleziona Cliente</option>
                <% 
                List<UserModel> customers = new Userdao(DBcon.getConnection()).getAllCustomers();
                for(UserModel customer : customers) {
                    String selected = request.getParameter("customer_id") != null && 
                                      request.getParameter("customer_id").equals(String.valueOf(customer.getId())) ? "selected" : "";
                %>
                <option value="<%= customer.getId() %>" <%= selected %>><%= customer.getName() %></option>
                <% } %>
            </select>
        </div>
        <div class="form-group col-md-3">
            <label>&nbsp;</label>
            <button type="submit" class="btn btn-primary form-control">Filtra</button>
        </div>
    </div>
</form>


        <div class="card-header my-3">Tutti gli Ordini</div>
        <table class="table table-light">
            <thead>
                <tr>
                    <th scope="col">Data</th>
                    <th scope="col">Nome Prodotto</th>
                    <th scope="col">Categoria</th>
                    <th scope="col">Quantità</th>
                    <th scope="col">Prezzo</th>
                    <th scope="col">Annulla</th>
                </tr>
            </thead>
            <tbody>
            <%
            if(orders != null) {
                for(Order o : orders) {
            %>
            <tr>
                <td><%= o.getDate() %> </td>
                <td><%= o.getName() %> </td>
                <td><%= o.getCategory() %> </td>
                <td><%= o.getQuantity() %> </td>
                <td><%= dcf.format(o.getPrice()) %></td>
                <td>
				    <a class="btn btn-sm btn-danger" 
				       href="cancel-order?id=<%= o.getOrderid() %>&start_date=<%= request.getParameter("start_date") %>&end_date=<%= request.getParameter("end_date") %>&customer_id=<%= request.getParameter("customer_id") %>">
				       Annulla Ordine
				    </a>
				</td>
                
            </tr>
            <% 
                }
            }
            %>
            </tbody>
        </table>
    </div>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>
