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
        // Recupera i parametri dal form
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        Part imagePart = request.getPart("image");
        String imageName = extractFileName(imagePart);

        if (imageName.isEmpty()) {
            response.sendRedirect("error.jsp"); 
            return;
        }

        
        String savePath = "C:/Users/mario/git/gmashop21/GmaShop/src/main/webapp/product-images/" + imageName;

        
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.getParentFile().exists()) {
            fileSaveDir.getParentFile().mkdirs(); 
        }

        try {
            
            imagePart.write(savePath);
            

            
            Product product = new Product();
            product.setName(name);
            product.setCategory(category);
            product.setPrice(price);
            product.setImage(imageName);

            // Salva il prodotto nel database
            ProductDao productDao = new ProductDao(DBcon.getConnection());
            productDao.insertProduct(product);
            response.sendRedirect("indexAmm.jsp");
        } catch (IOException | SQLException | ClassNotFoundException e) {
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
                return filename.replaceAll("\\s+", "_"); 
            }
        }
        return "";
    }
}