package Servlet;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gmashopconnection.DBcon;
import DAO.*;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try(PrintWriter out = response.getWriter()) {
            String id = request.getParameter("id");
            String startDate = request.getParameter("start_date");
            String endDate = request.getParameter("end_date");
            String customerId = request.getParameter("customer_id");

            if(id != null) {
                OrderDao orderDao = new OrderDao(DBcon.getConnection());
                orderDao.cancelOrder(Integer.parseInt(id));
             // Reindirizzare a orders.jsp con i parametri del form
                response.sendRedirect("orders.jsp?start_date=" + startDate + "&end_date=" + endDate + "&customer_id=" + customerId);
            }

            
        } catch (ClassNotFoundException|SQLException e) {
            e.printStackTrace();
        }
    }
}
