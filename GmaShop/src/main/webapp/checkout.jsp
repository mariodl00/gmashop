<%@ page import="java.util.List" %>
<%@ page import="gmashopmodel.Order" %>
<%@ page import="DAO.OrderDao" %>
<%@ page import="gmashopconnection.DBcon" %>
<%@ page import="gmashopmodel.UserModel" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conferma Ordine - GMAShop</title>
    <link rel="stylesheet" type="text/css" href="css/CheckOut.css">
    <%@include file="/includes/head.jsp"%>
</head>
<body>

<%
    // Recupera l'utente autenticato
    UserModel auth = (UserModel) session.getAttribute("auth");

    // Recupera l'ID di gruppo dell'ultimo ordine
    String lastOrderGroupId = (String) session.getAttribute("lastOrderGroupId");

    if (lastOrderGroupId != null && auth != null) {
        // Recupera la connessione al database
        OrderDao oDao = new OrderDao(DBcon.getConnection());
        
        // Recupera gli ordini relativi a questo groupId
        List<Order> orders = oDao.getOrdersByGroupId(lastOrderGroupId);
        
        if (orders != null && !orders.isEmpty()) {
%>
    <div class="confirmation-message">
        <h2>Grazie per il tuo acquisto, <%= auth.getName() %>!</h2> <!-- Ottieni il nome dell'utente -->
        <p>Il tuo ordine è stato confermato con successo. Ecco i dettagli dei tuoi prodotti acquistati:</p>
    </div>

    <h3>Prodotti acquistati:</h3>
    <ul class="order-list">
        <% for (Order order : orders) { %>
            <li>
                <strong>Prodotto:</strong> <%= order.getName() %> - 
                <strong>Quantità:</strong> <%= order.getQuantity() %> - 
                <strong>Prezzo:</strong> <%= order.getPrice() %>€
            </li>
        <% } %>
    </ul>

    <div class="thanks-message">
        <p>Siamo entusiasti di averti come cliente e ci auguriamo che i tuoi acquisti ti portino tanta soddisfazione!</p>
        <p>Se hai domande, non esitare a contattare il nostro servizio clienti.</p>
    </div>

<%
        } else {
%>
    <p class="no-order-message">Nessun prodotto trovato per questo ordine. Se pensi che ci sia un errore, ti preghiamo di contattarci.</p>
<%
        }
    } else {
%>
    <p class="no-order-message">Nessun ordine recente trovato. Controlla il tuo account o effettua un nuovo ordine.</p>
<%
    }
%>

</body>
</html>
