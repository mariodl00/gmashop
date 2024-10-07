package Servlet;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import DAO.ProductDao;
import gmashopconnection.DBcon;
import gmashopmodel.Product;

@WebServlet("/update-product")
@MultipartConfig
public class EditProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        
        // Dichiarazione delle variabili per gestire le eccezioni
        ProductDao productDao = null;
        Product existingProduct = null;
        String imageName = null;

        try {
            // Recupera l'immagine esistente dal database
            productDao = new ProductDao(DBcon.getConnection());
            existingProduct = productDao.getSingleProduct(productId);
            imageName = existingProduct.getImage(); // Immagine esistente

            Part imagePart = request.getPart("image");

            // Controlla se è stata caricata una nuova immagine
            if (imagePart != null && imagePart.getSize() > 0) {
                // Se c'è un file, estrai il nome e salva l'immagine
                imageName = imagePart.getSubmittedFileName();
                String savePath = "C:\\Users\\mario\\git\\gmashop13\\GmaShop\\src\\main\\webapp\\product-images\\" + imageName;
                File fileSaveDir = new File("C:\\Users\\mario\\git\\gmashop13\\GmaShop\\src\\main\\webapp\\product-images");
                if (!fileSaveDir.exists()) {
                    fileSaveDir.mkdirs();
                }
                imagePart.write(savePath);
            }

            // Crea un oggetto Product con i nuovi valori, mantenendo l'immagine esistente se non è stata cambiata
            Product product = new Product(productId, name, category, price, imageName);
            productDao.updateProduct(product); // Aggiorna il prodotto

            response.sendRedirect("indexAmm.jsp");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Reindirizza a una pagina di errore
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Reindirizza a una pagina di errore
        }
    }
}
