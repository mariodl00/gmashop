package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ProductDao;
import gmashopconnection.DBcon;
import gmashopmodel.Product;

@WebServlet("/edit-product")
public class EditProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Recupera l'ID del prodotto dalla richiesta
        int productId = Integer.parseInt(request.getParameter("id"));

        try {
            // Ottieni il prodotto dal database utilizzando l'ID
            ProductDao productDao = null;
            try {
                productDao = new ProductDao(DBcon.getConnection());
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            Product product = productDao.getSingleProduct(productId);

            // Inoltra il prodotto alla pagina di modifica
            request.setAttribute("product", product);
            request.getRequestDispatcher("edit-product.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("indexAmm.jsp"); // Reindirizza alla home page in caso di errore
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Recupera i parametri dalla richiesta
        int productId = Integer.parseInt(request.getParameter("id")); // Modifica il nome del parametro da "productId" a "id"
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        String image = request.getParameter("image");

        // Crea un oggetto Product con i nuovi valori
        Product product = null;
        try {
            product = new Product(productId, name, category, price, image);
        } catch (Exception e1) {
            e1.printStackTrace();
        }

        try {
            // Aggiorna il prodotto nel database
            ProductDao productDao = null;
            try {
                productDao = new ProductDao(DBcon.getConnection());
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            productDao.updateProduct(product);

            // Reindirizza alla pagina indexAmm.jsp dopo la modifica
            response.sendRedirect("indexAmm.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("indexAmm.jsp"); // Reindirizza alla home page in caso di errore
        }
    }
}
