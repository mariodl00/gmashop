package Servlet;



import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ProductDao;
import gmashopconnection.DBcon;

@WebServlet("/remove-product")
public class RemoveProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("id");
        
        if (productId != null) {
            try {
                ProductDao productDao = new ProductDao(DBcon.getConnection());
                productDao.removeProduct(Integer.parseInt(productId));
                response.sendRedirect("indexAmm.jsp");
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        } else {
            response.sendRedirect("indexAmm.jsp");
        }
    }
}

