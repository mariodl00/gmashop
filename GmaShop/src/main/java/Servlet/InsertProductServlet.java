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

@WebServlet("/insert-product")
@MultipartConfig
public class InsertProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    
    	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	    String name = request.getParameter("name");
    	    String category = request.getParameter("category");
    	    double price = Double.parseDouble(request.getParameter("price"));
    	    Part imagePart = request.getPart("image");
    	    String imageName = extractFileName(imagePart);

    	    // Percorso fisso per salvare l'immagine
    	    String savePath = "C:\\Users\\Adriano\\git\\gmashop\\GmaShop\\src\\main\\webapp\\product-images" + imageName;


    	    // Salva il file
    	    imagePart.write(savePath);

    	    // Creazione del nuovo prodotto
    	    Product product = new Product();
    	    product.setName(name);
    	    product.setCategory(category);
    	    product.setPrice(price);
    	    product.setImage(imageName);

    	    try {
    	        ProductDao productDao = new ProductDao(DBcon.getConnection());
    	        productDao.insertProduct(product);
    	        response.sendRedirect("indexAmm.jsp");
    	    } catch (ClassNotFoundException | SQLException e) {
    	        e.printStackTrace();
    	        response.sendRedirect("error.jsp");
    	    }
    	}



    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                String filename = s.substring(s.indexOf("=") + 2, s.length() - 1);
                return filename.replaceAll("\\s+", "_");  // Sostituisci spazi con underscore
            }
        }
        return "";
    }
}
