<%@page import="DAO.ProductDao"%>
<%@page import="java.util.*"%>
<%@page import="gmashopconnection.DBcon"%>
<%@page import="gmashopmodel.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    UserModel auth = (UserModel) request.getSession().getAttribute("auth");

    if (auth == null) {
        response.sendRedirect("login.jsp"); // Reindirizza se non autenticato
        return;
    }

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    double total = 0.0;

    if (cart_list != null) {
        ProductDao pDao = new ProductDao(DBcon.getConnection());
        cartProduct = pDao.getCartProducts(cart_list);
        total = pDao.getTotalCartPrice(cart_list);
        request.setAttribute("cart_list", cart_list);
        request.setAttribute("total", total);
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrello</title>
    <%@include file="/includes/head.jsp"%>
    <!-- Include il CSS esterno -->
    <link rel="stylesheet" type="text/css" href="css/Cart.css">
</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-between py-3">
            <h3>Totale Euro: <%= (total > 0) ? dcf.format(total) : "0.00" %></h3>
            <div>
                <a class="btn btn-primary mx-2" href="cart-check-out">Acquista Ora</a>
                <a class="btn btn-danger mx-2" href="cart-delete">Svuota Carrello</a>
            </div>
        </div>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">Nome</th>
                    <th scope="col">Categoria</th>
                    <th scope="col">Prezzo</th>
                    <th scope="col">Quantita</th>
                    <th scope="col">Azione</th>
                </tr>
            </thead>
            <tbody>
            <% if (cartProduct != null) {
                for (Cart c : cartProduct) { %>
                    <tr>
                        <td><%= c.getName() %></td>
                        <td><%= c.getCategory() %></td>
                        <td>Euro: <%= dcf.format(c.getPrice()) %></td>
                        <td>
                            <form action="order-now" method="post" class="d-flex align-items-center">
                                <input type="hidden" name="id" value="<%= c.getId() %>">
                                <a class="btn btn-sm btn-incre" href="quantity-inc-dec?action=inc&id=<%= c.getId() %>">
                                    <i class="fas fa-plus-square"></i>
                                </a>
                                <input type="text" name="quantity" class="form-control text-center mx-2 w-50" value="<%= c.getQuantity() %>" readonly>
                                <a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=<%= c.getId() %>">
                                    <i class="fas fa-minus-square"></i>
                                </a>
                            </form>
                        </td>
                        <td>
                            <a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%= c.getId() %>">Rimuovi</a>
                        </td>
                    </tr>
            <%   }
               } else { %>
                <tr>
                    <td colspan="5" class="text-center">Il carrello è vuoto.</td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>
