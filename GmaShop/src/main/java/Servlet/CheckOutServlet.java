package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.OrderDao;
import gmashopconnection.DBcon;
import gmashopmodel.Cart;
import gmashopmodel.Order;
import gmashopmodel.UserModel;

@WebServlet("/cart-check-out")
public class CheckOutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter outPrintWriter = response.getWriter()) {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            
            // Recupera tutti i prodotti nel carrello
            ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
            
            // Autenticazione dell'utente
            UserModel auth = (UserModel) request.getSession().getAttribute("auth");
            
            // Verifica che l'utente sia autenticato e che ci siano prodotti nel carrello
            if (cart_list != null && auth != null) {
                // Genera un ID unico per tutti gli ordini di questa sessione di checkout
                String orderGroupId = UUID.randomUUID().toString(); // ID di gruppo unico
                
                // Istanzia la classe DAO
                OrderDao oDao = new OrderDao(DBcon.getConnection());
                
                for (Cart c : cart_list) {
                    Order order = new Order();
                    order.setId(c.getId()); // Questo è l'ID del prodotto, non quello dell'ordine
                    order.setUid(auth.getId());
                    order.setQuantity(c.getQuantity());
                    order.setDate(formatter.format(date));
                    order.setGroupId(orderGroupId); // Assegna lo stesso ID di gruppo
                    
                    // Chiama il metodo di inserimento
                    boolean result = oDao.insertOrder(order);
                    if (!result) {
                        System.out.println("Ordine non inserito");
                    }
                }
                
                // Salva l'ultimo groupId nella sessione per recuperarlo nella pagina di checkout
                request.getSession().setAttribute("lastOrderGroupId", orderGroupId);
                
                // Reindirizza l'utente alla pagina di checkout
                response.sendRedirect("checkout.jsp");
                
                // Svuota il carrello dopo il checkout
                cart_list.clear();
            } else {
                if (auth == null) {
                    response.sendRedirect("login.jsp");
                } else {
                    response.sendRedirect("cart_list.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
